package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import org.flexunit.Assert;
	
	public class TestDoubleMetaData
	{
		private static var testRunCount:int = 0;
		
		[BeforeClass]
		public static function resetCounter():void {
			testRunCount = 0;
		}

		//Should only be run once despite multiple [Test] markers
		[Test(bugID="FXU-33")]
		[Test(bugID="FXU-33")]
		[Test(bugID="FXU-33")]
		public function doTestCase():void {
			testRunCount++;
			
			Assert.assertEquals( 1, testRunCount );
		}		
	}
}