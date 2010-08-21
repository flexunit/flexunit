package flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite
{
	import flexunit.framework.Assert;
	
	import org.flexunit.runners.Parameterized;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestJUnitParameterizedBasicFunctionality
	{
		public static var numTestCalls : int = 0;
		
		private var foo : Parameterized;
		
		protected var str : String;
		protected var num : int;
		
		[Parameters]
		public static var testDataTwoParams:Array = [ [ "string1", 1 ], 
			[ "string2", 2 ],
			[ "string3", 3 ] ];
		
		
		[Test]
		public function parameterized_junit_standardUse() : void
		{
			Assert.assertTrue( str.indexOf( num.toString() ) > 0 );
		}
		
		[Test]
		public function parameterized_junit_verifyArrayOrder() : void
		{
			++numTestCalls;
			Assert.assertEquals( num, numTestCalls );
		}
		
		[Ignore]
		[Test]
		public function parameterized_junit_verifyIgnore() : void
		{
			Assert.assertTrue( false );
		}
				
		public function TestJUnitParameterizedBasicFunctionality( str : String, num : int )
		{
			this.str = str;
			this.num = num;
		}
	}
}