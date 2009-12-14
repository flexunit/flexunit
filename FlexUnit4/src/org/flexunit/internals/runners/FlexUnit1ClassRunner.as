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
package org.flexunit.internals.runners {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	
	import flexunit.framework.Test;
	import flexunit.framework.TestCase;
	import flexunit.framework.TestListener;
	import flexunit.framework.TestResult;
	import flexunit.framework.TestSuite;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescribable;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.manipulation.IFilter;
	import org.flexunit.runner.manipulation.IFilterable;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.IAsyncTestToken;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * The <code>FlexUnit1ClassRunner</code> is responsible for running FlexUnit1 classes.
	 */
	public class FlexUnit1ClassRunner implements IRunner, IFilterable {
		
		/**
		 * @private
		 */
		private var test:Test;
		/**
		 * @private
		 */
		private var klassOrTest:*;
		/**
		 * @private
		 */
		private var totalTestCount:int = 0;
		/**
		 * @private
		 */
		private var numTestsRun:int = 0;
		/**
		 * @private
		 */
		private var filterRef:IFilter = null;
		/**
		 * @private
		 */
		private var testCompletedToken : AsyncTestToken;
		
		/**
		 * Constructor.
		 * 
		 * @param klassOrTest The class or test to run.
		 */
		public function FlexUnit1ClassRunner( klassOrTest:* ) {
			super();

			this.klassOrTest = klassOrTest;

			if ( klassOrTest is Test ) {
				this.test = klassOrTest;
			} else {
				//in this case, we need to make a suite
				this.test = createTestSuiteWithFilter( filterRef );
			}
			
			if ( klassOrTest is TestSuite ) {
				if ( TestSuite( klassOrTest ).testArrayList.isEmpty() ) {
					throw new InitializationError("Empty test Suite!");
				}
			}
		}
		
		/**
		 * Returns an <code>IDescription</code> for <code>child</code>.
		 * 
		 * @param child The child to describe.
		 * 
		 * @return an <code>IDescription</code> of the provided <code>child</code>.
		 */
		protected function describeChild( child:* ):IDescription {
			var method:FrameworkMethod = FrameworkMethod( child );
			return Description.createTestDescription( klassOrTest, method.name, method.metadata);
		}
		
		/**
		 * Returns a Boolean value indicating whether the <code>item</code> should run.
		 * 
		 * @param item The item to check to see if it should run.
		 * 
		 * @return a Boolean value indicating whether the <code>item</code> should run.
		 */
		private function shouldRun( item:* ):Boolean {
			return filterRef == null || filterRef.shouldRun( describeChild( item ) );
		}
		
		/**
		 * Returns an <code>Array</code> of methods that should run that are contained in
		 * <code>klassInfo</code>.
		 * 
		 * @param klassInfo The <code>Klass</code> used to find methods.
		 * @param filter
		 * 
		 * @return an <code>Array</code> of methods that should run.
		 */
		private function getMethodListFromFilter( klassInfo:Klass, filter:IFilter ):Array {
			var list:Array = [];

			for ( var i:int=0; i<klassInfo.methods.length; i++ ) {
				var method:Method = klassInfo.methods[ i ] as Method;
				var frameworkMethod:FrameworkMethod = new FrameworkMethod( method );
				
				//Determine if the method should run
				if ( shouldRun( frameworkMethod ) ) {
					list.push( method.name );
				}  
			}

			return list;
		}
		
		/**
		 * Creates a <code>TestSuite</code> that is filtered based on the provided <code>Filter</code>.
		 * 
		 * @param filter The <code>Filter</code> to apply to the class or test.
		 * 
		 * @return a <code>TestSuite</code> that is filtered based on the provided <code>Filter</code>.
		 */
		private function createTestSuiteWithFilter( filter:IFilter = null ):Test {
			if ( !filter ) {
				return new TestSuite( klassOrTest );
			} else {
				var suite:TestSuite = new TestSuite();
				var klassInfo:Klass = new Klass( klassOrTest );
				var methodList:Array = getMethodListFromFilter( klassInfo, filter );

				for ( var i:int=0; i<methodList.length; i++ ) {
					var numConstructorArgs:int = klassInfo.constructor.parameterTypes.length;
					var test:Test;
					
					if ( numConstructorArgs == 0 ) {
						test = klassInfo.constructor.newInstance() as Test;
						if ( test is TestCase ) {
							//If this is a testCase && it does not take a constructor argument
							//then we try to pass it into methodName
							TestCase( test ).methodName = methodList[ i ];
						}
					} else if ( numConstructorArgs == 1 ) {
						test = klassInfo.constructor.newInstance( methodList[ i ] ) as Test;
					} else {
						throw new InitializationError( "Asking to instatiate TestClass with unknown number of arguments" );
					}

					suite.addTest( test );
				}
				return suite;
			}
		}
		
		/**
		 * Returns the <code>Class</code> for a provided <code>Test</code>.
		 * 
		 * @param test The <code>Test</code> for which to obtain the <code>Class</code>.
		 * 
		 * @return the <code>Class</code> for a provided <code>Test</code>.
		 */
		public static function getClassFromTest( test:Test ):Class {
			var name:String = getQualifiedClassName( test );
			return getDefinitionByName( name ) as Class;		
		}
		
		/**
		 * Runs the test class and updates the <code>notifier</code> on the status of running the tests.
		 * 
		 * @param notifier The notifier that is notified about issues encountered during the execution of the test class.
		 * @param previousToken The token that is to be notified when the runner has finished execution of the test class.
		 */
		public function run( notifier:IRunNotifier, previousToken:IAsyncTestToken ):void {
			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = previousToken;
			token.addNotificationMethod( handleTestComplete );
			
			var result:TestResult = new TestResult();
			result.addListener( createAdaptingListener( notifier, token ));

			totalTestCount = test.countTestCases();

			test.runWithResult(result);
		}
		
		/**
		 * Handles the results of a single test completing.
		 * 
		 * @param result The results of the running test.
		 */
		protected function handleTestComplete( result:ChildResult ):void {
			//trace( numTestsRun + ' ' + totalTestCount );
			if ( ++numTestsRun == totalTestCount ) {
				testCompletedToken = result.token;
				
				// FlexUnit 0.9 has a timer set up in TestSuiteTestListener executed 
				// 5ms after each test execution to clean up the static property listenerStack.
				// We have to add this 100ms delay here as well otherwise the parentToken would be executed
				// before the TestSuiteTestListener timer and would mess things up.
				// We are delaying 100ms and not less since this might be ~2 frames. Since this timer is
				// created before than the timer in TestSuiteTestListener, due to Flash Player behaviour,
				// if the timers are executed in the same frame and even thouh the time of the second one is 
				// smaller the first added timer will be executed first
				var timer : Timer = new Timer ( 100, 1 );
				timer.addEventListener( TimerEvent.TIMER,handleAllTestsComplete,false, 0, false );
				timer.start();
			}
		}
		
		/**
		 * Handles the results of the test class completing.
		 * 
		 * @param event
		 */
		private function handleAllTestsComplete( event : TimerEvent ) : void
		{
			(event.target as Timer).removeEventListener( TimerEvent.TIMER, handleAllTestsComplete );
			testCompletedToken.parentToken.sendResult();
		}
		
		/**
		 * Creates a <code>TestListener</code> using a provided <code>notifier</code> and
		 * <code>token</code>.
		 * 
		 * @param notifier The notifier to notify about the status of the test.
		 * @param token The token to nofity when the test has finished.
		 * 
		 * @return a <code>TestListener</code>.
		 */
		public static function createAdaptingListener( notifier:IRunNotifier, token:AsyncTestToken ):TestListener {
			return new OldTestClassAdaptingListener(notifier, token );
		}
		
		private var cachedDescription:IDescription;
		/**
		 * Returns an <code>IDescription</code> of the test class that the runner is running.
		 */
		public function get description():IDescription {
			//Determine if a description has already been created
			if ( !cachedDescription ) {
				cachedDescription = makeDescription( test );
			}

			return cachedDescription;
		}
		
		/**
		 * Generates an <code>IDescription</code> for the provided <code>Test</code>.
		 * 
		 * @param test The <code>Test</code> ufor which to generate the <code>IDescription</code>.
		 * 
		 * @return an <code>IDescription</code> for the provided <code>Test</code>.
		 */
		private function makeDescription( test:Test ):IDescription {
			var name:String;
			var description:IDescription;
			var n:int;
			var tests:Array;
			var testClass:Class;
			
			if ( test is TestCase ) {
				var tc:TestCase = TestCase( test );

				testClass = getClassFromTest( tc );
				description = Description.createTestDescription(testClass, tc.methodName );
				
				return description;
			} else if ( test is TestSuite ) {
				var ts:TestSuite = TestSuite( test );
				name = ts.className == null ? "" : ts.className;
				description = Description.createSuiteDescription(name);
				n = ts.testCount();
				tests = ts.getTests();
				for ( var i:int = 0; i < n; i++)
					description.addChild( makeDescription( tests[i] ) );

				return description;
			} else if (test is IDescribable) {
				var adapter:IDescribable = IDescribable( test );
				return adapter.description;
//// not currently supporting this as the old flex unit didn't have it
/* 			} else if (test is TestDecorator) {
				TestDecorator decorator= (TestDecorator) test;
				return makeDescription(decorator.getTest());
 */			} else {
				// This is the best we can do in this case
				return Description.createSuiteDescription( test.className );
			}
		}
		
		/**
		 * Will apply a <code>Filter</code> to the test object.
		 * @param filter Filter
		 * @see org.flexunit.runner.manipulation.Filter
		 */
		public function filter( filter:IFilter ):void {
			if ( test is IFilterable ) {
				var adapter:IFilterable = IFilterable( test );
				adapter.filter(filter);
			}
			
			this.filterRef = filter;
			test = createTestSuiteWithFilter( filterRef );
		}
	
/* 		public void sort(Sorter sorter) {
			if (fTest instanceof Sortable) {
				Sortable adapter= (Sortable) fTest;
				adapter.sort(sorter);
			}
		}		
 */	}
}
import flexunit.framework.TestListener;
import org.flexunit.runner.notification.RunNotifier;
import flexunit.framework.Test;
import org.flexunit.runner.Description;
import org.flexunit.runner.notification.Failure;
import flexunit.framework.TestCase;
import org.flexunit.runner.IDescribable;
import flexunit.framework.AssertionFailedError;
import org.flexunit.internals.runners.FlexUnit1ClassRunner;
import org.flexunit.token.AsyncTestToken;
import org.flexunit.runner.notification.IRunNotifier;
import org.flexunit.runner.IDescription;	

class OldTestClassAdaptingListener implements TestListener {
	private var notifier:IRunNotifier;
	private var token:AsyncTestToken;

	public function OldTestClassAdaptingListener( notifier:IRunNotifier, token:AsyncTestToken ) {
		this.notifier = notifier;
		this.token = token;
	}

	public function endTest( test:Test ):void {
		notifier.fireTestFinished(asDescription(test));
		token.sendResult();
	}

	public function startTest( test:Test ):void {
		notifier.fireTestStarted(asDescription(test));
	}

	// Implement junit.framework.TestListener
	public function addError( test:Test, error:Error ):void {
		var failure:Failure = new Failure(asDescription(test), error );
		notifier.fireTestFailure(failure);
	}

	private function asDescription( test:Test ):IDescription {
		if (test is IDescribable) {
			var facade:IDescribable = test as IDescribable;
			return facade.description;
		}

		return Description.createTestDescription( FlexUnit1ClassRunner.getClassFromTest( test ), getName(test) );
	}

	private function getName( test:Test ):String {
		if ( test is TestCase )
			return TestCase( test ).methodName;
		else
			return test.toString();
	}

	public function addFailure( test : Test, error : AssertionFailedError ) : void {
		addError( test, error );
	}
}