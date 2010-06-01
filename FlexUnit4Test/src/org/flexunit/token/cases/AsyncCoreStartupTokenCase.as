package org.flexunit.token.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.mocks.RunnerMock;
	import org.flexunit.runners.ParentRunner;
	import org.flexunit.token.AsyncCoreStartupToken;

	public class AsyncCoreStartupTokenCase
	{
		protected var asyncCoreStartupToken:AsyncCoreStartupToken;
		protected var runnerFunctionCalled:int;
		
		[Before(description="Create an instance of the AsyncCoreStartupToken class")]
		public function createAsyncListernesToken():void {
			asyncCoreStartupToken = new AsyncCoreStartupToken();
			runnerFunctionCalled = 0;
		}
		
		[After(description="Remove the reference to the instance of the AsyncCoreStartupToken")]
		public function destroyAsyncCoreStartupToken():void {
			asyncCoreStartupToken = null;
			runnerFunctionCalled = 0;
		}
		
		[Test(description="Ensure that the getter and setter for runner correctly operate")]
		public function getSetRunnerTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncCoreStartupToken.runner = runnerMock;
			
			Assert.assertEquals( runnerMock, asyncCoreStartupToken.runner );
		}
		
		[Test(description="Ensure that the addNotificationMethod correctly adds a function and returns the instance of the token")]
		public function addNotificationMethodTest():void {
			Assert.assertEquals( asyncCoreStartupToken, asyncCoreStartupToken.addNotificationMethod(runnerTest) );
		}
		
		[Test(description="Ensure that the sendReady function correctly calls all functions with the runner")]
		public function sendReadyTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncCoreStartupToken.runner = runnerMock;
			asyncCoreStartupToken.addNotificationMethod( runnerTest );
			
			asyncCoreStartupToken.sendReady();
			
			if(runnerFunctionCalled != 1) {
				Assert.fail("The sendReady function did not call the correct function with the right runner");
			}
		}
		
		[Test(description="Ensure that the sendReady function correctly calls all functions with the runner")]
		public function sendCompleteTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			asyncCoreStartupToken.runner = runnerMock;
			asyncCoreStartupToken.addNotificationMethod( runnerTest );
			
			asyncCoreStartupToken.sendComplete();
			
			if(runnerFunctionCalled != 1) {
				Assert.fail("The sendComplete function did not call the correct function with the right runner");
			}
		}
		
		protected function runnerTest(runner:IRunner):void {
			runnerFunctionCalled++;
		}
	}
}