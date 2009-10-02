package org.flexunit.token.cases
{
	import org.flexunit.Assert;
	import org.flexunit.token.mocks.AsyncTestTokenMock;
	import org.flexunit.token.ChildResult;

	public class ChildResultCase
	{
		[Test(description="Ensure that the constructer correctly sets the token and error when only a token is passed")]
		public function createChildResultTokenTest():void {
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var childResult:ChildResult = new ChildResult( asyncTestTokenMock );
			
			Assert.assertEquals( asyncTestTokenMock, childResult.token );
			Assert.assertNull( childResult.error );
		}
		
		[Test(description="Ensure that the constructer correctly sets the token and error when a token and error are passed")]
		public function createChildResultTokenAndErrorTest():void {
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var error:Error = new Error();
			var childResult:ChildResult = new ChildResult( asyncTestTokenMock, error );
			
			Assert.assertEquals( asyncTestTokenMock, childResult.token );
			Assert.assertEquals( error, childResult.error );
		}
	}
}