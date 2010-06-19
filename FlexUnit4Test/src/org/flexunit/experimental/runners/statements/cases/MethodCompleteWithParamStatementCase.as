package org.flexunit.experimental.runners.statements.cases
{
	import flex.lang.reflect.mocks.MethodMock;
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.runners.statements.MethodCompleteWithParamsStatement;
	import org.flexunit.experimental.runners.statements.Mock.TheoryAnchorMock;
	import org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException;
	import org.flexunit.experimental.theories.internals.mocks.AssignmentsMock;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class MethodCompleteWithParamStatementCase
	{
		protected var methodCompleteWithParamStatement:MethodCompleteWithParamsStatement;
		protected var frameworkMethodMock:FrameworkMethodMock;
		protected var theoryAnchorMock:TheoryAnchorMock;
		protected var assignmentsMock:AssignmentsMock;
		protected var freshInstance:Object;
		
		[Before(description="Create an instance of the MethodCompleteWithParamStatement class")]
		public function createMethodCompleteWithParamStatement():void {
			frameworkMethodMock = new FrameworkMethodMock();
			theoryAnchorMock = new TheoryAnchorMock();
			assignmentsMock = new AssignmentsMock();
			freshInstance = new Object();
			methodCompleteWithParamStatement = new MethodCompleteWithParamsStatement(frameworkMethodMock, theoryAnchorMock, assignmentsMock, freshInstance);
		}
		
		[After(description="Remove the reference to the instance of the MethodCompleteWithParamStatement class")]
		public function destroyMethodCompleteWithParamStatement():void {
			methodCompleteWithParamStatement = null;
			frameworkMethodMock = null;
			theoryAnchorMock = null;
			assignmentsMock = null;
			freshInstance = null;
		}
		
		[Ignore("Expectations on this test seem to be managed incorrectly")]
		[Test(description="Ensure that the evaluate function makes the correct calls when no exception is thrown")]
		public function evaluateNoExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var argumentsArray:Array = new Array();
			
			//Set properties and expecations
			assignmentsMock.mock.method("getMethodArguments").withArgs(true).once.returns(argumentsArray);
			theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
			frameworkMethodMock.mock.method("applyExplosively").withArgs(freshInstance, argumentsArray).once;
			parentToken.mock.method("sendResult").withNoArgs.once;
				
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			assignmentsMock.mock.verify();
			theoryAnchorMock.mock.verify();
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the evaluate function makes the correct calls when an CouldNotGenerateValueException is thrown")]
		public function evaluateCouldNotGenerateValueExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var argumentsArray:Array = new Array();
			var couldNotGenerateValueException:CouldNotGenerateValueException = new CouldNotGenerateValueException();
			
			//Set properties and expecations
			assignmentsMock.mock.method("getMethodArguments").withArgs(true).once.returns(argumentsArray);
			theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
			frameworkMethodMock.mock.method("applyExplosively").withArgs(freshInstance, argumentsArray).once.andThrow(couldNotGenerateValueException);
			parentToken.mock.method("sendResult").withArgs(null).once;
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			assignmentsMock.mock.verify();
			theoryAnchorMock.mock.verify();
			frameworkMethodMock.mock.verify();
			parentToken.mock.verify();
		}
		
		[Test(description="Ensure that the evaluate function makes the correct calls when an AssumptionViolatedException is thrown")]
		public function evaluateAssumptionViolatedExceptionTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var argumentsArray:Array = new Array();
			var assumptionViolatedException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
			
			//Set properties and expecations
			assignmentsMock.mock.method("getMethodArguments").withArgs(true).once.returns(argumentsArray);
			theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
			frameworkMethodMock.mock.method("applyExplosively").withArgs(freshInstance, argumentsArray).once.andThrow(assumptionViolatedException);
			theoryAnchorMock.mock.method("handleAssumptionViolation").withArgs(assumptionViolatedException).once;
			parentToken.mock.method("sendResult").withArgs(assumptionViolatedException).once;
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			assignmentsMock.mock.verify();
			theoryAnchorMock.mock.verify();
			frameworkMethodMock.mock.verify();
			parentToken.mock.verify();
		}
		
		[Test(description="Ensure that the evaluate function makes the correct calls when an other exception thrown")]
		public function evaluateOtherExceptionsTest():void {
			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			var argumentsArray:Array = new Array();
			var error:Error = new Error();
			var newError:Error = new Error();
			
			//Set properties and expecations
			assignmentsMock.mock.method("getMethodArguments").withArgs(true).once.returns(argumentsArray);
			assignmentsMock.mock.method("getArgumentStrings").withArgs(true).once.returns(argumentsArray);
			theoryAnchorMock.mock.method("nullsOk").withNoArgs.twice.returns(true);
			
			frameworkMethodMock.mock.method("applyExplosively").withArgs(freshInstance, argumentsArray).once.andThrow(error);
			theoryAnchorMock.mock.method("reportParameterizedError").withArgs(error, argumentsArray).once.returns(newError);
			parentToken.mock.method("sendResult").withArgs(newError).once;
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			assignmentsMock.mock.verify();
			theoryAnchorMock.mock.verify();
			frameworkMethodMock.mock.verify();
			parentToken.mock.verify();
		}
		
		//TODO: Determine how to correctly execute this test when the parent token has not been set
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete correctly calls sendComplete")]
		public function handleChildExecuteCompleteTest():void {
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var messageString:String = "message";
			var error:Error = new Error(messageString);
			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, error);
			
			methodCompleteWithParamStatement.handleChildExecuteComplete(childResult);
		}
		
		[Test(description="Ensure that the toString method returns a valid string value")]
		public function toStringTest():void {
			var methodMock:MethodMock = new MethodMock();
			var nameString:String = "testName";
			var assignmentsString:String = "assignments";
			
			//Set properties and expecations
			frameworkMethodMock.mock.property("methud").returns(methodMock);
			methodMock.mock.property("name").returns(nameString);
			assignmentsMock.mock.method("twoString").withNoArgs.once.returns(assignmentsString);
			
			//Create the statement string to be expected
			var statementString:String = "MethodCompleteWithParamsStatement :\n";
			statementString += "          Method : "+ nameString + "\n";		
			statementString += "          Complete :\n"+ assignmentsString + "\n";		
			statementString += "          Instance : "+ freshInstance;
			
			Assert.assertEquals( statementString, methodCompleteWithParamStatement.toString() );
			
			assignmentsMock.mock.verify();
		}
	}
}