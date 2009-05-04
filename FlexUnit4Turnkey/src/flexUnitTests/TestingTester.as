package flexUnitTests
{
	import flashx.textLayout.debug.assert;
	
	import flexunit.framework.TestCase;
	
	public class TestingTester extends TestCase
	{
		// please note that all test methods should start with 'test' and should be public
		
		public function TestingTester(methodName:String=null)
		{
			//TODO: implement function
			super(methodName);
		}
		
		//This method will be called before every test function
		override public function setUp():void
		{
			//TODO: implement function
			super.setUp();
		}
		
		//This method will be called after every test function
		override public function tearDown():void
		{
			//TODO: implement function
			super.tearDown();
		}
		
		/* sample test method*/
		[Test]
		public function testSampleMethod():void
		{
			// Add your test logic here
			fail("Test method Not yet implemented");
		}
		[Ignore]
		public function testPassMethod():void
		{
			// Add your test logic here
			
		}
	}
}