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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.runners {
	import flash.events.EventDispatcher;
	
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
	import org.flexunit.runner.manipulation.NoTestsRemainException;
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
 * type {@code T}. (For {@link BlockJUnit4ClassRunner}, {@code T} is
 * {@link Method} . For {@link Suite}, {@code T} is {@link Class}.)
 * 
 *  Subclasses
 * must implement finding the children of the node, describing each child, and
 * running each child. ParentRunner will filter and sort children, handle
 * {@code @BeforeClass} and {@code @AfterClass} methods, create a composite
 * {@link Description}, and run children sequentially.
 */

	public class ParentRunner implements IRunner {
		protected static const EACH_NOTIFIER:String = "eachNotifier";
		
		private var _testClass:TestClass;
		private var filterRef:Filter = null;
		
		/**
		 * Constructs a new {@code ParentRunner} that will run {@code @TestClass}
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
		 * Returns a {@link TestClass} object wrapping the class to be executed.
		 */
		protected function get testClass():TestClass {
			return _testClass;
		}

		public function get description():IDescription {
			//TODO: Have an issue here, this is trying to use a createSuiteDescription which needs metadata
			var description:IDescription = Description.createSuiteDescription( name, testClass.metadata?testClass.metadata[ 0 ]:null );
			var filtered:Array = getFilteredChildren();
			var child:*;

			for ( var i:int=0; i<filtered.length; i++ ) {
				child = filtered[ i ];
				description.addChild( describeChild( child ) );
			}

			return description;
		}

		/**
		 * Returns a list of objects that define the children of this Runner.
		 */
		protected function get children():Array {
			return null;
		}
	
		/**
		 * Returns a {@link Description} for {@code child}, which can be assumed to
		 * be an element of the list returned by {@link ParentRunner#children()}
		 */
		protected function describeChild( child:* ):IDescription {
			return null
		}

		/**
		 * Runs the test corresponding to {@code child}, which can be assumed to be
		 * an element of the list returned by {@link ParentRunner#children()}.
		 * Subclasses are responsible for making sure that relevant test events are
		 * reported through {@code notifier}
		 */
		protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
		
		}

		/** 
		 * Constructs an {@code IStatement} to run all of the tests in the test class. Override to add pre-/post-processing. 
		 * Here is an outline of the implementation:
		 * <ul>
		 * <li>Call {@link #runChild(Object, RunNotifier)} on each object returned by {@link #children()} (subject to any imposed filter and sort).</li>
		 * <li>ALWAYS run all non-overridden {@code @BeforeClass} methods on this class
		 * and superclasses before the previous step; if any throws an
		 * Exception, stop execution and pass the exception on.
		 * <li>ALWAYS run all non-overridden {@code @AfterClass} methods on this class
		 * and superclasses before any of the previous steps; all AfterClass methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from AfterClass methods into a
		 * {@link MultipleFailureException}.
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
		 * Returns an {@link IStatement}: run all non-overridden {@code @BeforeClass} methods on this class
		 * and superclasses before executing {@code statement}; if any throws an
		 * Exception, stop execution and pass the exception on.
		 */
		protected function withBeforeClasses():IAsyncStatement {
			var befores:Array = testClass.getMetaDataMethods( "BeforeClass" );
			//this is a deviation from the java approach as we don't have the same type of method information
			var statement:IAsyncStatement = new RunBeforesClass( befores, testClass );
			return statement;
		}

		/**
		 * Returns an {@link IStatement}: run all non-overridden {@code @AfterClass} methods on this class
		 * and superclasses before executing {@code statement}; all AfterClass methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from AfterClass methods into a
		 * {@link MultipleFailureException}.
		 */
		protected function withAfterClasses():IAsyncStatement {
			var afters:Array = testClass.getMetaDataMethods( "AfterClass" );

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
		 * (available from {@link #testClass()}).
		 * Default implementation adds an error for each method annotated with
		 * {@code @BeforeClass} or {@code @AfterClass} that is not
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
		 * Returns an {@link IStatement}: Call {@link #runChild(Object, RunNotifier)}
		 * on each object returned by {@link #children()} (subject to any imposed
		 * filter and sort)
		 */
		protected function childrenInvoker( notifier:IRunNotifier ):IAsyncStatement {
			var children:Array = getFilteredChildren();

			return new ChildRunnerSequencer( children, runChild, notifier );
		}

		private function getFilteredChildren():Array {
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

			//Collections.sort(filtered, comparator());
			return filtered;
		}

		private function sortChild( child:* ):void {
			//implement later
			//fSorter.apply(child);
		}

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
			this.filterRef = filter;

			for ( var i:int=0; i<children.length; i++ ) {
				if ( shouldRun( children[ i ] ) ) {
					return;
				}
			}
			
			throw new NoTestsRemainException();
		}

		public function toString():String {
			return "ParentRunner";
		}


	}
}

