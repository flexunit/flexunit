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
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.Klass;
	
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	
	import net.digitalprimates.fluint.monitor.TestMonitor;
	import net.digitalprimates.fluint.tests.TestCase;
	import net.digitalprimates.fluint.tests.TestSuite;
	import net.digitalprimates.fluint.ui.TestEnvironment;
	import net.digitalprimates.fluint.ui.TestRunner;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runner.manipulation.IFilterable;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	import org.fluint.uiImpersonation.TestEnvironment;
	
	public class Fluint1ClassRunner implements IRunner, IFilterable {

		private var testClass:*;
		private var test:*;
		private var klassInfo:Klass;
		private var flexUnitTestEnvironment:org.fluint.uiImpersonation.TestEnvironment;
		private var testRunner:TestRunner;
		private var token:AsyncTestToken;

		public function Fluint1ClassRunner( clazz:* ) {
			super();

			klassInfo = new Klass( clazz );
			testClass = clazz;
			test = klassInfo.constructor.newInstance();

			flexUnitTestEnvironment = org.fluint.uiImpersonation.TestEnvironment.getInstance();
		}

		public static function getClassFromTest( test:* ):Class {
			var name:String = getQualifiedClassName( test );
			return getDefinitionByName( name ) as Class;		
		}

		public function run( notifier:IRunNotifier, previousToken:AsyncTestToken ):void {
			token = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			token.parentToken = previousToken;
			token.addNotificationMethod( handleTestComplete );
			
			var fluintUnitTestEnvironment:net.digitalprimates.fluint.ui.TestEnvironment = new net.digitalprimates.fluint.ui.TestEnvironment();
			flexUnitTestEnvironment.addChild( fluintUnitTestEnvironment );

			testRunner = new TestRunner( createAdaptingMonitor( notifier ) );
			testRunner.testEnvironment = fluintUnitTestEnvironment;
			testRunner.addEventListener( TestRunner.TESTS_COMPLETE, handleAllTestsComplete );
			testRunner.startTests( [test] );
		}
		
		protected function handleAllTestsComplete( event:Event ):void {
			//need to remove older environment
			flexUnitTestEnvironment.removeAllChildren();;
			token.parentToken.sendResult();
		}
		
		protected function handleTestComplete( result:ChildResult ):void {
			var token:AsyncTestToken = result.token;

			//need to remove older environment
			flexUnitTestEnvironment.removeAllChildren();

			token.parentToken.sendResult();
		}

 		public function createAdaptingMonitor( notifier:IRunNotifier ):TestMonitor {
			return new FluintAdaptingListener( notifier );
		}
		
		public function get description():IDescription {
			return makeDescription( test );
		}
	
		private function makeDescription( test:* ):IDescription {
			var klassInfo:Klass;
			var clazz:Class;

 			if ( test is TestCase ) {
				var tc:TestCase = TestCase( test );
				clazz = getClassFromTest( tc );
				klassInfo = new Klass( clazz );
				return Description.createTestDescription( klassInfo.asClass, klassInfo.name );

			} else if ( test is TestSuite ) {
				var ts:TestSuite = TestSuite( test );
				clazz = getClassFromTest( ts );
				klassInfo = new Klass( clazz );

				var name:String = klassInfo.name;
				var description:IDescription = Description.createSuiteDescription(name);
				var n:int = ts.getTestCount();
				var tests:ICollectionView = ts.getTests();
				var cursor:IViewCursor = tests.createCursor();

				while ( !cursor.afterLast ) {
					description.addChild( makeDescription( cursor.current ) );
					cursor.moveNext();
				}

				return description;
			} 

			return Description.EMPTY;		
		}
	
		public function filter( filter:Filter ):void {
			if ( test is IFilterable ) {
				//var adapter:IFilterable = IFilterable( test );
				//adapter.filter(filter);
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
import org.flexunit.token.AsyncTestToken;
import org.flexunit.runner.notification.IRunNotifier;
import org.flexunit.runner.IDescription;
import net.digitalprimates.fluint.monitor.TestMonitor;
import org.flexunit.internals.runners.Fluint1ClassRunner;
import org.flexunit.runner.Description;
import net.digitalprimates.fluint.tests.TestSuite;
import net.digitalprimates.fluint.tests.TestCase;
import net.digitalprimates.fluint.monitor.TestCaseResult;
import net.digitalprimates.fluint.monitor.TestMethodResult;
import net.digitalprimates.fluint.tests.TestMethod;
import net.digitalprimates.fluint.monitor.TestSuiteResult;
import flex.lang.reflect.Klass;
import org.flexunit.runner.notification.Failure;
import org.flexunit.runner.Result;	

class FluintAdaptingListener extends TestMonitor {
	private var notifier:IRunNotifier;

	public function FluintAdaptingListener( notifier:IRunNotifier ) {
		this.notifier = notifier;
	}
	
/* 	override public function createTestCaseResult( testSuite:TestSuite, testCase:TestCase ):TestCaseResult {
		var testCaseResult:TestCaseResult = new AdaptingTestCaseResult( testCase, notifier );

		testCaseDictionary[ testCase ] = testCaseResult;
		
		var testSuiteResult:TestSuiteResult = getTestSuiteResult( testSuite );
		testSuiteResult.addTestCaseResult( testCaseResult );	
		
		return testCaseResult
	} */

	override public function createTestMethodResult( testCase:TestCase, testMethod:TestMethod ):TestMethodResult {
		var testMethodResult:TestMethodResult = new AdaptingTestMethodResult( testMethod, Fluint1ClassRunner.getClassFromTest( testCase ), notifier );

		testMethodDictionary[ testMethod ] = testMethodResult;
		
		var testCaseResult:TestCaseResult = getTestCaseResult( testCase );
		testCaseResult.addTestMethodResult( testMethodResult );
		
		return testMethodResult;
	}	
}

/* class AdaptingTestCaseResult extends TestCaseResult {
	private var notifier:IRunNotifier;
	private var klassInfo:Klass;
	private var clazz:Class;

	public function AdaptingTestCaseResult( testCase:TestCase, notifier:IRunNotifier ) {
		super( testCase );
		this.notifier = notifier;
		
		clazz = Fluint1ClassRunner.getClassFromTest( testCase );
		klassInfo = new Klass( clazz );
		
		//notifier.fireTestStarted( Description.createTestDescription( clazz, klassInfo.name ) );
	}

	override public function set executed( value:Boolean ):void {
		super.executed = value;
		//notifier.fireTestFinished( Description.createTestDescription( clazz, klassInfo.name ) );
	}		
} */

class AdaptingTestMethodResult extends TestMethodResult {
	private var notifier:IRunNotifier;
	private var testClass:Class;
	private var testMethod:TestMethod;

	public function AdaptingTestMethodResult( testMethod:TestMethod, testClass:Class, notifier:IRunNotifier ) {		
		this.testMethod = testMethod;
		this.testClass = testClass;
		this.notifier = notifier;
		super( testMethod );
		notifier.fireTestStarted( getDescription() );
	}

	private function getDescription():IDescription {
		return Description.createTestDescription( testClass, testMethod.methodName );
	}

 	override public function set executed( value:Boolean ):void {
		super.executed = value;
		notifier.fireTestFinished( getDescription() );
	}	
	
	override public function set error( value : Error ):void {
		super.error = value;
		
		if ( value ) {
			notifier.fireTestFailure( new Failure( getDescription(), value ) );
		}
	}
}





