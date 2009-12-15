package org.flexunit.async.cases
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.async.AsyncHandler;
	import org.flexunit.events.AsyncEvent;
	import org.flexunit.runner.mocks.RunnerMock;

	public class AsyncHandlerCase
	{
		//TODO: Ensure that tests and this test case are implemented correctly
		protected static const LISTENER_TIME:int = 2000;
		
		protected var asyncHandler:AsyncHandler;
		protected var eventHandler:Function;
		protected var timeout:int;
		protected var passThroughData:Object;
		protected var timeoutHandler:Function;
		protected var runner:RunnerMock;
		
		[Before(description="Create an instance of the AsyncHandler")]
		public function createAsyncHandler():void {
			eventHandler = new Function();
			timeout = 1500;
			passThroughData = new Object();
			timeoutHandler = new Function();
			runner = new RunnerMock();
			asyncHandler = new AsyncHandler(runner, eventHandler, timeout, passThroughData, timeoutHandler);
		}
		
		[After(description="Destroy the instance of the AsyncHandler")]
		public function destroyAsyncHandler():void {
			asyncHandler = null;
		}
		
		[Test(description="Ensure the constructor function for the AsyncHandler class correctly instatiates the class")]
		public function asyncHandlerConstructorTest():void {
			Assert.assertEquals("Testing eventHandler", asyncHandler.eventHandler, eventHandler);
			Assert.assertEquals("Testing timeout", asyncHandler.timeout, timeout);
			Assert.assertEquals("Testing passThroughData", asyncHandler.passThroughData, passThroughData);
			Assert.assertEquals("Testing timeoutHandler", asyncHandler.timeoutHandler, timeoutHandler);
		}
		
		//TODO: Is there a way to test this with when the timeout is reached?
		[Test(async,
			description="Ensure handleEvent dispatches an event fired if the timer has not started")]
		public function handleEventBeforeStartTest():void {
			var event:Event = new Event("test");
			var passThroughData:Object = new Object();
			passThroughData.event = event;
			
			asyncHandler.addEventListener(AsyncHandler.EVENT_FIRED, Async.asyncHandler(this, handleEventListener, LISTENER_TIME, passThroughData, handleListenerTimeout), false, 0, true);
			asyncHandler.handleEvent(event);
		}
		
		[Test(async,
			description="Ensure handleEvent dispatches an event fired if the timer has started but not reached the timeout")]
		public function handleEventAfterStartTest():void {
			var event:Event = new Event("test");
			var passThroughData:Object = new Object();
			passThroughData.event = event;
			
			//Begin the timer
			asyncHandler.startTimer();
			asyncHandler.addEventListener(AsyncHandler.EVENT_FIRED, Async.asyncHandler(this, handleEventListener, LISTENER_TIME, passThroughData, handleListenerTimeout), false, 0, true);
			asyncHandler.handleEvent(event);
		}
		
		[Test(async,
			description="Ensure the handleTimeout function is correctly called")]
		public function handleTimeoutTest():void {
			var event:Event = new Event("test");
			var passThroughData:Object = new Object();
			passThroughData.event = event;
			
			asyncHandler.addEventListener(AsyncHandler.TIMER_EXPIRED, Async.asyncHandler(this, handleTimeoutListener, LISTENER_TIME, passThroughData, handleListenerTimeout), false, 0, true);
			
			//Begin the timer
			asyncHandler.startTimer();
		}
		
		[Test(async, description="Call a method with an Async handler within it and making sure the timeout happens.")]
		public function handleCallAsyncMethodShouldTimeout() : void {
			asyncShouldTimeout();
		}
		
		[Test(async, description="Running two timers, and ensuring that the second Async handler calls it's timeoutHandler and the first timer completes, even when the second timer isn't started.")]
		public function handleTwoAsyncTest() : void {
			var t1:Timer = new Timer( 400, 1 );
			var t2:Timer = new Timer( 400, 1 );
			//Second timer isn't started, expecting that it will timeout and that the first timer will complete.
			t1.addEventListener(TimerEvent.TIMER, Async.asyncHandler( this, handleTimerFinished, 600, null, null) );
			t2.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, handleTimer2Finished, 800, null, handleTwoAsyncTimeout) );
			t1.start();
		}
		
		[Test(async, description="Ensure this method calls to secondTimerStart method, and the Async handler there timesout without starting the timer associated with it.")]
		public function testChainedTimersAsyncCall():void
		{
			
			var t:Timer = new Timer( 400, 1 );
			t.addEventListener
				( TimerEvent.TIMER
					, Async.asyncHandler
					( this
						, secondTimerStart
						, 500
						, {}
						, function(data:Object = null):void{ Assert.fail( "first timer event not received." ); }
					)
				);
			t.start();
		}
		
		protected function asyncShouldTimeout() : void
		{
			var t1:Timer = new Timer( 400, 1 );
			t1.addEventListener(TimerEvent.TIMER, Async.asyncHandler( this, null, 600, null, handleTwoAsyncTimeout) );
		}
		
		protected function secondTimerStart( event:TimerEvent, data:Object = null ):void
		{
			
			var t:Timer = new Timer( 400, 1 );
			t.addEventListener
				( TimerEvent.TIMER
					, Async.asyncHandler
					( this
						, handleTimer
						, 500
						, {}
						, function(data:Object = null):void{ Assert.assertTrue( "timeout happened as expected", true ); }
					)
				);
			//do not start the timer, we should expect the async timer to timeout without anything happening.
			//t.start();
			
		}
		
		protected function handleTimerFinished( event : TimerEvent, data : Object = null ) : void
		{
			Assert.assertTrue( true );
		}

		protected function handleTimer2Finished( event : TimerEvent, data : Object = null ) : void
		{
			Assert.fail( "timer actually completed, but we wanted it to timeout" );
		}
		
		protected function handleTwoAsyncTimeout(passThroughData:Object):void {
			Assert.assertTrue( "timeout happened as expected", true );
		}
		
		protected function handleTimer( event:TimerEvent, data:Object = null ):void
		{
			Assert.fail( "timer actually completed, but we wanted it to timeout" );
		}
		
		protected function handleEventListener(asyncEvent:AsyncEvent, passThroughData:Object):void {
			var event:Event = passThroughData.event as Event;
			
			Assert.assertEquals( AsyncHandler.EVENT_FIRED, asyncEvent.type);
			Assert.assertEquals( event, asyncEvent.originalEvent );
		}
		
		protected function handleTimeoutListener(event:Event, passThroughData:Object):void {
			Assert.assertEquals( AsyncHandler.TIMER_EXPIRED, event.type );
		}
		
		protected function handleListenerTimeout(passThroughData:Object):void {
			Assert.fail("The timeout has been reached.");
		}
		
		
		
		
	}
}