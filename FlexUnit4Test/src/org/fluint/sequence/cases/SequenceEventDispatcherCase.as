package org.fluint.sequence.cases
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.fluint.sequence.SequenceEventDispatcher;

	public class SequenceEventDispatcherCase
	{
		protected var sequenceEventDispatcher:SequenceEventDispatcher;
		protected var target:EventDispatcher;
		protected var eventToBroadcast:Event;
		
		protected var eventType:String = "testEvent";
		
		[Before(description="Create an instance of the SequenceEventDispatcher class")]
		public function createSequenceEventDispatcher():void {
			target = new EventDispatcher();
			eventToBroadcast = new Event(eventType);
			sequenceEventDispatcher = new SequenceEventDispatcher(target, eventToBroadcast);
		}
		
		[After(description="Remove the reference to the instance of the SequenceEventDispatcher class")]
		public function destroySequenceEventDispatcher():void {
			sequenceEventDispatcher = null;
			target = null;
			eventToBroadcast = null;
		}
		
		[Test(description="Ensure that the target property is correctly obtained")]
		public function getTargetTest():void {
			Assert.assertEquals( target, sequenceEventDispatcher.target );
		}
		
		[Test(description="Ensure that the eventToBroadcast property is correctly obtained")]
		public function getEventToBroadcastTest():void {
			Assert.assertEquals( eventToBroadcast, sequenceEventDispatcher.eventToBroadcast );
		}
		
		[Test(async,
			description="Ensure that the execute function correctly dispatches the eventToBroadcast with the target")]
		public function Test():void {
			target.addEventListener(eventType, Async.asyncHandler(this, executeBroadcastHandler, 1000, null, executeFailedHandler), false, 0, true);
			
			sequenceEventDispatcher.execute();
		}
		
		protected function executeBroadcastHandler(event:Event, passThroughData:Object):void {
			Assert.assertEquals( eventType, event.type );
		}
		
		protected function executeFailedHandler(passThroughData:Object):void {
			Assert.fail("The test has timed out.");
		}
	}
}