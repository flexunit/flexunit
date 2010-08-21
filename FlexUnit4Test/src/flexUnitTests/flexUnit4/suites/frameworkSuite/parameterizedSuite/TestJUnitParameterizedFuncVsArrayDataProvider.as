package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	import flexunit.framework.Assert;
	
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestJUnitParameterizedFuncVsArrayDataProvider
	{
		[Parameters]
		public static var testDataOneIntParam:Array = [ [ 0 ], [ 1 ], [ 2 ] ];
		
		[Parameters]	
		public static function testFuncOneIntParam() : Array
		{
			return new Array( [ 3 ], [ 4 ], [ 5 ] );
		}
		
		[Parameters]
		public static var testDataOneIntParam2:Array = [ [ 6 ], [ 7 ], [ 8 ] ];
		
		private var foo : Parameterized;
		
		protected var num : int;
		
		[Test]
		public function parameterized_testng_verifyArray() : void
		{
			// TODO: WRITE LEGIT TEST
			Assert.assertTrue( true );
		}
		
		public function TestJUnitParameterizedFuncVsArrayDataProvider( num : int )
		{
			this.num = num;
		}
	}
}