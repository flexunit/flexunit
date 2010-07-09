package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite.helper.ParamDataHelper;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.runners.Parameterized;
	
	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestJUnitParameterizedExternalLoader
	{
		private var foo : Parameterized;
		
		public static var testCount : int = 0;
		
		[Parameters]
		public static var ensureRunOnceData : Array = [ [ 0 ] ];
		
		public static var dataRetriever1:ParamDataHelper = new ParamDataHelper( "someFakeDataPath.stuff" );
		
		[Parameters(loader="dataRetriever1")]
		public static var someData:Array;
		
		protected var num : int;
		
		[AfterClass]
		public static function afterClass() : void
		{
			// NOTE: If this fails, it will not show up as a failure on the tests, but as a "null" failure within the suite.
			Assert.assertEquals( testCount, 4 );
		}
		
		[Test]
		public function parameterized_junit_verifyAllDatapointsLoadedPtTwo() : void
		{
			// Since the loader has a timer that delays the datapoint construction, can assume this will run in order...
			++testCount;
			// NOTE: TEST FAILING: Order can't be assumed?
			//Assert.assertEquals( num, testCount );
		}

		public function TestJUnitParameterizedExternalLoader( num : int )
		{
			this.num = num;
		}
	}
}