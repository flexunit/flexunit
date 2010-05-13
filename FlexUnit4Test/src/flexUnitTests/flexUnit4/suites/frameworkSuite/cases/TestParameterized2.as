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
			return [ [ 0, 1, 1 ], [ 1, 2, 3 ], [ 2, 4, 6 ] ];
		}
		
		[Test(dataProvider="dataTwo")]
		public function timesTwoTest( value:int, result:int ):void {
			assertEquals( 2*value, result );
		}

		[Test(dataProvider="dataThree")]
		public function addTwoValuesTest( value1:int, value2:int, result:int ):void {
			assertEquals( value1 + value2, result );
		}

		[Test]
		public function justARegularTest():void {
		}

	}
}
