package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.Fail;
	import org.flexunit.token.AsyncTestToken;

	public class FailCase
	{
		//TODO: Ensure that this test case has all needed tests and that the current tests are being
		//implemented correctly
		
		[Test(description="Ensure that the evaluate method is working correctly")]
		public function evaluteTest():void {
			var error:Error = new Error();
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			var fail:Fail = new Fail(error);
			
			try {
				fail.evaluate(asyncTestToken);
			} catch(e:Error) {
				Assert.assertEquals(error, e);
			}
		}
	}
}