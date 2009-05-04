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
package org.flexunit.internals.runners {
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flexunit.framework.Test;
	import flexunit.framework.TestCase;
	import flexunit.framework.TestListener;
	import flexunit.framework.TestResult;
	import flexunit.framework.TestSuite;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescribable;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runner.manipulation.IFilterable;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runner.notification.RunNotifier;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	public class FlexUnit1ClassRunner implements IRunner, IFilterable {

		private var test:Test;
		private var totalTestCount:int = 0;
		private var numTestsRun:int = 0;

		public function FlexUnit1ClassRunner( klassOrTest:* ) {
			super();

			if ( klassOrTest is Test ) {
				this.test = klassOrTest;
			} else {
				//in this case, we need to make a suite
				this.test = new TestSuite( klassOrTest );
			}
		}

		public static function getClassFromTest( test:Test ):Class {
			var name:String = getQualifiedClassName( test );
			return getDefinitionByName( name ) as Class;		
		}

		public function run( notifier:IRunNotifier, previousToken:AsyncTestToken ):void {
			var token:AsyncTestToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = previousToken;
			token.addNotificationMethod( handleTestComplete );
			
			var result:TestResult = new TestResult();
			result.addListener( createAdaptingListener( notifier, token ));

			totalTestCount = test.countTestCases();

			test.runWithResult(result);
		}
		
		protected function handleTestComplete( result:ChildResult ):void {
			if ( ++numTestsRun == totalTestCount ) {
				var error:Error = result.error;
				var token:AsyncTestToken = result.token;
	
				token.parentToken.sendResult();
			}
		}

		public static function createAdaptingListener( notifier:IRunNotifier, token:AsyncTestToken ):TestListener {
			return new OldTestClassAdaptingListener(notifier, token );
		}
		
		public function get description():IDescription {
			return makeDescription( test );
		}
	
		private function makeDescription( test:Test ):IDescription {
			if ( test is TestCase ) {
				var tc:TestCase = TestCase( test );
				//return null;
				return Description.createTestDescription(getClassFromTest( tc ), tc.className );
			} else if ( test is TestSuite ) {
				var ts:TestSuite = TestSuite( test );
				var name:String = ts.className == null ? "" : ts.className;
				var description:IDescription = Description.createSuiteDescription(name);
				var n:int = ts.testCount();
				var tests:Array = ts.getTests();
				for ( var i:int = 0; i < n; i++)
					description.addChild( makeDescription( tests[i] ));
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
	
		public function filter( filter:Filter ):void {
			if ( test is IFilterable ) {
				var adapter:IFilterable = IFilterable( test );
				adapter.filter(filter);
			}
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

		return Description.createTestDescription( FlexUnit1ClassRunner.getClassFromTest( test ), getName(test));
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