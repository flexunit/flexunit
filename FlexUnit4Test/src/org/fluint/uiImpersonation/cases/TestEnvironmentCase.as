package org.fluint.uiImpersonation.cases
{
	import org.flexunit.Assert;
	import org.fluint.uiImpersonation.TestEnvironment;

	public class TestEnvironmentCase
	{
		protected static var testEnvironment:TestEnvironment;
		
		//TODO: Since this is a singleton, it is currently impossible to cover both branches, any way in which this can be remedied?
		[Test(order=1,
			description="Ensure that an instance to the TestEnvironment class is obtained the first time")]
		public function getInstanceNotCreatedTest():void
		{
			testEnvironment = TestEnvironment.getInstance();
			
			Assert.assertTrue( testEnvironment is TestEnvironment );
		}
		
		[Test(order=2,
			description="Ensure that the same instance to the TestEnvironment class is obtained the second time")]
		public function getInstanceCreatedTest():void
		{
			Assert.assertEquals( testEnvironment, TestEnvironment.getInstance() );
			
			//Remove the reference to the testEnvironment
			testEnvironment = null;
		}
	}
}