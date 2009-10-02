package org.flexunit.runner.notification.async.cases
{
	import org.flexunit.AssertionError;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.mocks.ResultMock;
	import org.flexunit.runner.notification.mocks.FailureMock;
	import org.flexunit.runner.notification.async.XMLListener;

	public class XMLListenerCase
	{
		//TODO: All of the tests in this test case need to be finished.  How can they be tested with the socket?
		
		protected var xmlListener:XMLListener;
		protected var projectName:String;
		protected var contextName:String;
		
		[Before(description="Create a instance of the XMLListener class")]
		public function createXMLListener():void {
			projectName = "testProject";
			contextName = "testContext";
			xmlListener = new XMLListener(projectName, contextName);
		}
		
		[After(description="Remove the reference to the instance of the XMLListener class")]
		public function destroyXMLListener():void {
			xmlListener = null;
			projectName = null;
			contextName = null;
		}
		
		[Test(description="Ensure that the ready property returns false when the connection isn't ready")]
		public function readyFalseTest():void {
			xmlListener.ready;
		}
		
		[Test(description="Ensure that the ready property returns true when the connection is ready")]
		public function readyTrueTest():void {
			xmlListener.ready;
		}
		
		[Test(description="Ensure that the testRunStarted function sends the correct message")]
		public function testRunStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			var numberOfTests:int = 4
			
			descriptionMock.mock.property("testCount").returns(numberOfTests);
			
			xmlListener.testRunStarted(descriptionMock);
		}
		
		[Test(description="Ensure that the testRunFinished function sends the correct message")]
		public function testRunFinishedTest():void {
			var resultMock:ResultMock = new ResultMock();
			
			xmlListener.testRunFinished(resultMock);
		}
		
		//The method being tested currently does nothing
		[Test(description="")]
		public function testStartedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			
			xmlListener.testStarted(descriptionMock);
		}
		
		[Test(description="Ensure that the testFinished function sends the correct message")]
		public function testFinishedTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			//The descriptionMock still needs to be populated
		}
		
		//The method being tested currently does nothing
		[Test(description="")]
		public function testAssumptionFailureTest():void {
			var failureMock:FailureMock = new FailureMock();
			
			xmlListener.testAssumptionFailure(failureMock);
		}
		
		[Test(description="Ensure that the testIgnored function sends the correct message")]
		public function testIgnoredTest():void {
			var descriptionMock:DescriptionMock = new DescriptionMock();
			//The descriptionMock still needs to be populated
		}
		
		[Test(description="Ensure that the testFailure function sends the correct message when there is an error")]
		public function testFailureIsErrorTest():void {
			var failureMock:FailureMock = new FailureMock();
			var descriptionMock:DescriptionMock = new DescriptionMock();
			var failureMessage:String = "failureMessage";
			var stackTrace:String = "stackTrace";
			var error:Error = new Error();
			
			failureMock.mock.property("description").returns(descriptionMock);
			failureMock.mock.property("message").returns(failureMessage);
			failureMock.mock.property("stackTrace").returns(stackTrace);
			failureMock.mock.property("exception").returns(error);
			//The descriptionMock still needs to be populated
		}
		
		[Test(description="Ensure the testFailure function sends the correct message when there are no errors")]
		public function testFailureNoErrorTest():void {
			var failureMock:FailureMock = new FailureMock();
			var descriptionMock:DescriptionMock = new DescriptionMock();
			var failureMessage:String = "failureMessage";
			var stackTrace:String = "stackTrace";
			var error:AssertionError = new AssertionError();
			
			failureMock.mock.property("description").returns(descriptionMock);
			failureMock.mock.property("message").returns(failureMessage);
			failureMock.mock.property("stackTrace").returns(stackTrace);
			failureMock.mock.property("exception").returns(error);
			//The descriptionMock still needs to be populated
		}
	}
}