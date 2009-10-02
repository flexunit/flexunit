package org.flexunit.internals.cases
{
	import org.flexunit.AssertionError;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.mocks.ResultMock;
	import org.flexunit.runner.notification.mocks.FailureMock;

	public class TraceListenerCase
	{
		//TODO: There doesn't appear to be a way to test this class since it only does traces. Can this be altered?
		
		protected var traceListener:TraceListener;
		
		[Before(description="Create an instance of the TraceListener class")]
		public function createTraceListener():void {
			traceListener = new TraceListener();
		}
		
		[After(description="Remove the reference to the instance of the TraceListener class")]
		public function destroyTraceListener():void {
			traceListener = null;
		}
		
		[Test]
		public function testRunFinishedTest():void {
			var resultMock:ResultMock = new ResultMock();
			
			resultMock.mock.property("runTime").returns(123);
			resultMock.mock.property("failures").returns([]);
			resultMock.mock.property("successful").returns(true);
			resultMock.mock.property("runCount").returns(1);
			
			traceListener.testRunFinished(resultMock);
		}

		[Test]
		public function testStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			descriptionMock.mock.property("displayName").returns("testName");
			
			traceListener.testStarted(descriptionMock);
		}

		[Test]
		public function testFailureNotErrorTest():void {
			var failureMock:FailureMock = new FailureMock();
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			failureMock.mock.property("exception").returns(new AssertionError());
			failureMock.mock.property("description").returns(descriptionMock);
			descriptionMock.mock.property("displayName").returns("testName");
			
			traceListener.testFailure(failureMock);
		}

		[Test]
		public function testFailureErrorTest():void {
			var failureMock:FailureMock = new FailureMock();
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			failureMock.mock.property("exception").returns(new Error());
			failureMock.mock.property("description").returns(descriptionMock);
			descriptionMock.mock.property("displayName").returns("testName");
			
			traceListener.testFailure(failureMock);
		}

		[Test]
		public function testIgnoredTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			descriptionMock.mock.property("displayName").returns("testName");
			
			traceListener.testIgnored(descriptionMock);
		}
	}
}