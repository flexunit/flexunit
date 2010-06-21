package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestNGParameterizedWithAsync
	{
		public static var testRunCount : int = 0;
		public static var asyncHandlerCount : int = 0;
		
		public var num : int;
		
		protected var timer : Timer;
		
		private var foo : Parameterized;
		
		public static var testDataOneIntParam:Array = [ [ 0 ], [ 1 ], [ 2 ] ];
		
		[Test(dataProvider="testDataOneIntParam", async)]
		public function parameterized_testng_verifyAsync( num : int ) : void
		{
			this.num = num;
			++testRunCount;
			timer = new Timer( ( num * 100 ) + 500, 1 );
			var asyncHandler:Function = Async.asyncHandler( this, handleTimerComplete, 2000, null );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true );
			timer.start();
			Assert.assertEquals( testRunCount, asyncHandlerCount + 1 );
		}
		
		protected function handleTimerComplete( event : TimerEvent, passThroughData : Object ) : void
		{
			Assert.assertEquals( num, testRunCount - 1 );
			++asyncHandlerCount;
		}
	}
}