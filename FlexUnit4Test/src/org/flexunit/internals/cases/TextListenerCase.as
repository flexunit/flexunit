package org.flexunit.internals.cases
{
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.flexunit.internals.TextListener;
	import org.flexunit.internals.mocks.LoggerMock;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.mocks.ResultMock;
	import org.flexunit.runner.notification.mocks.FailureMock;

	public class TextListenerCase
	{
		//TODO: Ensure that the tests and this test case are being implemented correctly
		
		protected var textListener:TextListener;
		protected var loggerMock:LoggerMock;
		
		[Before(description="Create a new instance of the TextListener class")]
		public function createTextListener():void {
			loggerMock = new LoggerMock();
			textListener = new TextListener(loggerMock);
		}
		
		[After(description="Remove the reference to the TextListener class")]
		public function destroyTextListener():void {
			textListener = null;
			loggerMock = null;
		}
		
		//TODO: What else should be done with this test?  Should all whole sepeate group of tests be written for the default listener?
		[Test(description="Ensure that the default listener is successfully created")]
		public function getDefaultTextListenerTestvoid():void {
			Assert.assertTrue( TextListener.getDefaultTextListener(0) is TextListener );
		}
		
		[Test(description="Ensure that testRunStarted function is correctly logged")]
		public function testRunStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			descriptionMock.mock.property("testCount").returns(2);
			
			loggerMock.mock.method("info").withArgs("Running {0} Tests", 2).once;
			
			textListener.testRunStarted(descriptionMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that printHeader function is correctly logged")]
		public function printHeaderTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(31272);
			resultMock.mock.property("failures").returns(new Array());
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			//Tests whether the printHeader is correctly logged
			loggerMock.mock.method("info").withArgs("Time: {0}", "31.272").once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that printFailures function is correctly logging zero failures")]
		public function printFailuresNoFailuresTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array());
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			//Tests that printFailures logs no warings when no failures are reported
			loggerMock.mock.method("warn").never;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that printFailures function is correctly logging one failure")]
		public function printFailuresOneFailureTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array( new FailureMock() ));
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			//Tests that printFailures logs one waring when one failure is reported
			loggerMock.mock.method("warn").withArgs("There was {0} failure:", 1).once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that printFailures function is correctly logging multiple failures")]
		public function printFailuresMultipleFailuresTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array( new FailureMock(), new FailureMock() ));
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			//Tests that printFailures logs one waring when multiple failures are reported
			loggerMock.mock.method("warn").withArgs("There were {0} failures:", 2).once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that the printFooter function is correctly logging one result on success")]
		public function printFooterSuccessfulOneResultTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array());
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			//Tests that printFooter logs one success in info when success is encountered with one run
			//and appends an '' to the end
			loggerMock.mock.method("info").withArgs("OK ({0} test{1})", 1, "").once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that the printFooter function is correctly logging multiple results on success")]
		public function printFooterSuccessfulMultipleResultsTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array());
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(2);
			
			//Tests that printFooter logs one success in info when success is encountered with multiple runs
			//and appends an 's' to the end
			loggerMock.mock.method("info").withArgs("OK ({0} test{1})", 2, "s").once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that the printFooter function is correctly logging a failure")]
		public function printFooterFailureTest():void {
			var resultMock:ResultMock = new ResultMock();
			resultMock.mock.property("runTime").returns(1729);
			resultMock.mock.property("failures").returns(new Array());
			resultMock.mock.property("successful").returns(false);
			resultMock.mock.property("runCount").returns(3);
			resultMock.mock.property("failureCount").returns(1);
			
			//Tests that printFooter logs one waring when a failure is encountered
			loggerMock.mock.method("warn").withArgs("FAILURES!!! Tests run: {0}, {1} Failures:", 3, 1).once;
			
			loggerMock.mock.method("info").withAnyArgs.zeroOrMoreTimes;
			
			textListener.testRunFinished(resultMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that testStarted function is correctly logged")]
		public function testStartedTest():void {
			var displayName:String = "testName";
			var descriptionMock:DescriptionMock = new DescriptionMock();
			descriptionMock.mock.property("displayName").returns(displayName);
			
			loggerMock.mock.method("info").withArgs(displayName + " .").once;
			
			textListener.testStarted(descriptionMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that testFailure function is correctly logged when an error is passed")]
		public function testFailureWithErrorTest():void {
			var displayName:String = "testName";
			var descriptionMock:DescriptionMock = new DescriptionMock();
			var failureMock:FailureMock = new FailureMock();
			
			descriptionMock.mock.property("displayName").returns(displayName);
			failureMock.mock.property("description").returns(descriptionMock);
			failureMock.mock.property("exception").returns(new Error());
			
			loggerMock.mock.method("error").withArgs(displayName + " E").once;
			
			textListener.testFailure(failureMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that testFailure function is correctly logged when an error not considered an error is passed")]
		public function testFailureWithNoErrorTest():void {
			var displayName:String = "testName";
			var descriptionMock:DescriptionMock = new DescriptionMock();
			var failureMock:FailureMock = new FailureMock();
			
			descriptionMock.mock.property("displayName").returns(displayName);
			failureMock.mock.property("description").returns(descriptionMock);
			failureMock.mock.property("exception").returns(new AssertionError());
			
			loggerMock.mock.method("warn").withArgs(displayName + " F").once;
			
			textListener.testFailure(failureMock);
			
			loggerMock.mock.verify();
		}
		
		[Test(description="Ensure that testIgnored function is correctly logged")]
		public function testIgnoredTest():void {
			var displayName:String = "testName";
			var descriptionMock:DescriptionMock = new DescriptionMock();
			descriptionMock.mock.property("displayName").returns(displayName);
			
			loggerMock.mock.method("info").withArgs(displayName + " I").once;
			
			textListener.testIgnored(descriptionMock);
			
			loggerMock.mock.verify();
		}
	}
}