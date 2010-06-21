package flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite
{
	import flexunit.framework.Assert;

	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class TestTheoriesWithBeforeAfter
	{
		public static var testCount : int = 0;
		public static var beforeClassCount : int = 0;
		public static var beforeCount : int = 0;
		public static var afterCount : int = 0;
		public static var afterClassCount : int = 0;
		
		[DataPoints]
		[ArrayElementType("int")]
		public static var intValues:Array = [0,1,2,3,4,5,6,7,8,9];
		
		[BeforeClass]
		public static function beforeClass() : void
		{
			++beforeClassCount;
			trace( "beforeClassCount: ", beforeClassCount );
		}
		
		[AfterClass]
		public static function afterClass() : void
		{
			++afterClassCount;
			trace( "afterClassCount: ", afterClassCount );
		}
		
		[Before]
		public function before() : void
		{
			++beforeCount;
			trace( "beforeCount: ", beforeCount );
		}
		
		[After]
		public function after() : void
		{
			++afterCount;
			trace( "afterCount: ", afterCount );
		}
		
		[Theory]
		public function theories_verifyBeforeAfterAndClass( value : int ) : void
		{
			Assert.assertEquals( value, testCount );
			Assert.assertEquals( value + 1, beforeCount );
			Assert.assertEquals( value, afterCount );
			Assert.assertEquals( beforeClassCount, 1 );
			Assert.assertEquals( afterClassCount, 0 );
			++testCount;
			trace( "testCount: ", testCount );
		}
	}
}