package org.flexunit.async.cases
{
	import flexunit.framework.TestCase;
	
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.internals.runners.statements.mock.AsyncHandlingStatementMock;

	public class AsyncLocatorCase
	{
		[Test(description="Ensure an IAsyncHandlingStatement is successfully registered to a TestCase")]
		public function registerStatementForTestTest():void {
			var asyncHandlingStatementMock:AsyncHandlingStatementMock = new AsyncHandlingStatementMock();
			var testCase:Object = new Object();
			
			AsyncLocator.registerStatementForTest(asyncHandlingStatementMock, testCase);
			
			Assert.assertEquals( asyncHandlingStatementMock, AsyncLocator.getCallableForTest(testCase) );
		}
		
		[Test(expected="org.flexunit.AssertionError",
			description="Ensure an AssertionError is thrown when no IAsyncHandlingStatement is returned for a given TestCase")]
		public function getCallableForNonExistingTestTest():void {
			AsyncLocator.getCallableForTest( new Object() );
		}
		
		//This test is not expecting an error in order to prevent the test from passing if the first getCallableForTest were to throw and error
		[Test(description="Ensure an IAsyncHandlingStatement is successfully removed for a given TestCase")]
		public function cleanUpCallableForTestTest():void {
			var asyncHandlingStatementMock:AsyncHandlingStatementMock = new AsyncHandlingStatementMock();
			var testCase:Object = new Object();
			
			AsyncLocator.registerStatementForTest(asyncHandlingStatementMock, testCase);
			
			//Verify that the object that implements the IAsyncHandlingStatement has been added successfully
			Assert.assertEquals( asyncHandlingStatementMock, AsyncLocator.getCallableForTest(testCase) );
			
			AsyncLocator.cleanUpCallableForTest(testCase);	
			
			//Try to retrieve the object that implements the IAsyncHandlingStatement for the now cleaned testCase, an error should be thrown
			try {
				AsyncLocator.getCallableForTest(testCase);
				Assert.fail("An error should have been thrown before this was called");
			} catch(e:AssertionError) {
				
			}
		}
	}
}