package org.flexunit.token.cases
{
	import org.flexunit.Assert;
	import org.flexunit.token.mocks.AsyncTestTokenMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;

	public class AsyncTestTokenCase
	{
		//TODO: Ensure that these tests and this test case are properly implemented
		
		protected var currentError:Error;
		protected var numberOfCalls:int;
		
		[Test(description="Ensure that the parentToken property is properly set")]
		public function setParentTokenTest():void {
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			asyncTestToken.parentToken = parentToken;
			
			Assert.assertEquals(parentToken, asyncTestToken.parentToken);
		}
		
		//TODO: Is this the proper way to test this property
		[Test(description="Ensure that the error property is properly obtained")]
		public function getErrorTest():void {
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			asyncTestToken = new AsyncTestToken();
			
			Assert.assertNull(asyncTestToken.error);
		}
		
		//TODO: How can these notification tests be differentiated from other tests where the toString is checked or a particular function is called
		[Test(description="Ensure that the addNotificationMethod function correctly adds the function and default debugger to the methodEntries")]
		public function addNotificationMethodNoDebuggerTest():void {
			
		}
		
		[Test(description="Ensure that the addNotificationMethod function correctly adds the function and debugger to the methodEntries")]
		public function addNotificationMethodDebuggerTest():void {
			
		}
		
		//TODO: Additional tests will be need if logic is added to go through multiple notification methods
		[Test(description="Ensure that the sendResult funtion does not call any method if no notification methods have been added")]
		public function sendResultNoMethodTest():void {
			currentError = null;
			numberOfCalls = 0;
			
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			
			asyncTestToken.sendResult();
			
			if(numberOfCalls != 0) {
				Assert.fail("A notification method should not have been called but was");
			}
		}
		
		[Test(description="Ensure that the sendResult funtion calls the first notification method")]
		public function sendResultNullErrorTest():void {
			currentError = null;
			numberOfCalls = 0;
			
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			
			asyncTestToken.addNotificationMethod( testNullFunction );
			
			asyncTestToken.sendResult();
			
			if(numberOfCalls != 1) {
				Assert.fail("A notification method was not called when it should have been");
			}
		}
		
		[Test(description="Ensure that the toString function returns the proper value when the dubuggerClassName is null and there are no methods entries")]
		public function sendResultNonNullErrorTest():void {
			currentError = null;
			numberOfCalls = 0;
			
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			currentError = new Error("testError");
			
			asyncTestToken.addNotificationMethod( testFunction );
			
			asyncTestToken.sendResult(currentError);
			
			if(numberOfCalls != 1) {
				Assert.fail("A notification method was not called when it should have been");
			}
		}
		
		[Test(description="Ensure that the toString function returns the proper value when the dubuggerClassName is null and there are no methods entries")]
		public function toStringNullDebuggerNoMethodsTest():void {
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			
			Assert.assertEquals( "0 listeners", asyncTestToken.toString() );
		}
		
		[Test(description="Ensure that the toString function returns the proper value when the dubuggerClassName is null and there are methods entries")]
		public function toStringNullDebuggerMethodsTest():void {
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			
			asyncTestToken.addNotificationMethod(testFunction);
			asyncTestToken.addNotificationMethod(testFunction);
			
			Assert.assertEquals( "2 listeners", asyncTestToken.toString() );
		}
		
		[Test(description="Ensure that the toString function returns the proper value when the dubuggerClassName is not null")]
		public function toStringNonNullDebuggerTest():void {
			var debuggerName:String = "testDubugger";
			var asyncTestToken:AsyncTestToken = new AsyncTestToken(debuggerName);
			
			asyncTestToken.addNotificationMethod(testFunction);
			
			Assert.assertEquals( debuggerName + ": 1 listeners", asyncTestToken.toString() );
		}
		
		protected function testNullFunction(childResult:ChildResult):void {
			numberOfCalls++;
			Assert.assertNotNull(childResult);
			Assert.assertNull(childResult.error);
		}
		
		protected function testFunction(childResult:ChildResult):void {
			numberOfCalls++;
			Assert.assertNotNull(childResult);
			Assert.assertEquals( currentError, childResult.error );
		}
	}
}