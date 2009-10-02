package org.flexunit.runner.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.RunnerLocator;

	public class RunnerLocatorCase
	{	
		//TODO: Ensure this test case is being implemented correctly
		
		[Test(description="Ensure that an instance of the RunnerLocator is successfully created")]
		public function getInstanceTest():void {
			var runnerLocator:RunnerLocator = RunnerLocator.getInstance();
			Assert.assertTrue(runnerLocator);
			Assert.assertTrue(runnerLocator is RunnerLocator);
		}
		
		[Test(description="Ensure an object is successfully registered")]
		public function registerRunnerForTestTest():void {
			var runnerLocator:RunnerLocator = RunnerLocator.getInstance();
			var iRunner:IRunner = runnerLocator.getRunnerForTest(new Object());
			var test:Object = new Object();
			
			//Add the iRunner to the runnerLocator for a given test
			runnerLocator.registerRunnerForTest(test, iRunner);
			
			//Retrieve the runner for the specific test
			Assert.assertEquals(iRunner, runnerLocator.getRunnerForTest(test));
			
		}
		
		[Test(description="Ensure a null runner is returned when an unregistered object is passed")]
		public function getRunnerForNonRegisteredTestTest():void {
			var runnerLocator:RunnerLocator = RunnerLocator.getInstance();
			var iRunner:IRunner = runnerLocator.getRunnerForTest(new Object());
			
			Assert.assertNull(iRunner);
		}
	}
}