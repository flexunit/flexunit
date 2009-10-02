package flexUnitTests.flexUnit4.suites.frameworkSuite.cases {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.async.Async;

	public class TestAsyncFail {
		
		[Test(async,expects="Error")]
		public function testAsyncFail():void {
			//timer 1's complete event occuring before timer 2 should cause this test to fail
			//it will not wait for the timeout of timer2, it will fail immediately
			//This test will pass as it expects an error
			var timer1:Timer = new Timer( 200, 1 );
			Async.failOnEvent( this, timer1, TimerEvent.TIMER_COMPLETE );
			timer1.start();

			var timer2:Timer = new Timer( 500, 1 );
			Async.failOnEvent( this, timer2, TimerEvent.TIMER_COMPLETE );
			timer2.start();
			
			var timer4:Timer = new Timer( 5000, 1 );
			timer4.addEventListener( TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, handleTimer2Complete, 500 ) );
			timer4.start();
		}

		[Test(async,expects="Error")]
		public function testAsyncFailSecond():void {
			//timer 1's complete event occuring before timer 2 should cause this test to fail
			//it will not wait for the timeout of timer2, it will fail immediately
			//This test will pass as it expects an error
			var timer1:Timer = new Timer( 500, 1 );
			Async.failOnEvent( this, timer1, TimerEvent.TIMER_COMPLETE );
			timer1.start();
			
			var timer2:Timer = new Timer( 200, 1 );
			Async.failOnEvent( this, timer2, TimerEvent.TIMER_COMPLETE );
			timer2.start();
			
			var timer4:Timer = new Timer( 5000, 1 );
			timer4.addEventListener( TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, handleTimer2Complete, 500 ) );
			timer4.start();
		}
		
		[Test(async)]
		public function testAsyncFailsTooLate():void {
			//timer 1's complete event occuring before timer 2 should cause this test to fail
			//This test will pass as timer 1's even happens after timer 2's
			var timer1:Timer = new Timer( 5000, 1 );
			Async.failOnEvent( this, timer1, TimerEvent.TIMER_COMPLETE );
			timer1.start();

			var timer2:Timer = new Timer( 4000, 1 );
			Async.failOnEvent( this, timer2, TimerEvent.TIMER_COMPLETE );
			timer2.start();
			
			var timer4:Timer = new Timer( 200, 1 );
			timer4.addEventListener( TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, handleTimer2Complete, 500 ) );
			timer4.start();
		}
		
		private function handleTimer2Complete( event:TimerEvent, passThrough:Object ):void {
						
		}
	}
}