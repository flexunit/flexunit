package org.flexunit.async.cases
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.async.AsyncTestResponder;
	import org.flexunit.events.AsyncResponseEvent;

	public class AsyncTestResponderCase
	{
		//TODO: Make sure these tests correctly test the class
		protected static var TIMEOUT:int = 250;
		
		protected var asyncTestResponder:AsyncTestResponder;
		protected var originalResponder:Object;
		protected var data:Object;
		
		[Before(description="Create an instance of the AsyncTestResponder")]
		public function createAsyncTestResponder():void {
			originalResponder = new Object();
			asyncTestResponder = new AsyncTestResponder(originalResponder);
			data = new Object();
		}
		
		[After(description="Destroy the instance of the AsyncTestResponder")]
		public function destroyAsyncTestResponder():void {
			originalResponder = null;
			asyncTestResponder = null;
			data = null;
		}
		
		[Test(async, description="Ensure an AsyncResponseEvent is dispatched with the correct result information")]
		public function resultTest():void {
			asyncTestResponder.addEventListener(
				AsyncResponseEvent.RESPONDER_FIRED, Async.asyncHandler(this, handleResult, TIMEOUT, null, timeoutReached), false, 0 , true);
		
			asyncTestResponder.result(data);
		}
		
		[Test(async, description="Ensure an AsyncResponseEvent is dispatched with the correct fault information")]
		public function faultTest():void {
			asyncTestResponder.addEventListener(
				AsyncResponseEvent.RESPONDER_FIRED, Async.asyncHandler(this, handleFault, TIMEOUT, null, timeoutReached), false, 0 , true);
			
			asyncTestResponder.fault(data);
		}
		
		protected function handleResult(event:AsyncResponseEvent, passThroughData:Object):void {
			Assert.assertEquals(event.originalResponder, originalResponder);
			Assert.assertEquals(event.status, "result");
			Assert.assertEquals(event.data, data);
		}
		
		protected function handleFault(event:AsyncResponseEvent, passThroughData:Object):void {
			Assert.assertEquals(event.originalResponder, originalResponder);
			Assert.assertEquals(event.status, "fault");
			Assert.assertEquals(event.data, data);
		}
		
		protected function timeoutReached(passThroughData:Object):void {
			Assert.fail('AsyncTestResponderCase Test Timeout Occured');
		}
	}
}