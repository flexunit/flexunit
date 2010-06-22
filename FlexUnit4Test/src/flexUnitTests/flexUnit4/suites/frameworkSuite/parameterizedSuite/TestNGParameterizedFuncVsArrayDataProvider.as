package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	import flexunit.framework.Assert;
	
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestNGParameterizedFuncVsArrayDataProvider
	{
		protected static var testRunArrayCount : int = 0;
		protected static var testRunFuncCount : int = 0;
		
		public static var testDataOneIntParam:Array = [ [ 0 ], [ 1 ], [ 2 ] ];
		
		public static function testFuncOneIntParam() : Array
		{
			return new Array( [ 0 ], [ 1 ], [ 2 ] );
		}
		
		private var foo : Parameterized;
		
		[Test(dataProvider="testDataOneIntParam")]
		public function parameterized_testng_verifyArray( num : int ) : void
		{
			Assert.assertEquals( num, testRunArrayCount );
			++testRunArrayCount;
		}
		
		[Test(dataProvider="testFuncOneIntParam")]
		public function parameterized_testng_verifyFunc( num : int ) : void
		{
			Assert.assertEquals( num, testRunFuncCount );
			++testRunFuncCount;
		}
	}
}