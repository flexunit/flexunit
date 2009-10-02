package org.flexunit.async.cases
{
	import org.flexunit.async.Async;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.async.mocks.EventDispatcherMock;
	import org.flexunit.async.mocks.ResponderMock;
	import org.flexunit.internals.runners.statements.mock.AsyncHandlingStatementMock;

	public class AsyncASCase
	{
		protected var asyncHandlingStatementMock:AsyncHandlingStatementMock;
		protected var testCase:Object;
		
		[Before(description="Prepare the environment for the Async test")]
		public function setUp():void {
			asyncHandlingStatementMock = new AsyncHandlingStatementMock();
			testCase = new Object();
			
			AsyncLocator.registerStatementForTest(asyncHandlingStatementMock, testCase);
		}
		
		[After(description="Reset the environment for the Async test")]
		public function tearDown():void {
			AsyncLocator.cleanUpCallableForTest(testCase);
			
			asyncHandlingStatementMock = null;
			testCase = null;
		}
		
		
		[Test(description="Ensure the proceedOnEvent function is correctly called")]
		public function proceedOnEventTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var eventName:String = "eventName";
			var timeout:int = 700;
			var timeoutHandler:Function = new Function();
			var handler:Function = new Function();
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs(asyncHandlingStatementMock.pendUntilComplete, timeout, null, timeoutHandler).once.returns(handler);
			target.mock.method("addzEventListener").withArgs(eventName, handler, false, 0, true).once;
			
			Async.proceedOnEvent(testCase, target, eventName, timeout, timeoutHandler);
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
			target.mock.verify();
		}
		
		[Ignore]
		[Test(description="Ensure the failOnEvent function is correctly called")]
		public function failOnEventTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var eventName:String = "eventName";
			var timeout:int = 700;
			var timeoutHandler:Function = new Function();
			var handler:Function = new Function();
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs(asyncHandlingStatementMock.failOnComplete, timeout, null, asyncHandlingStatementMock.pendUntilComplete).once.returns(handler);
			target.mock.method("addzEventListener").withArgs(eventName, handler, false, 0, true).once;
			
			Async.failOnEvent(testCase, target, eventName, timeout, timeoutHandler);
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
			target.mock.verify();
		}
		
		[Test(description="Ensure the handleEvent function is correctly called")]
		public function handleEventTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var eventName:String = "eventName";
			var eventHandler:Function = new Function();
			var timeout:int = 700;
			var passThroughData:Object = new Object();
			var timeoutHandler:Function = new Function();
			var handler:Function = new Function();
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs(eventHandler, timeout, passThroughData, timeoutHandler).once.returns(handler);
			target.mock.method("addzEventListener").withArgs(eventName, handler, false, 0, true).once;
			
			Async.handleEvent(testCase, target, eventName, eventHandler, timeout, passThroughData, timeoutHandler);
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
			target.mock.verify();
		}
		
		[Test(description="Ensure the asyncHandler function is correctly called")]
		public function asyncHandlerTest():void {
			var eventHandler:Function = new Function();
			var timeout:int = 700;
			var passThroughData:Object = new Object();
			var timeoutHandler:Function = new Function();
			var handler:Function = new Function();
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs(eventHandler, timeout, passThroughData, timeoutHandler).once.returns(handler);
			
			Async.asyncHandler(testCase, eventHandler, timeout, passThroughData, timeoutHandler);
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
		}
	}
}