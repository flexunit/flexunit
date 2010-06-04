package org.flexunit.experimental.runners.statements.cases
{
	import mockolate.runner.MockolateRunner; MockolateRunner; 
	import mockolate.strict;
	import mockolate.mock;
	import mockolate.verify;
	
	import org.flexunit.experimental.runners.statements.TheoryBlockRunnerStatement;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.experimental.theories.internals.Assignments;


	
	[RunWith("mockolate.runner.MockolateRunner")]
	public class TheoryBlockRunnerStatementCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		[Mock(type="strict")]
		public var asyncStatementMock:IAsyncStatement;
		
		[Mock(type="strict")]
		public var theoryAnchorMock:TheoryAnchor;
		
		[Mock(type="strict")]
		public var assignmentsMock:Assignments;
		
		[Mock(type="strict")]
		public var parentToken:AsyncTestToken;
		
		protected var theoryBlockRunnerStatement:TheoryBlockRunnerStatement;
		
		[Before(description="Create an instance of the TheoryBlockRunnerStatement case")]
		public function createTheoryBlockRunnerStatement():void {
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

			//set expectations
			mock(asyncStatementMock).method("evaluate").args(AsyncTestToken).once();
			theoryBlockRunnerStatement.evaluate(parentToken);
			
			//verify expectations
			verify(asyncStatementMock);
		}
		[Ignore("Until ClassInternal Namespace can be recognized")]
		[Test(description="Ensure that the evalute function correctly works when an AssumptionViolatedException is thrown")]
		public function evaluateAssumptionViolatedExceptionTest():void {
			
			var assumptionViolationException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
			//Set expectations
			mock(asyncStatementMock).method("evaluate").args(AsyncTestToken).throws(assumptionViolationException).once();
			mock(theoryAnchorMock).method("handleAssumptionViolation").args(assumptionViolationException).once();
			mock(parentToken).method("sendResult").args(assumptionViolationException).once();
			
			theoryBlockRunnerStatement.evaluate(parentToken);
			//verify expectations
			verify(asyncStatementMock);
			verify(theoryAnchorMock);
			verify(parentToken);
		}
		
		[Ignore]
		[Test(description="Ensure that the evalute function correctly works when an exception other than an AssumptionViolatedException is thrown")]
		public function evaluateOtherExceptionTest():void {
//			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var error:Error = new Error();
//			var argumentsArray:Array = new Array();
//			
//			//Set expectations
//			asyncStatementMock.mock.method("evaluate").withArgs(AsyncTestToken).once.andThrow(error);
//			theoryAnchorMock.mock.method("reportParameterizedError").withArgs(error, argumentsArray).once;
//			assignmentsMock.mock.method("getArgumentStrings").withArgs(true).once.returns(argumentsArray);
//			theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
//			
//			theoryBlockRunnerStatement.evaluate(parentToken);
//			
//			//Check that the expectations were met
//			asyncStatementMock.mock.verify();
//			theoryAnchorMock.mock.verify();
//			assignmentsMock.mock.verify();
		}
		
		//TODO: The parent token isn't currently getting set, how can this test be designed to correctly work?
		[Ignore("Unsure if we will be able to set a token ahead of time, leaving test must resolve")]
		[Test(description="Ensure that the handleChildExecuteComplete function if the ChildResult's error is an AssumptionViolatedException")]
		public function handleChildExecuteCompleteErrorTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var assumptionViolationException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, assumptionViolationException);
//			
//			//Set expectations
//			theoryAnchorMock.mock.method("handleDataPointSuccess").withNoArgs.never;
//			
//			theoryBlockRunnerStatement.handleChildExecuteComplete(childResult);
//			
//			//Check that the expectations were met
//			theoryAnchorMock.mock.verify();
		}
		
		//TODO: The parent token isn't currently getting set, how can this test be designed to correctly work?
		[Ignore("Unsure if we will be able to set a token ahead of time, leaving test must resolve")]
		[Test(description="Ensure that the handleChildExecuteComplete function if the ChildResult's has no error")]
		public function handleChildExecuteCompleteNoErrorTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock);
//			
//			//Set expectations
//			theoryAnchorMock.mock.method("handleDataPointSuccess").withNoArgs.once;
//			
//			theoryBlockRunnerStatement.handleChildExecuteComplete(childResult);
//			
//			//Check that the expectations were met
//			theoryAnchorMock.mock.verify();
		}
	}
}