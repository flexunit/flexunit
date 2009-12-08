package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.fail;
	
	public class failCase
	{
		[Test(description="Ensure that the testFail function correctly throws an AssertionFailedError and sends the proper message")]
		public function testFail():void {
			var message:String = "Fail test";
			var failed:Boolean = false;
			
			try {
				fail(message);
			} catch(error:AssertionFailedError) {
				failed = true;
				Assert.assertEquals( message, error.message );
			}
			if(!failed) {
				Assert.fail("The fail function has failed");
			}
		}
	}
}