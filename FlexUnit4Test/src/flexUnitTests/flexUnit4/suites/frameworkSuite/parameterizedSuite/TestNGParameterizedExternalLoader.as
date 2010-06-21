package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite.helper.ParamDataHelper;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.runners.Parameterized;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestNGParameterizedExternalLoader
	{
		
		private var foo : Parameterized;
		
		public static var testCount : int = 0;
		public static var dataRetriever1:ParamDataHelper = new ParamDataHelper( "someFakeDataPath.stuff" );
		
		[DataPoints(loader="dataRetriever1")]
		public static var someData:Array;
		
		public static var ensureRunOnceData : Array = [ [ 0 ] ];

		[AfterClass]
		public static function afterClass() : void
		{
			Assert.assertEquals( testCount, 4 );
		}
		
		[Test(dataProvider="ensureRunOnceData", order="1")]
		public function parameterized_testng_verifyAllDatapointsLoaded( num : int ) : void
		{
			// Since the loader has a timer that delays the datapoint construction, can assume this will run first
			// (the datapoint that already exists)
			++testCount;
			Assert.assertEquals( num + 1, testCount );
		}
		
		[Test(dataProvider="someData", order="2")]
		public function parameterized_testng_verifyAllDatapointsLoadedPtTwo( num : int ) : void
		{
			// Since the loader has a timer that delays the datapoint construction, can assume this will run second
			++testCount;
			Assert.assertEquals( num + 1, testCount );
		}
	}
}