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
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
//TODO: Do statements referring to older versions apply to older flexUnits?
/**
 * Implements the FlexUnit 4 standard test case class model, as defined by the
 * annotations in the org.flexunit package. Many users will never notice this
 * class: it is now the default test class runner, but it should have exactly
 * the same behavior as the old test class runner ({@code FlexUnit4ClassRunner}).
 * 
 * BlockFlexUnit4ClassRunner has advantages for writers of custom FlexUnit runners
 * that are slight changes to the default behavior, however:
 * 
 * <ul>
 * <li>It has a much simpler implementation based on {@link Statement}s,
 * allowing new operations to be inserted into the appropriate point in the
 * execution flow.
 * 
 * <li>It is published, and extension and reuse are encouraged, whereas {@code
 * FlexUnit4ClassRunner} was in an internal package, and is now deprecated.
 * </ul>
 */
	
	public class BlockFlexUnit4ClassRunner extends ParentRunner implements IFilterable {

		/**
		 * Creates a BlockFlexUnit4ClassRunner to run {@code klass}
		 */
		 
		public function BlockFlexUnit4ClassRunner( klass:Class ) {
			super( klass );
		}

	//
	// Implementation of ParentRunner
	// 
	
		override protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
			var method:FrameworkMethod = FrameworkMethod( child ); 
			var eachNotifier:EachTestNotifier = makeNotifier( method, notifier);
			var error:Error;

			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = childRunnerToken;
			token.addNotificationMethod( handleBlockComplete );
			token[ ParentRunner.EACH_NOTIFIER ] = eachNotifier;
			
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

		private function handleBlockComplete( result:ChildResult ):void {
			var error:Error = result.error;
			var token:AsyncTestToken = result.token;
			var eachNotifier:EachTestNotifier = result.token[ EACH_NOTIFIER ];

			if ( error is AssumptionViolatedException ) {
				eachNotifier.fireTestIgnored();
			} else if ( error ) {
				eachNotifier.addFailure( error );
			}
			
			eachNotifier.fireTestFinished();

			token.parentToken.sendResult();
		}

		override protected function describeChild( child:* ):IDescription {
			var method:FrameworkMethod = FrameworkMethod( child );
			return Description.createTestDescription( testClass.asClass, method.name, method.metadata[ 0 ] );
		}

		override protected function get children():Array {
			return computeTestMethods();
		}

	//
	// Override in subclasses
	//

	/**
	 * Returns the methods that run tests. Default implementation 
	 * returns all methods annotated with {@code @Test} on this 
	 * class and superclasses that are not overridden.
	 */
		protected function computeTestMethods():Array {
			return testClass.getMetaDataMethods( "Test" );
		}

		override protected function collectInitializationErrors( errors:Array ):void {
			super.collectInitializationErrors(errors);
	
			//validateConstructor(errors);.. no need, we can only have one
			validateInstanceMethods(errors);
		}

	/**
	 * Adds to {@code errors} for each method annotated with {@code @Test},
	 * {@code @Before}, or {@code @After} that is not a public, void instance
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
	 * Adds to {@code errors} for each method annotated with {@code @Test}that
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

		private function makeNotifier( method:FrameworkMethod, notifier:IRunNotifier ):EachTestNotifier {
			var description:IDescription = describeChild(method);
			return new EachTestNotifier(notifier, description);
		}

		/**
		 * Returns an IStatement that, when executed, either returns normally if
		 * {@code method} passes, or throws an exception if {@code method} fails.
		 * 
		 * Here is an outline of the default implementation:
		 * 
		 * <ul>
		 * <li>Invoke {@code method} on {@code test}, and
		 * throw any exceptions thrown by either operation.
		 * <li>HOWEVER, if {@code method}'s {@code @Test} annotation has the {@code
		 * expecting} attribute, return normally only if the previous step threw an
		 * exception of the correct type, and throw an exception otherwise.
		 * <li>HOWEVER, if {@code method}'s {@code @Test} annotation has the {@code
		 * timeout} attribute, throw an exception if the previous step takes more
		 * than the specified number of milliseconds.
		 * <li>ALWAYS run all non-overridden {@code @Before} methods on this class
		 * and superclasses before any of the previous steps; if any throws an
		 * Exception, stop execution and pass the exception on.
		 * <li>ALWAYS run all non-overridden {@code @After} methods on this class
		 * and superclasses before any of the previous steps; all After methods are
		 * always executed: exceptions thrown by previous steps are combined, if
		 * necessary, with exceptions from After methods into a
		 * {@link MultipleFailureException}.
		 * </ul>
		 * 
		 * This can be overridden in subclasses, either by overriding this method,
		 * or the implementations creating each sub-statement.
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
		 * Returns an {@link IStatement} that invokes {@code method} on {@code test}
		 */
		protected function methodInvoker( method:FrameworkMethod, test:Object ):IAsyncStatement {
			return new InvokeMethod(method, test);
		}

		/**
		 * Returns an {@link IStatement}: if {@code method}'s {@code @Test} annotation
		 * has the {@code expecting} attribute, return normally only if {@code next}
		 * throws an exception of the correct type, and throw an exception
		 * otherwise.
		 */
		protected function possiblyExpectingExceptions( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var expected:String = ExpectException.hasExpected( method );
			return expected ? new ExpectException( expected, statement ) : statement;
		}

		/**
		 * Returns an {@link IStatement}: if {@code method}'s {@code @Test} annotation
		 * has the {@code timeout} attribute, throw an exception if {@code next}
		 * takes more than the specified number of milliseconds.
		 */
		protected function withPotentialTimeout( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var timeout:String = FailOnTimeout.hasTimeout( method );
			return timeout ? new FailOnTimeout( Number( timeout ), statement ) : statement;
		}

		protected function withPotentialAsync( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var async:Boolean = ExpectAsync.hasAsync( method );
			return async ? new ExpectAsync( test, statement ) : statement;
		}

		protected function withDecoration( method:FrameworkMethod, test:Object ):IAsyncStatement {
			var statement:IAsyncStatement = methodInvoker( method, test );
			statement = withPotentialAsync( method, test, statement );
			statement = withPotentialTimeout( method, test, statement );
			statement = possiblyExpectingExceptions( method, test, statement );
			statement = withStackManagement( method, test, statement );
			
			return statement;
		}

		protected function withStackManagement( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			return new StackAndFrameManagement( statement );
		}

		/**
		 * Returns an {@link IStatement}: run all non-overridden {@code @Before}
		 * methods on this class and superclasses before running {@code statement}; if
		 * any throws an Exception, stop execution and pass the exception on.
		 */
		protected function withBefores( method:FrameworkMethod, target:Object ):IAsyncStatement {
			var befores:Array = testClass.getMetaDataMethods( "Before" );
			return new RunBefores( befores, target );
		}
	
		/**
		 * Returns an {@link IStatement}: run all non-overridden {@code @After}
		 * methods on this class and superclasses before running {@code next}; all
		 * After methods are always executed: exceptions thrown by previous steps
		 * are combined, if necessary, with exceptions from After methods into a
		 * {@link MultipleFailureException}.
		 */
		protected function withAfters( method:FrameworkMethod, target:Object ):IAsyncStatement {
			var afters:Array = testClass.getMetaDataMethods( "After" );
			return new RunAfters( afters, target);
		}
	}
}
