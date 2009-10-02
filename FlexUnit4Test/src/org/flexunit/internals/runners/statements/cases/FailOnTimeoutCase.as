package org.flexunit.internals.runners.statements.cases
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.internals.runners.statements.FailOnTimeout;
	import org.flexunit.internals.runners.statements.mock.AsyncStatementMock;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class FailOnTimeoutCase
	{		
		[Test(description="Ensure that the hasTimeout function returns a value of null when the timeout string is null")]
		public function hasTimeoutNullValueTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "timeout").once.returns(null);
			
			Assert.assertNull( FailOnTimeout.hasTimeout(frameworkMethodMock) );
		}
		
		[Test(description="Ensure that the hasTimeout function returns a value of null when the timeout string has a string value of null")]
		public function hasTimeoutNullStringTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "timeout").once.returns("null");
			
			Assert.assertNull( FailOnTimeout.hasTimeout(frameworkMethodMock) );
		}
		
		[Test(description="Ensure that the hasTimeout function returns a value of null when the timeout string is empty")]
		public function hasTimeoutEmptyStringTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "timeout").once.returns("");
			
			Assert.assertNull( FailOnTimeout.hasTimeout(frameworkMethodMock) );
		}
		
		[Test(description="Ensure that the hasTimeout function returns a value of non-null when the timeout string is a value that isn't null")]
		public function hasTimeoutValueTest():void {
			var testValue:String = "testValue";
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "timeout").once.returns(testValue);
			
			Assert.assertEquals( testValue, FailOnTimeout.hasTimeout(frameworkMethodMock) );
		}
		
		[Test(async,
			description="Ensure that the result error is sent once when the handleNextExecuteComplete is called once")]
		public function evaluate():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var statementMock:AsyncStatementMock = new AsyncStatementMock();
			var failOnTimeout:FailOnTimeout = new FailOnTimeout(1000, statementMock);
			
			//Add the variables to the pass through data
			var passThroughData:Object = new Object();
			passThroughData.parentToken = parentToken;
			passThroughData.statementMock = statementMock;
			passThroughData.failOnTimeout = failOnTimeout;
			
			statementMock.mock.method("evaluate").withArgs(AsyncTestToken).once;
			parentToken.mock.method("sendResult").withArgs(Error).once;
			
			//Create a timer that will give enough time for the evalute method to be run
			var timer:Timer = new Timer(1500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler(this, handleEvaluate, 2500, passThroughData, timeoutReached), false, 0 , true);
			
			failOnTimeout.evaluate(parentToken);
			timer.start();
		}
		
		//TODO: Currently no parent token has been set here, what should be done?
		[Ignore]
		[Test(description="Ensure that the result error is sent once when the handleNextExecuteComplete is called once")]
		public function handleNextExecuteCompleteOneCallTest():void {
			var statementMock:AsyncStatementMock = new AsyncStatementMock();
			var failOnTimeout:FailOnTimeout = new FailOnTimeout(1000, statementMock);
			
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var error:Error = new Error();
			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, error);
			
			//TODO: This expectation should be set on a parent token
			statementMock.mock.method("sendResult").withArgs(error).once;
			
			failOnTimeout.handleNextExecuteComplete(childResult);
			
			statementMock.mock.verify();
		}
		
		//TODO: Currently no parent token has been set here, what should be done?
		[Ignore]
		[Test(description="Ensure that the result error is sent only once when the handleNextExecuteComplete is called mutliple times")]
		public function handleNextExecuteCompleteTwoCallsTest():void {
			var statementMock:AsyncStatementMock = new AsyncStatementMock();
			var failOnTimeout:FailOnTimeout = new FailOnTimeout(1000, statementMock);
			
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var error:Error = new Error("test");
			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, error);
			
			//The sendResult method should still only be called once if returnMessageSent is true
			//TODO: This expectation should be set on a parent token
			statementMock.mock.method("sendResult").withArgs(error).once;
			
			failOnTimeout.handleNextExecuteComplete(childResult);
			failOnTimeout.handleNextExecuteComplete(childResult);
			
			statementMock.mock.verify();
		}
		
		protected function handleEvaluate(event:TimerEvent, passThroughData:Object):void {
			//Determine if the expectations on the mocks have been met
			var statementMock:AsyncStatementMock = passThroughData.statementMock;
			var parentToken:AsyncTestTokenMock = passThroughData.parentToken;
			
			statementMock.mock.verify();
			parentToken.mock.verify();
		}
		
		protected function timeoutReached(passThroughData:Object):void {
			Assert.fail("The evaluate test has timed out.");
		}
	}
}