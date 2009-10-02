package org.flexunit.events.cases
{
	import org.flexunit.Assert;
	import org.flexunit.events.AsyncResponseEvent;

	public class AsyncResponseEventCase
	{
		//TODO: Verify this test case is being handled correctly
		
		protected var asyncResponseEvent:AsyncResponseEvent;
		
		protected var originalResponder:*;
		protected var status:String;
		protected var data:Object;
		
		[Before(description="Creates an AsyncResponseEvent")]
		public function createAsyncResponseEvent():void {
			originalResponder = new Object();
			status = "status";
			data = new Object();
			
			asyncResponseEvent = new AsyncResponseEvent("asyncResponse", false, false, originalResponder, status, data);
		}
		
		[After(description="Destroy the reference to the AsyncResponseEvent")]
		public function destroyAsyncResponseEvent():void {
			originalResponder = null;
			status = null;
			data = null;
			asyncResponseEvent = null;
		}
		
		[Test(description="Ensure the AsyncResponseEvent is successfully created")]
		public function createAsyncResponseEventTest():void {
			Assert.assertEquals("Original Responder Assignment", originalResponder, asyncResponseEvent.originalResponder);
			Assert.assertEquals("Status Assignment", status, asyncResponseEvent.status);
			Assert.assertEquals("Data assignment", data, asyncResponseEvent.data);
		}
		
		[Test(description="Ensure the AsyncResponseEvent is successfully cloned")]
		public function cloneAsyncResponseEventTest():void {
			var newAsyncResponseEvent:AsyncResponseEvent = asyncResponseEvent.clone() as AsyncResponseEvent;
			
			Assert.assertEquals("Original Responder Clone", originalResponder, newAsyncResponseEvent.originalResponder);
			Assert.assertEquals("Original Status Clone", status, newAsyncResponseEvent.status);
			Assert.assertEquals("Original Data Clone", data, newAsyncResponseEvent.data);
		}
	}
}