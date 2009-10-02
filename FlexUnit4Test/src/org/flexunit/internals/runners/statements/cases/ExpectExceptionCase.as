package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.ExpectException;
	import org.flexunit.internals.runners.statements.mock.AsyncStatementMock;
	import org.flexunit.runner.manipulation.NoTestsRemainException;
	import org.flexunit.runner.notification.StoppedByUserException;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class ExpectExceptionCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var exceptionClass:String = "org.flexunit.runner.notification.StoppedByUserException";
		
		[Test(description="Ensure that the hasExpected method returns a value of null if the framework methods does not contain expects or expected")]
		public function hasExpectedNullTest():void {
			var methodMock:FrameworkMethodMock = new FrameworkMethodMock();
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expects").once.returns(null);
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expected").once.returns(null);
			
			Assert.assertNull( ExpectException.hasExpected(methodMock) );
			
			methodMock.mock.verify();
		}
		
		[Test(description="Ensure that the hasExpected method returns the expected string if it contains a value of 'expects'")]
		public function hasExpectedExpectsTest():void {
			var expectsString:String = "expects";
			var methodMock:FrameworkMethodMock = new FrameworkMethodMock();
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expects").once.returns(expectsString);
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expected").never.returns(null);
			
			Assert.assertEquals( expectsString, ExpectException.hasExpected(methodMock) );
			
			methodMock.mock.verify();
		}
		
		[Test(description="Ensure that the hasExpected method returns the expected string if it contains a value of 'expected'")]
		public function hasExpectedExpectedTest():void {
			var expectedString:String = "expected";
			var methodMock:FrameworkMethodMock = new FrameworkMethodMock();
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expects").once.returns(null);
			methodMock.mock.method("getSpecificMetaDataArg").withArgs("Test", "expected").once.returns(expectedString);
			
			Assert.assertEquals( expectedString, ExpectException.hasExpected(methodMock) );
			
			methodMock.mock.verify();
		}
		
		[Test(description="Ensure that the evaluate method correctly works when IAsyncStatment does not throw an error")]
		public function evaluateNoExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			
			statement.mock.method("evaluate").withArgs(AsyncTestToken).once;
			
			expectException.evaluate(parentToken);
			
			statement.mock.verify();
		}
		
		//TODO: Ensure that this test is being properly run, how can it be verified that the right child result is generated?
		[Test(description="Ensure that the evaluate method correctly works when IAsyncStatment throws a valid error")]
		public function evaluateValidExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var stoppedByUserException:StoppedByUserException = new StoppedByUserException();
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			
			statement.mock.method("evaluate").withArgs(AsyncTestToken).once.andThrow(stoppedByUserException);
			//Check to see if the parent token's send result is called with null, this will verify that the exception was expected
			parentToken.mock.method("sendResult").withArgs(null).once;
			
			expectException.evaluate(parentToken);
			
			statement.mock.verify();
			parentToken.mock.verify();
		}
		
		//TODO: Ensure that this test is being properly run, how can it be verified that the right child result is generated?
		[Test(description="Ensure that the evaluate method correctly works when IAsyncStatment throws a non-valid error")]
		public function evaluateNonValidExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var noTestRemainException:NoTestsRemainException = new NoTestsRemainException();
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			
			statement.mock.method("evaluate").withArgs(AsyncTestToken).once.andThrow(noTestRemainException);
			//Check to see if the parent token's send result is called with an Error, this will verify that the exception was expected
			parentToken.mock.method("sendResult").withArgs(Error).once;
			
			expectException.evaluate(parentToken);
			
			statement.mock.verify();
			parentToken.mock.verify();
		}
		
		//TODO: Is there a way that this can be verified without the parentToken?
		[Ignore]
		[Test(description="Ensure that the handleNextExecuteComplete correctly works with a ChildResult error that is valid")]
		public function handleNextExecuteCompleteWithValidResultTest():void {
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			var stoppedByUserException:StoppedByUserException = new StoppedByUserException();
			var childResult:ChildResult = new ChildResult(asyncTestToken, stoppedByUserException);
			
			expectException.handleNextExecuteComplete(childResult);
		}
		
		//TODO: Is there a way that this can be verified without the parentToken?
		[Ignore]
		[Test(description="Ensure that the handleNextExecuteComplete correctly works with a ChildResult error that is not valid")]
		public function handleNextExecuteCompleteWithNonValidResultTest():void {
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			var asyncTestToken:AsyncTestToken = new AsyncTestToken();
			var noTestRemainException:NoTestsRemainException = new NoTestsRemainException();
			var childResult:ChildResult = new ChildResult(asyncTestToken, noTestRemainException);
			
			expectException.handleNextExecuteComplete(childResult);
		}
		
		//TODO: How can the result.error logic be run if no childResult exists?  If a child result exists and it has an error, 
		//the !receivedError logic will not be tripped
		[Ignore]
		[Test(description="Ensure that the handleNextExecuteComplete correctly works with a ChildResult error that is not valid")]
		public function handleNextExecuteCompleteNoResultTest():void {
			var statement:AsyncStatementMock = new AsyncStatementMock();
			var expectException:ExpectException = new ExpectException(exceptionClass, statement);
			
			expectException.handleNextExecuteComplete(null);
		}
	}
}