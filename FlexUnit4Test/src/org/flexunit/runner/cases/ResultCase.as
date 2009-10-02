package org.flexunit.runner.cases
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.notification.IRunListener;
	import org.flexunit.runner.notification.mocks.FailureMock;

	//TODO: Is an additional test needed in order to make sure the run listener is being created correctly?
	public class ResultCase
	{	
		protected var result:Result;
		protected var runListener:IRunListener;
		
		[Before(description="Create an instance of Result")]
		public function createResult():void {
			result = new Result();
			runListener = result.createListener();
		}
		
		[After(description="Destroy the reference to the Result instance")]
		public function destroyResult():void {
			result = null;
		}
		
		[Test(description="Ensure the failure count correctly updates for each reported failure case")]
		public function getFailureCountTest():void {
			runListener.testFailure(new FailureMock());
			
			Assert.assertEquals(result.failureCount, 1);
		}
		
		[Test(description="Ensure the failures array is correctly populated with each encounted failure")]
		public function getFailuresTest():void {
			var failure:FailureMock = new FailureMock();
			runListener.testFailure(failure);
			
			var failureArray:Array = result.failures;
			Assert.assertEquals(failure, failureArray[0] as FailureMock);
		}
		
		[Test(description="Ensure the ignore count correctly updates for each reported ignore case")]
		public function getIgnoreCountTest():void {
			runListener.testIgnored(new DescriptionMock());
			
			Assert.assertEquals(result.ignoreCount, 1);
		}
		
		[Test(description="Ensure the run count correctly updates for each successful test that is run")]
		public function getRunCountTest():void {
			runListener.testFinished(new DescriptionMock());
			
			Assert.assertEquals(result.runCount, 1);
		}
		
		[Test(async,
			description="Ensure that the runTime is increasing when a test has started and finished")]
		public function getRunTimeTest():void {
			Assert.assertEquals(result.runTime, 0);
			
			//Create a timer to mimic a group of tests running
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler(this, handleTestRunFinished, 2000, null, timeoutReached), false, 0 , true);
			
			//Begin a fake test run
			runListener.testRunStarted(new DescriptionMock());
			timer.start();
		}
		
		[Test(description="Ensure that the Result will be successful if no failures cases are reported")]
		public function getSuccessfulPassTest():void {
			runListener.testFinished(new DescriptionMock());
			
			Assert.assertEquals(result.successful, true);
		}
		
		[Test(description="Ensure that the Result will not report success if a failure case is encountered")]
		public function getSuccessfulFailTest():void {
			runListener.testFailure(new FailureMock());
			
			Assert.assertEquals(result.successful, false);
		}
		
		protected function handleTestRunFinished(event:TimerEvent, passThroughData:Object):void {
			//The fake test run has finished
			runListener.testRunFinished(result);
			
			Assert.assertTrue(result.runTime > 0);
		}
		
		protected function timeoutReached(passThroughData:Object):void {
			Assert.fail("The fake test run has timed out.");
		}
	}
}