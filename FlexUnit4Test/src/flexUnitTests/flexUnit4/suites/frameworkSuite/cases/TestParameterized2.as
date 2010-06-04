package flexUnitTests.flexUnit4.suites.frameworkSuite.cases {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.helper.ParamDataHelper;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestParameterized2 {
		private var foo:Parameterized;
		
		public static var dataRetriever1:ParamDataHelper = new ParamDataHelper( "PurelyFakeExample.xml" );
		
		[DataPoints(loader="dataRetriever1")]
		public static var dataTwo:Array;

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
