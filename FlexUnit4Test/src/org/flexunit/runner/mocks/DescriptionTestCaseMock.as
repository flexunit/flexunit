package org.flexunit.runner.mocks
{
	[Suite]
	[RunWith(description="this is a mock class")]
	public class DescriptionTestCaseMock
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(description="dummy test")]
		public function dummyTest1() : void
		{
			
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}