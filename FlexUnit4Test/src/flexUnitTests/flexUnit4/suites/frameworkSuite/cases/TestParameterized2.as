package flexUnitTests.flexUnit4.suites.frameworkSuite.cases {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.digitalprimates.fluint.async.AsyncHandler;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.flexunit.runners.Parameterized;
	import org.flexunit.runners.ParameterizedMethodRunner;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestParameterized2 {
		private var foo:ParameterizedMethodRunner;
		
		public static function dataTwo():Array {
			//need to deal with this circumstance better -> throw new Error("Blah");
			return [ [ 0, 0 ], [ 1, 2 ], [ 2, 4 ] ];
		}

		public static function dataThree():Array {
			//need to deal with this circumstance better -> throw new Error("Blah");
			return [ [ 0, 0 ], [ 1, 3 ], [ 2, 6 ] ];
		}
		
		[Test(dataProvider="dataTwo")]
		public function timesTwoTest( value:int, required:int ):void {
			assertEquals( 2*value, required );
		}

		[Test(dataProvider="dataThree")]
		public function timesThreeTest( value:int, required:int ):void {
			assertEquals( 3*value, required );
		}

		[Test]
		public function justARegularTest():void {
		}

	}
}
