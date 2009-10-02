package org.flexunit.internals.events.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.events.ExecutionCompleteEvent;

	public class ExecutionCompleteEventCase
	{
		//TODO: Verify this test case is being handled correctly
		protected var executionCompleteEvent:ExecutionCompleteEvent;
		
		protected var error:Error;
		
		[Before(description="Creates an ExecutionCompleteEvent")]
		public function createExecutionCompleteEvent():void {
			error = new Error("error");
				
			executionCompleteEvent = new ExecutionCompleteEvent(error);
		}
		
		[After(description="Destroy the reference to the ExecutionCompleteEvent")]
		public function destroyExecutionCompleteEvent():void {
			error = null;
			executionCompleteEvent = null;
		}
		
		[Test(description="Ensure the ExecutionCompleteEvent is successfully created")]
		public function createExecutionCompleteEventTest():void {
			Assert.assertEquals(error, executionCompleteEvent.error);
		}
		
		[Test(description="Ensure the ExecutionCompleteEvent is successfully cloned")]
		public function cloneExecutionCompleteEventTest():void {
			var newExecutionCompleteEvent:ExecutionCompleteEvent = executionCompleteEvent.clone() as ExecutionCompleteEvent;
			
			Assert.assertEquals(error, newExecutionCompleteEvent.error);
		}
	}
}