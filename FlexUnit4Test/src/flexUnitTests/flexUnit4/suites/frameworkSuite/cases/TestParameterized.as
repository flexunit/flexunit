package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.helper.ParamDataHelper;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.digitalprimates.fluint.async.AsyncHandler;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.internals.dependency.AsyncDependencyToken;
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestParameterized
	{
		private var foo:Parameterized;

		public static function getMeSomedataPoints():AsyncDependencyToken {
			var helper:ParamDataHelper = new ParamDataHelper( "http://www.digitalprimates.net/" ); 
			return helper.send();
		}

		[Parameters(method="getMeSomedataPoints")]
		public static var someData:Array;

		[Parameters(method="getMeSomedataPoints")]
		public static var someData2:Array;


/*		[Parameters]
		public static function data1():Array {
			//need to deal with this circumstance better -> throw new Error("Blah");
			return [ [ 0, 0 ], [ 1, 2 ], [ 2, 4 ] ];
		}

		[Parameters]
		public static function data2():Array {
			//need to deal with this circumstance better -> throw new Error("Blah");
			return [ [ 3, 6 ], [ 4, 8 ], [ 5, 10 ], [ 6, 12 ] ];
		}
*/
		private var _input:int;
		
		private var _expected:int;
		
		public function TestParameterized( param1:int, param2:int ) {
			_input = param1;
			_expected = param2;
		}
		
		[Test(async)]
		public function doubleTest():void {
			var timer:Timer = new Timer( 50, 1 );
			var asyncHandler:Function = Async.asyncHandler( this, handleTimerComplete, 6000 );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler );
			timer.start();
			
			Assert.assertEquals(_expected, _input*2);
		}
		
		//Argument count mismatch... should deal with this better
		private function handleTimerComplete( event:TimerEvent, passThroughData:Object ):void {
		}
	}
}