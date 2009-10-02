package org.flexunit.experimental.runners.statements.cases
{
	import org.flexunit.experimental.runners.statements.Mock.TheoryAnchorMock;
	import org.flexunit.experimental.runners.statements.TheoryBlockRunnerStatement;
	import org.flexunit.experimental.theories.internals.mocks.AssignmentsMock;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.runners.statements.mock.AsyncStatementMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class TheoryBlockRunnerStatementCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var theoryBlockRunnerStatement:TheoryBlockRunnerStatement;
		protected var asyncStatementMock:AsyncStatementMock;
		protected var theoryAnchorMock:TheoryAnchorMock;
		protected var assignmentsMock:AssignmentsMock;
		
		[Before(description="Create an instance of the TheoryBlockRunnerStatement case")]
		public function createTheoryBlockRunnerStatement():void {
			asyncStatementMock = new AsyncStatementMock();
			theoryAnchorMock = new TheoryAnchorMock();
			assignmentsMock = new AssignmentsMock();
			theoryBlockRunnerStatement = new TheoryBlockRunnerStatement(asyncStatementMock, theoryAnchorMock, assignmentsMock);
		}
		
		[After(description="Remove the reference to the instance of the TheoryBlockRunnerStatement")]
		public function destroyTheoryBlockRunnerStatement():void {
			theoryBlockRunnerStatement = null;
			asyncStatementMock = null;
			theoryAnchorMock = null;
			assignmentsMock = null;
		}
		
		[Test(description="Ensure that the evalute function correctly works when no exception is thrown")]
		public function evaluateNoExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			
			//Set expectations
			asyncStatementMock.mock.method("evaluate").withArgs(AsyncTestToken).once;
			
			theoryBlockRunnerStatement.evaluate(parentToken);
			
			//Check that the expectations were met
			asyncStatementMock.mock.verify();
		}
		
		[Test(description="Ensure that the evalute function correctly works when an AssumptionViolatedException is thrown")]
		public function evaluateAssumptionViolatedExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var assumptionViolationException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
			
			//Set expectations
			asyncStatementMock.mock.method("evaluate").withArgs(AsyncTestToken).once.andThrow(assumptionViolationException);
			theoryAnchorMock.mock.method("handleAssumptionViolation").withArgs(assumptionViolationException).once;
			parentToken.mock.method("sendResult").withArgs(assumptionViolationException).once;
			
			theoryBlockRunnerStatement.evaluate(parentToken);
			
			//Check that the expectations were met
			asyncStatementMock.mock.verify();
			theoryAnchorMock.mock.verify();
			parentToken.mock.verify();
		}
		
		[Ignore]
		[Test(description="Ensure that the evalute function correctly works when an exception other than an AssumptionViolatedException is thrown")]
		public function evaluateOtherExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var error:Error = new Error();
			var argumentsArray:Array = new Array();
			
			//Set expectations
			asyncStatementMock.mock.method("evaluate").withArgs(AsyncTestToken).once.andThrow(error);
			theoryAnchorMock.mock.method("reportParameterizedError").withArgs(error, argumentsArray).once;
			assignmentsMock.mock.method("getArgumentStrings").withArgs(true).once.returns(argumentsArray);
			theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
			
			theoryBlockRunnerStatement.evaluate(parentToken);
			
			//Check that the expectations were met
			asyncStatementMock.mock.verify();
			theoryAnchorMock.mock.verify();
			assignmentsMock.mock.verify();
		}
		
		//TODO: The parent token isn't currently getting set, how can this test be designed to correctly work?
		[Ignore("Unsure if we will be able to set a token ahead of time, leaving test must resolve")]
		[Test(description="Ensure that the handleChildExecuteComplete function if the ChildResult's error is an AssumptionViolatedException")]
		public function handleChildExecuteCompleteErrorTest():void {
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var assumptionViolationException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, assumptionViolationException);
			
			//Set expectations
			theoryAnchorMock.mock.method("handleDataPointSuccess").withNoArgs.never;
			
			theoryBlockRunnerStatement.handleChildExecuteComplete(childResult);
			
			//Check that the expectations were met
			theoryAnchorMock.mock.verify();
		}
		
		//TODO: The parent token isn't currently getting set, how can this test be designed to correctly work?
		[Ignore("Unsure if we will be able to set a token ahead of time, leaving test must resolve")]
		[Test(description="Ensure that the handleChildExecuteComplete function if the ChildResult's has no error")]
		public function handleChildExecuteCompleteNoErrorTest():void {
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var childResult:ChildResult = new ChildResult(asyncTestTokenMock);
			
			//Set expectations
			theoryAnchorMock.mock.method("handleDataPointSuccess").withNoArgs.once;
			
			theoryBlockRunnerStatement.handleChildExecuteComplete(childResult);
			
			//Check that the expectations were met
			theoryAnchorMock.mock.verify();
		}
	}
}