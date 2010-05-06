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
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.runners.model.EachTestNotifier;
	import org.flexunit.internals.runners.statements.ExpectAsync;
	import org.flexunit.internals.runners.statements.ExpectException;
	import org.flexunit.internals.runners.statements.Fail;
	import org.flexunit.internals.runners.statements.FailOnTimeout;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.InvokeMethod;
	import org.flexunit.internals.runners.statements.RunAfters;
	import org.flexunit.internals.runners.statements.RunBefores;
	import org.flexunit.internals.runners.statements.StackAndFrameManagement;
	import org.flexunit.internals.runners.statements.StatementSequencer;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.manipulation.IFilterable;
	import org.flexunit.runner.manipulation.ISorter;
	import org.flexunit.runner.manipulation.OrderArgumentPlusInheritanceSorter;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * The <code>BlockFlexUnit4ClassRunner</code> is the heart of running FlexUnit4 
	 * tests.  It is responsible for iterating through tests in a given class, 
	 * determining if they are being implemented correctly, and executing them.
	 * The following flow occurs for a provided class:
	 * 
	 * <ul>
	 * <li>Any methods that contain a medadata tag of [BeforeClass] are executed.</li>
	 * <li>Once the [BeforeClass] methods have finished, each method labeled as [Test]
	 * is sequenced with all methods that contain [Before] and [After] metadata tags.
	 * Beofre each test, all methods marked as a [Before] method will execute.  After
	 * this occurs, the actual test method will execute.  After the test has finished,
	 * regardless of whether it succeeded or failed, all methods marked as an [After]
	 * method will run.  This procedure will be repeated for all tests in the class.</li>
	 * <li>Any methods that contain a metdata tag of [AfterClass] are finally executed.</li>
	 * </ul><br/>
	 * 
	 * While running tests, the <code>BlockFlexUnit4ClassRunner</code> uses two 
	 * very important concepts: recursive sequences and decoration.<br/>
	 * 
	 * The first sequence that is used in the <code>BlockFlexUnit4ClassRunner</code> is 
	 * that of the before class sequence, the tests sequence, and after class sequence.
	 * Both the before class and after class sequences consist of the before class and
	 * after class methods.  The tests sequence consists of a sequence of individual test 
	 * sequences.  Each individual test sequnce contains the before sequence, the test, 
	 * and the after sequence.  The before and after sequences contain the before and
	 * after methods.<br/>
	 * 
	 * Before any before class, after class, before, after, or test methods are executed,
	 * they are decorated in order to add functionality.  These decorations are used to
	 * wrap the invocation of a method with code that should be executed before or after
	 * the method in a synchronous nature.  Each decarator is applied to the method if
	 * necessary; if it is not needed, the decorator is not applied.<br/>
	 * 
	 * The wrapping of the actual test method can be seen in the <code>#withDecoration()</code> 
	 * method.  This method determines if the tests needs certain decorators based on the
	 * metadata of the test.
	 * 
	 * @see org.flexunit.internals.runners.statements.StatementSequencer
	 * @see org.flexunit.internals.runners.statements.SequencerWithDecoration
	 */
	public class BlockFlexUnit4ClassRunner extends ParentRunner implements IFilterable {

		/**
		 * Creates a BlockFlexUnit4ClassRunner to run <code>klass</code>.
		 * 
		 * @param klass The class to run.
		 */	 
		public function BlockFlexUnit4ClassRunner( klass:Class ) {
			super( klass );
		}

		//
		// Implementation of ParentRunner
		// 
		
		/**
		 * @inheritDoc
		 */
		override protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
			var method:FrameworkMethod = FrameworkMethod( child ); 
			var eachNotifier:EachTestNotifier = makeNotifier( method, notifier);
			var error:Error;

			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = childRunnerToken;
			token.addNotificationMethod( handleBlockComplete );
			token[ ParentRunner.EACH_NOTIFIER ] = eachNotifier;
			
			//Determine if the method should be ignored and not run
			if ( method.hasMetaData( "Ignore" ) ) {
				eachNotifier.fireTestIgnored();
				childRunnerToken.sendResult();
				return;
			}
	
			//TODO: Deal with async issues here on the notifier finish
			eachNotifier.fireTestStarted();
			try {
				var block:IAsyncStatement = methodBlock(method );
				block.evaluate( token );				
			} catch ( e:AssumptionViolatedException ) {
				error = e;
				eachNotifier.addFailedAssumption(e);
			} catch ( e:Error ) {
				error = e;
				eachNotifier.addFailure(e);
			} 
			
			if ( error ) {
				eachNotifier.fireTestFinished();
				childRunnerToken.sendResult();
				//if we have already reported the error, to the notifier, there is no need to pass it further up the chain
				//childRunnerToken.sendResult( error );
			}
		}
		
		/**
		 * Handles the result of the test method that has run and alerts the <code>IRunNotifier</code>
		 * about the results of the test.
		 * 
		 * @param result The <code>ChildResult</code> of the test method that has run.
		 */
		private function handleBlockComplete( result:ChildResult ):void {
			var error:Error = result.error;
			var token:AsyncTestToken = result.token;
			var eachNotifier:EachTestNotifier = result.token[ EACH_NOTIFIER ];
			
			//Determine if an assumption failed, if it did, ignore the test; otherwise, report the error
			if ( error is AssumptionViolatedException ) {
				eachNotifier.fireTestIgnored();
			} else if ( error ) {
				eachNotifier.addFailure( error );
			}
			
			eachNotifier.fireTestFinished();

			token.parentToken.sendResult();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function describeChild( child:* ):IDescription {
			//OPTIMIZATION POINT
			var method:FrameworkMethod = FrameworkMethod( child );
			return Description.createTestDescription( testClass.asClass, method.name, method.metadata );
		}
		
		/**
		 * Returns an array of all methods that have been annotated with <code>Test</code>.
		 */
		override protected function get children():Array {
			return computeTestMethods();
		}

		//
		// Override in subclasses
		//

		/**
		 * Returns the methods that run tests. Default implementation 
		 * returns all methods annotated with <code>Test</code> on this 
		 * class and superclasses that are not overridden.
		 */
		protected function computeTestMethods():Array {
			//OPTIMIZATION POINT
			return testClass.getMetaDataMethods( "Test" );
		}
		
		/**
		 * It additionally validates whether specific instances of tests are implemented correctly.
		 * 
		 * @inheritDoc
		 */
		override protected function collectInitializationErrors( errors:Array ):void {
			super.collectInitializationErrors(errors);
	
			//validateConstructor(errors);.. no need, we can only have one
			validateInstanceMethods(errors);
		}

		/**
		 * Adds to <code>errors</code> for each method annotated with <code>Test</code>,
		 * <code>Before</code>, or <code>After</code> that is not a public, void instance
		 * method with no arguments.
		 */
		protected function validateInstanceMethods( errors:Array ):void {
			validatePublicVoidNoArgMethods( "After", false, errors);
			validatePublicVoidNoArgMethods( "Before", false, errors);
			validateTestMethods(errors);
	
			if (computeTestMethods().length == 0)
				errors.push(new Error("No runnable methods"));
		}

		/**
		 * Adds to <code>errors</code> for each method annotated with <code>Test</code> that
		 * is not a public, void instance method with no arguments.
		 */
		protected function validateTestMethods( errors:Array ):void {
			validatePublicVoidNoArgMethods( "Test", false, errors);
		}

		/**
		 * Returns a new fixture for running a test. Default implementation executes
		 * the test class's no-argument constructor (validation should have ensured
		 * one exists).
		 */
		protected function createTest():Object {
			return new testClass.asClass();
		}
		
		/**
		 * Creates an <code>EachTestNotifier</code> based on the the description of the method and a notifer.
		 * 
		 * @param method The <code>FrameworkMethod</code> that is to be described.
		 * @param notifier The notifier to notify about the execution of the method.
		 * 
		 * @return an <code>EachTestNotifier</code>.
		 */
		private function makeNotifier( method:FrameworkMethod, notifier:IRunNotifier ):EachTestNotifier {
			var description:IDescription = describeChild(method);
			return new EachTestNotifier(notifier, description);
		}

		/**
		 * Returns an IStatement that, when executed, either returns normally if
		 * <code>method</code> passes, or throws an exception if <code>method</code> fails.
		 * 
		 * <p>Here is an outline of the default implementation:</p>
		 * 
		 * <ul>
		 * <li>Invoke <code>method</code> on <code>test</code>, and
		 * throw any exceptions thrown by either operation.</li>
		 * <li>HOWEVER, if <code>method</code>'s <code>Test</code> annotation has the <code>
		 * expecting</code> attribute, return normally only if the previous step threw an
		 * exception of the correct type, and throw an exception otherwise.</li>
		 * <li>HOWEVER, if <code>method</code>'s <code>Test</code> annotation has the <code>
		 * timeout</code> attribute, throw an exception if the previous step takes more
		 * than the specified number of milliseconds.</li>
		 * <li>ALWAYS run all non-overridden <code>Before</code> methods on this class
		 * and superclasses before any of the previous steps; if any throws an
		 * Exception, stop execution and pass the exception on.</li>
		 * <li>ALWAYS run all non-overridden <code>After</code> methods on this class
		 * and superclasses before any of the previous steps; all After methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from After methods into a
		 * <code>MultipleFailureException</code>.</li>
		 * </ul>
		 * 
		 * <p>This can be overridden in subclasses, either by overriding this method,
		 * or the implementations creating each sub-statement.</p>
		 */
		protected function methodBlock( method:FrameworkMethod ):IAsyncStatement {
			var c:Class;

			var test:Object;
			//might need to be reflective at some point
			try {
				test = createTest();
			} catch ( e:Error ) {
				trace( e.getStackTrace() );
				return new Fail(e);
			}

			var sequencer:StatementSequencer = new StatementSequencer();
			
			sequencer.addStep( withBefores( method, test) );
			sequencer.addStep( withDecoration( method, test ) );
			sequencer.addStep( withAfters( method, test ) );
			
			return sequencer;
		}

		/**
		 * Returns an <code>IAsyncStatement</code> that invokes <code>method</code> on <code>test</code>
		 */
		protected function methodInvoker( method:FrameworkMethod, test:Object ):IAsyncStatement {
			return new InvokeMethod(method, test);
		}

		/**
		 * Returns an <code>IAsyncStatement</code>: if <code>method</code>'s <code>Test</code> annotation
		 * has the <code>expecting</code> attribute, return normally only if <code>next</code>
		 * throws an exception of the correct type, and throw an exception otherwise.
		 */
		protected function possiblyExpectingExceptions( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var expected:String = ExpectException.hasExpected( method );
			return expected ? new ExpectException( expected, statement ) : statement;
		}

		/**
		 * Returns an <code>IAsyncStatement</code>: if <code>method</code>'s <code> Test</code> annotation
		 * has the <code>timeout</code> attribute, throw an exception if <code>next</code>
		 * takes more than the specified number of milliseconds.
		 */
		protected function withPotentialTimeout( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var timeout:String = FailOnTimeout.hasTimeout( method );
			return timeout ? new FailOnTimeout( Number( timeout ), statement ) : statement;
		}
		
		/**
		 * Returns an <code>IAsyncStatement</code>: if <code>method</code>'s <code>Test</code> annotation
		 * has the <code>async</code> attribute, throw an exception if <code>next</code>
		 * encounters an exception during execution.
		 */
		protected function withPotentialAsync( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var async:Boolean = ExpectAsync.hasAsync( method );
			return async ? new ExpectAsync( test, statement ) : statement;
		}
		
		/**
		 * Returns an <code>IAsyncStatement</code> that invokes <code>method</code> on a decorated <code>test</code>.
		 */
		protected function withDecoration( method:FrameworkMethod, test:Object ):IAsyncStatement {
			var statement:IAsyncStatement = methodInvoker( method, test );
			statement = withPotentialAsync( method, test, statement );
			statement = withPotentialTimeout( method, test, statement );
			statement = possiblyExpectingExceptions( method, test, statement );
			statement = withStackManagement( method, test, statement );
			
			return statement;
		}
		
		/**
		 * Returns an <code>IAsyncStatement</code> that manages the stack and allow execution to break across frames.
		 */
		protected function withStackManagement( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			return new StackAndFrameManagement( statement );
		}

		/**
		 * Returns an <code>IAsyncStatement</code>: run all non-overridden <code>Before</code>
		 * methods on this class and superclasses before running <code>statement</code>; if
		 * any throws an Exception, stop execution and pass the exception on.
		 */
		protected function withBefores( method:FrameworkMethod, target:Object ):IAsyncStatement {
			var befores:Array = testClass.getMetaDataMethods( "Before" );
			var inheritanceSorter:ISorter = new OrderArgumentPlusInheritanceSorter( sorter, testClass, true );
			//Sort the befores array
			befores.sort( function compare(o1:Object, o2:Object):int {
								return inheritanceSorter.compare(describeChild(o1), describeChild(o2));
						  } );

			return new RunBefores( befores, target );
		}
	
		/**
		 * Returns an <code>IAsyncStatement</code>: run all non-overridden <code>After</code>
		 * methods on this class and superclasses before running <code>next</code>; all
		 * After methods are always executed: exceptions thrown by previous steps
		 * are combined, if necessary, with exceptions from After methods into a
		 * <code>MultipleFailureException</code>.
		 */
		protected function withAfters( method:FrameworkMethod, target:Object ):IAsyncStatement {
			var afters:Array = testClass.getMetaDataMethods( "After" );
			var inheritanceSorter:ISorter = new OrderArgumentPlusInheritanceSorter( sorter, testClass, false );

			afters.sort( function compare(o1:Object, o2:Object):int {
				return inheritanceSorter.compare(describeChild(o1), describeChild(o2));
			} );

			return new RunAfters( afters, target);
		}
	}
}