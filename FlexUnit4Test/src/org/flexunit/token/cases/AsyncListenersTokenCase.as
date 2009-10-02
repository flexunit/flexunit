package org.flexunit.token.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.mocks.RunnerMock;
	import org.flexunit.runners.ParentRunner;
	import org.flexunit.token.AsyncListenersToken;

	public class AsyncListenersTokenCase
	{
		protected var asyncListenersToken:AsyncListenersToken;
		protected var runnerFunctionCalled:int;
		
		[Before(description="Create an instance of the AsyncListenersToken class")]
		public function createAsyncListernesToken():void {
			asyncListenersToken = new AsyncListenersToken();
			runnerFunctionCalled = 0;
		}
		
		[After(description="Remove the reference to the instance of the AsyncListenersToken")]
		public function destroyAsyncListenersToken():void {
			asyncListenersToken = null;
			runnerFunctionCalled = 0;
		}
		
		[Test(description="Ensure that the getter and setter for runner correctly operate")]
		public function getSetRunnerTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncListenersToken.runner = runnerMock;
			
			Assert.assertEquals( runnerMock, asyncListenersToken.runner );
		}
		
		[Test(description="Ensure that the addNotificationMethod correctly adds a function and returns the instance of the token")]
		public function addNotificationMethodTest():void {
			Assert.assertEquals( asyncListenersToken, asyncListenersToken.addNotificationMethod(runnerTest) );
		}
		
		[Test(description="Ensure that the sendReady function correctly calls all functions with the runner")]
		public function sendReadyTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncListenersToken.runner = runnerMock;
			asyncListenersToken.addNotificationMethod( runnerTest );
			
			asyncListenersToken.sendReady();
			
			if(runnerFunctionCalled != 1) {
				Assert.fail("The sendReady function did not call the correct function with the right runner");
			}
		}
		
		[Test(description="Ensure that the sendReady function correctly calls all functions with the runner")]
		public function sendCompleteTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncListenersToken.runner = runnerMock;
			asyncListenersToken.addNotificationMethod( runnerTest );
			
			asyncListenersToken.sendComplete();
			
			if(runnerFunctionCalled != 1) {
				Assert.fail("The sendComplete function did not call the correct function with the right runner");
			}
		}
		
		protected function runnerTest(runner:IRunner):void {
			runnerFunctionCalled++;
		}
	}
}