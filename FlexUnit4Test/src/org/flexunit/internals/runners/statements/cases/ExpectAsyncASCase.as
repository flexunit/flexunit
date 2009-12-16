package org.flexunit.internals.runners.statements.cases
{
	import flash.events.DataEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.internals.runners.statements.ExpectAsync;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.InvokeMethod;
	import org.flexunit.internals.runners.statements.mock.AsyncStatementMock;
	import org.flexunit.internals.runners.statements.mock.TestableExpectAsync;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.AsyncTestToken;

	public class ExpectAsyncASCase
	{
		//TODO: There are still tests that need to be created in this test case
		//The objectUnderTest Object parameter in the constructor changes behavior based on its type, can a before / after still be used?
		protected var expectAsync : TestableExpectAsync;
		protected var frameworkMethodMock:FrameworkMethodMock;
		protected var statementMock : AsyncStatementMock;
		
		[Before(description="Create an instance of the ExpectAsync")]
		public function setup():void {
			expectAsync = new TestableExpectAsync( this, new InvokeMethod( frameworkMethodMock , statementMock ) );
		}
		
		[After(description="Destroy the instance of the ExpectAsync")]
		public function teardown():void {
			expectAsync = null;
		}
		
		[Test(description="Ensure that the bodyExecuting property returns a value of false when methodBodyExecuting is false")]
		public function bodyExecutingFalseTest():void {
			Assert.assertFalse( expectAsync.bodyExecuting );
		}
		
		[Ignore]
		[Test(description="Ensure that the bodyExecuting property returns a value of true when methodBodyExecuting is true")]
		public function bodyExecutingTrueTest():void {
			//No idea how to get this to true and check it, only place that sets it, resets it back to false after execution of a token's method.
		}
		
		[Test(description="Ensure that the hasPendingAsync property returns a value of false when the pendingAsyncCalls array is empty")]
		public function hasPendingAsyncFalseTest():void {
			Assert.assertFalse( expectAsync.hasPendingAsync );
		}
		
		[Test(async, description="Ensure that the hasPendingAsync property returns a value of true when the pendingAsyncCalls array is not empty")]
		public function hasPendingAsyncTrueTest():void {
			expectAsync.asyncHandler( null, 500, null, handleTimeout );
			expectAsync.asyncHandler( null, 1000, null, handleTimeout );
			expectAsync.asyncHandler( null, 1000, null, handleTimeout );
			
			Assert.assertTrue( expectAsync.hasPendingAsync );
		}
		
		[Test(description="Ensure that the hasAsync function returns a value of true if the FrameworkMethod class has an async test")]
		public function hasAsyncFalseTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var type:String = "test";
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs(type, "async").once.returns("true");
			
			Assert.assertTrue( ExpectAsync.hasAsync(frameworkMethodMock, type) );
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the hasAsync function returns a value of false if the FrameworkMethod class does not have an async test")]
		public function hasAsyncTrueTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var type:String = "value";
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs(type, "async").once.returns("otherValue");
			
			Assert.assertFalse( ExpectAsync.hasAsync(frameworkMethodMock, type) );
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test]
		public function handleProtectCalled_ErrorCaught() : void {
			expectAsync.callProtect( throwAnError );
			Assert.assertTrue( expectAsync.errorWasCaught );
			Assert.assertFalse( expectAsync.timersWereRestarted );
		}
		
		//used to trigger a try/catch in the protect() method, throws a simple error.
		protected function throwAnError() : void
		{
			Error.throwError( Error, 0000 );
		}
		
		protected function handleTimeout( data : Object = null ) : void
		{
			//do nothing
		}
		
	}
}