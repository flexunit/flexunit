/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.flexunit.runners {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.events.ExecutionCompleteEvent;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.runners.ChildRunnerSequencer;
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.internals.runners.model.EachTestNotifier;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.RunAftersClass;
	import org.flexunit.internals.runners.statements.RunBeforesClass;
	import org.flexunit.internals.runners.statements.StatementSequencer;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runner.manipulation.ISortable;
	import org.flexunit.runner.manipulation.ISorter;
	import org.flexunit.runner.manipulation.MetadataSorter;
	import org.flexunit.runner.manipulation.NoTestsRemainException;
	import org.flexunit.runner.manipulation.Sorter;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runner.notification.StoppedByUserException;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.runners.model.TestClass;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	use namespace classInternal;

/**
 * Provides most of the functionality specific to an IRunner that implements a
 * "parent node" in the test tree,
 * 
 *  //TODO: Does not define by a data type like in the java version
 *  //how do the matchups described below happen, or not, instead?
 *  with children defined by objects of some data
 * type {@code T}. (For <code> BlockJUnit4ClassRunner</code>, {@code T} is
 * <code> Method</code> . For <code> Suite</code>, {@code T} is <code> Class</code>.)
 * 
 *  Subclasses
 * must implement finding the children of the node, describing each child, and
 * running each child. ParentRunner will filter and sort children, handle
 * {@code BeforeClass} and {@code AfterClass} methods, create a composite
 * <code> Description</code>, and run children sequentially.
 */

	public class ParentRunner implements IRunner, ISortable {
		protected static const EACH_NOTIFIER:String = "eachNotifier";
		
		private var _testClass:TestClass;
		private var filterRef:Filter = null;
		private var sorter:ISorter = MetadataSorter.META;
		private var filteredChildren:Array;
		private var childrenFiltered:Boolean = false;
		
		private var cachedDescription:IDescription;
		
		/**
		 * Constructs a new {@code ParentRunner} that will run {@code TestClass}
		 * @throws InitializationError //TODO: does it throw an InitializationError?
		 */
		public function ParentRunner( klass:Class ) {
			this._testClass = new TestClass( klass );
			validate();
		}

		/**
		 * Returns a name used to describe this Runner
		 */
		protected function get name():String {
			return testClass.name;
		}

		/**
		 * Returns a <code> TestClass</code> object wrapping the class to be executed.
		 */
		protected function get testClass():TestClass {
			return _testClass;
		}

		public function get description():IDescription {
			
			if( !cachedDescription ) {
				//TODO: Have an issue here, this is trying to use a createSuiteDescription which needs metadata
				//this might be an issue here as I am now passing metaDatthrough all of the time.. not sure if anyone was counting on a null
				var description:IDescription = Description.createSuiteDescription( name, testClass.metadata ); //?testClass.metadata[ 0 ]:null );
				var filtered:Array = getFilteredChildren();
				var child:*;
	
				for ( var i:int=0; i<filtered.length; i++ ) {
					child = filtered[ i ];
					description.addChild( describeChild( child ) );
				}
				
				cachedDescription = description;
			}

			return cachedDescription;
		}

		/**
		 * Returns a list of objects that define the children of this Runner.
		 */
		protected function get children():Array {
			return null;
		}
	
		/**
		 * Returns a <code> Description</code> for {@code child}, which can be assumed to
		 * be an element of the list returned by <code> ParentRunner#children()</code>
		 */
		protected function describeChild( child:* ):IDescription {
			return null
		}

		/**
		 * Runs the test corresponding to {@code child}, which can be assumed to be
		 * an element of the list returned by <code> ParentRunner#children()</code>.
		 * Subclasses are responsible for making sure that relevant test events are
		 * reported through {@code notifier}
		 */
		protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
		
		}

		/** 
		 * Constructs an {@code IStatement} to run all of the tests in the test class. Override to add pre-/post-processing. 
		 * Here is an outline of the implementation:
		 * <ul>
		 * <li>Call <code> #runChild(Object, RunNotifier)} on each object returned by <code> #children()</code> (subject to any imposed filter and sort).</li>
		 * <li>ALWAYS run all non-overridden {@code BeforeClass} methods on this class
		 * and superclasses before the previous step; if any throws an
		 * Exception, stop execution and pass the exception on.
		 * <li>ALWAYS run all non-overridden {@code AfterClass} methods on this class
		 * and superclasses before any of the previous steps; all AfterClass methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from AfterClass methods into a
		 * <code> MultipleFailureException</code>.
		 * </ul>
		 * @param notifier
		 * @return {@code IStatement}
		 */
		protected function classBlock( notifier:IRunNotifier ):IAsyncStatement {
			var sequencer:StatementSequencer = new StatementSequencer();
			
			sequencer.addStep( withBeforeClasses() );
			sequencer.addStep( childrenInvoker( notifier ) );
			sequencer.addStep( withAfterClasses() );
			
			return sequencer;
		}

		/**
		 * Returns an <code> IStatement</code>: run all non-overridden {@code BeforeClass} methods on this class
		 * and superclasses before executing {@code statement}; if any throws an
		 * Exception, stop execution and pass the exception on.
		 */
		protected function withBeforeClasses():IAsyncStatement {
			var befores:Array = testClass.getMetaDataMethods( "BeforeClass" );
			//Sort the befores array
			befores.sort(compare);
			//this is a deviation from the java approach as we don't have the same type of method information
			var statement:IAsyncStatement = new RunBeforesClass( befores, testClass );
			return statement;
		}

		/**
		 * Returns an <code> IStatement</code>: run all non-overridden {@code AfterClass} methods on this class
		 * and superclasses before executing {@code statement}; all AfterClass methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from AfterClass methods into a
		 * <code> MultipleFailureException</code>.
		 */
		protected function withAfterClasses():IAsyncStatement {
			var afters:Array = testClass.getMetaDataMethods( "AfterClass" );
			//Sort the afters array
			afters.sort(compare);
			var statement:IAsyncStatement = new RunAftersClass( afters, testClass );
			return statement;
		}		

		private function validate():void {
			var errors:Array = new Array();
			collectInitializationErrors(errors);
			if (!(errors.length==0))
				throw new InitializationError(errors);
		}

		/**
		 * Adds to {@code errors} a throwable for each problem noted with the test class 
		 * (available from <code> #testClass()</code>).
		 * Default implementation adds an error for each method annotated with
		 * {@code BeforeClass} or {@code AfterClass} that is not
		 * {@code public static void} with no arguments.
		 */
		protected function collectInitializationErrors( errors:Array ):void {
			validatePublicVoidNoArgMethods( "BeforeClass", true, errors );
			validatePublicVoidNoArgMethods( "AfterClass", true, errors );
		}

		/**
		 * Adds to {@code errors} if any method in this class is annotated with
		 * {@code metaDataTag}, but:
		 * <ul>
		 * <li>is not public, or
		 * <li>takes parameters, or
		 * <li>returns something other than void, or
		 * <li>is static (given {@code isStatic is false}), or
		 * <li>is not static (given {@code isStatic is true}).
		 */
		protected function validatePublicVoidNoArgMethods( metaDataTag:String, isStatic:Boolean, errors:Array ):void {
			var methods:Array = testClass.getMetaDataMethods( metaDataTag  );
	
			var eachTestMethod:FrameworkMethod;
			for ( var i:int=0; i<methods.length; i++ ) {
				eachTestMethod = methods[ i ] as FrameworkMethod;
				eachTestMethod.validatePublicVoidNoArg( isStatic, errors );
			}
		}

		/**
		 * Returns an <code> IStatement</code>: Call <code> #runChild(Object, RunNotifier)</code>
		 * on each object returned by <code> #children()</code> (subject to any imposed
		 * filter and sort)
		 */
		protected function childrenInvoker( notifier:IRunNotifier ):IAsyncStatement {
			var children:Array = getFilteredChildren();

			return new ChildRunnerSequencer( children, runChild, notifier );
		}

		private function getFilteredChildren():Array {
			if(!childrenFiltered) {
				var filtered:Array = new Array();
				var child:*;
	
				for ( var i:int=0; i<children.length; i++ ) {
					child = children[ i ];
					if ( shouldRun( child ) ) {
						try {
							filterChild( child );
							sortChild( child );
							filtered.push( child );
						} catch ( error:Error ) {
							
						}
					}
				}
				
				filtered.sort(compare);
				filteredChildren = filtered;
				childrenFiltered = true;
			}
		
			return filteredChildren;
		}

		private function sortChild( child:* ):void {
			sorter.apply(child);
		}
		
		//Applies the sorter to an array
		protected function compare(o1:Object, o2:Object):int {
			return sorter.compare(describeChild(o1), describeChild(o2));
		};

		private function filterChild( child:* ):void {
 			if (filterRef != null)
				filterRef.apply(child);
		}

		private var currentEachNotifier:EachTestNotifier;
		public function run( notifier:IRunNotifier, parentToken:AsyncTestToken ):void {
			var testNotifier:EachTestNotifier = new EachTestNotifier(notifier, description );
			var resendError:Error;
			
			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = parentToken;
			token.addNotificationMethod( handleRunnerComplete );
			token[ EACH_NOTIFIER ] = testNotifier;

			try {
				var statement:IAsyncStatement = classBlock( notifier );
				statement.evaluate( token );
			} catch ( error:AssumptionViolatedException ) {
				resendError = error;
				testNotifier.fireTestIgnored();
			} catch ( error:StoppedByUserException ) {
				resendError = error;
				throw error;
			} catch ( error:Error ) {
				resendError = error;
				testNotifier.addFailure( error );
			}
			
			if ( resendError ) {
				parentToken.sendResult( resendError );
			}
		}
		
		private function handleRunnerComplete( result:ChildResult ):void {
			var error:Error = result.error;
			var token:AsyncTestToken = result.token;
			var eachNotifier:EachTestNotifier = result.token[ EACH_NOTIFIER ];
			
			if ( error is AssumptionViolatedException ) {
				eachNotifier.fireTestIgnored();
			} else if ( error is StoppedByUserException ) {
				throw error;
			} else if ( error ) {
				eachNotifier.addFailure( error );
			}
			
			token.parentToken.sendResult();
		}

		private function shouldRun( item:* ):Boolean {
			return filterRef == null || filterRef.shouldRun( describeChild( item ) );
		}

		public function filter( filter:Filter ):void {
			if(filter == this.filterRef)
				return;
			
			this.filterRef = filter;
			childrenFiltered = false;

			for ( var i:int=0; i<children.length; i++ ) {
				if ( shouldRun( children[ i ] ) ) {
					return;
				}
			}
			
			throw new NoTestsRemainException();
		}
		
		public function sort(sorter:ISorter):void {
			//Determine if the runner has already specified a ISorter besides the default META Sorter,
			//if it has, ignore the new ISorter.  This is to prevent a potential problem with a parent Runner
			//overwriting a child's non-default ISorter.
			if(MetadataSorter.META == this.sorter) {
				this.sorter = sorter;
				childrenFiltered = false;
			}
		}

		public function toString():String {
			return "ParentRunner";
		}
	}
}