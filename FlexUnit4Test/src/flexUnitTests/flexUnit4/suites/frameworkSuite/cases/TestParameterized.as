package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestParameterized
	{
		private var foo:Parameterized;
		
		[Parameters]
		public static function data():Array {
			return [ [ 0, 0 ], [ 1, 2 ], [ 2, 4 ], [ 3, 6 ], [ 4, 8 ], [ 5, 10 ], [ 6, 12 ] ];
		}
		
		private var _input:int;
		
		private var _expected:int;
		
		public function TestParameterized( param1:int, param2:int ) {
			_input = param1;
			_expected = param2;
		}
		
		[Test]
		public function doubleTest():void {
			Assert.assertEquals(_expected, _input*2);
		}
	}
}