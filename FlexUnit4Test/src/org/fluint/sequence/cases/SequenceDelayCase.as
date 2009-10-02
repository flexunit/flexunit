package org.fluint.sequence.cases
{
	import org.flexunit.Assert;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.internals.runners.statements.mock.AsyncHandlingStatementMock;
	import org.fluint.sequence.SequenceDelay;
	import org.fluint.sequence.mocks.SequenceRunnerMock;

	public class SequenceDelayCase
	{
		//TODO: Is it possible to test this case?  The timer is private and that is the target.
		[Test(description="Ensure that the setupListeners function properly operates ")]
		public function setupListenersTest():void {
			var testCase:Object = new Object();
			var sequence:SequenceRunnerMock = new SequenceRunnerMock();	
			var timeout:int = 1000;
			var sequenceDelay:SequenceDelay = new SequenceDelay(timeout);
			
			//Create an AsyncHandlingStatementMock and register it to to the AsyncLocator
			var asyncHandlingStatementMock:AsyncHandlingStatementMock = new AsyncHandlingStatementMock();
			AsyncLocator.registerStatementForTest(asyncHandlingStatementMock, testCase);
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs( asyncHandlingStatementMock.handleNextSequence, timeout + 900000, sequence, null).once.returns(new Function());
			
			sequenceDelay.setupListeners(testCase, sequence);
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
			
			//Remove the reference from the AsyncLocator for the testCase
			AsyncLocator.cleanUpCallableForTest(testCase);
		}
		
		[Test(description="Ensure that the forSeconds function creates an instance of the SequenceDelay class with the correct timeout")]
		public function Test():void {
			var sequenceDelay:SequenceDelay = SequenceDelay.forSeconds(10);
			
			Assert.assertNotNull( sequenceDelay );
			Assert.assertEquals( 910000, sequenceDelay.timeout );
		}
	}
}