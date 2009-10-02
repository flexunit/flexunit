package org.flexunit.events.cases
{
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.events.AsyncEvent;

	public class AsyncEventCase
	{
		//TODO: Verify this test case is being handled correctly
		
		protected var asyncEvent:AsyncEvent;
		
		protected var originalEvent:Event;
		
		[Before(description="Creates an AsyncEvent")]
		public function createAsyncResponseEvent():void {
			originalEvent = new Event("originalEvent")
			
			asyncEvent = new AsyncEvent("async", false, false, originalEvent);
		}
		
		[After(description="Destroy the reference to the AsyncEvent")]
		public function destroyAsyncEvent():void {
			originalEvent = null;
			asyncEvent = null;
		}
		
		[Test(description="Ensure the AsyncEvent is successfully created")]
		public function createAsyncEventTest():void {
			Assert.assertEquals(originalEvent, asyncEvent.originalEvent);
		}
		
		[Test(description="Ensure the AsyncEvent is successfully cloned")]
		public function cloneAsyncEventTest():void {
			var newAsyncEvent:AsyncEvent = asyncEvent.clone() as AsyncEvent;
			
			Assert.assertEquals(originalEvent, newAsyncEvent.originalEvent);
		}
	}
}