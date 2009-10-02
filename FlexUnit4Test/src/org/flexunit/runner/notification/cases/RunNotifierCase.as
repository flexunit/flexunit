package org.flexunit.runner.notification.cases
{
	import org.flexunit.runner.Description;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.mocks.ResultMock;
	import org.flexunit.runner.notification.mocks.FailureMock;
	import org.flexunit.runner.notification.mocks.RunListenerMock;
	import org.flexunit.runner.notification.RunNotifier;
	

	public class RunNotifierCase
	{
		//TODO: Tests need to be written for addListener, addFirstListener, and removeListener.  There also
		//needs to be a test that will run the catch block in the SafeNotifier's run method.  Ensure
		//that these tests and the test case are being implemented correctly
		
		protected var runNotifier:RunNotifier;
		protected var runListenerMock:RunListenerMock;
		
		[Before(description="Create an instance of the RunNotifier class and add a listener")]
		public function createRunNotifier():void {
			runNotifier = new RunNotifier();
			runListenerMock = new RunListenerMock();
			
			runNotifier.addListener(runListenerMock);
		}
		
		[After(description="Remove the reference to the instance of the RunNotifier")]
		public function destroyRunNotifier():void {
			runNotifier.removeListener(runListenerMock);
			
			runNotifier = null;
			runListenerMock = null;
		}
		
		[Test(description="Ensure that each listener is notified that the test run has started")]
		public function fireTestRunStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			runListenerMock.mock.method("testRunStarted").withArgs(descriptionMock).once;
			runNotifier.fireTestRunStarted(descriptionMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that the test run has finished")]
		public function fireTestRunFinishedTest():void {
			var resultMock:ResultMock = new ResultMock();
			
			runListenerMock.mock.method("testRunFinished").withArgs(resultMock).once;
			runNotifier.fireTestRunFinished(resultMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that a test has started")]
		public function fireTestStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			runListenerMock.mock.method("testStarted").withArgs(descriptionMock).once;
			runNotifier.fireTestStarted(descriptionMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(expected="org.flexunit.runner.notification.StoppedByUserException",
			description="Ensure that the next test does not start if it has been requested that execution of tests stop")]
		public function fireTestStartedStoppedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			runListenerMock.mock.method("testStarted").withArgs(descriptionMock).never;
			runNotifier.pleaseStop();
			runNotifier.fireTestStarted(descriptionMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that there was a test failure")]
		public function fireTestFailureTest():void {
			var failureMock:FailureMock = new FailureMock();
			
			runListenerMock.mock.method("testFailure").withArgs(failureMock).once;
			runNotifier.fireTestFailure(failureMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that there was an assumption failure")]
		public function fireTestAssumptionFailedTest():void {
			var failureMock:FailureMock = new FailureMock();
			
			runListenerMock.mock.method("testAssumptionFailure").withArgs(failureMock).once;
			runNotifier.fireTestAssumptionFailed(failureMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that a test has been ignored")]
		public function fireTestIgnoredTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			runListenerMock.mock.method("testIgnored").withArgs(descriptionMock).once;
			runNotifier.fireTestIgnored(descriptionMock);
			
			runListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that each listener is notified that a test has finished")]
		public function fireTestFinishedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			runListenerMock.mock.method("testFinished").withArgs(descriptionMock).once;
			runNotifier.fireTestFinished(descriptionMock);
			
			runListenerMock.mock.verify();
		}
	}
}