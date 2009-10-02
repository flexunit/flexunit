package org.flexunit.runner.notification.async.cases
{
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.runner.notification.async.WaitingListener;
	import org.flexunit.runner.notification.async.AsyncListenerWatcher;

	public class WaitingListenerCase
	{
		protected static var LISTENER_TIME:int = 6000;
		
		protected var waitingListener:WaitingListener;
		
		[Before(description="Create an instance of the WaitingListener class")]
		public function setUp():void {
			waitingListener = new WaitingListener();
		}
		
		[After(description="Remove the reference ot the WaitingListener class")]
		public function tearDown():void {
			waitingListener = null;
		}
		
		[Test(description="Ensure the test isn't ready before five seconds have passed")]
		public function readyFailsTest():void {
			Assert.assertFalse( waitingListener.ready );
		}
		
		[Test(async,
			description="Ensure that the test is ready after five seconds have passed")]
		public function readyTest():void {
			waitingListener.addEventListener( AsyncListenerWatcher.LISTENER_READY, Async.asyncHandler( this, handleListenerReady, LISTENER_TIME, null, handleListenerTimeout ), false, 0, true );
		}
		
		public function handleListenerReady( event:Event, passThroughData:Object ):void {
			Assert.assertTrue( waitingListener.ready );
		}
		
		public function handleListenerTimeout( passThroughData:Object ):void {
			Assert.fail('Timeout.');
		}
	}
}