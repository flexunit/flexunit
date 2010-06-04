package org.flexunit.experimental.runners.statements.cases
{

	import flex.lang.reflect.Method;
	
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.runners.statements.MethodCompleteWithParamsStatement;
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	public class MethodCompleteWithParamStatementCase
	{
		
		//------------------------------
		// MOCKOLATE
		//------------------------------
		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock(type="strict")]
		public var parentToken:AsyncTestToken;
		
		[Mock(type="strict")]
		public var assignmentsMock:Assignments;
		
		[Mock(type="strict")]
		public var frameworkMethodMock:FrameworkMethod;
		
		[Mock(type="strict", inject="false")]
		public var theoryAnchorMock:TheoryAnchor;

		[Mock(type="strict", inject="false")]
		public var methodMock:Method;
		
		
		
		protected var freshInstance:Object;
		protected var methodCompleteWithParamStatement:MethodCompleteWithParamsStatement;
		
		
		
		//------------------------
		// SETUP BEFORE EACH TEST
		//------------------------
		[Before(description="Create an instance of the MethodCompleteWithParamStatement class")]
		public function createMethodCompleteWithParamStatement():void {
			theoryAnchorMock = strict(TheoryAnchor,null,[frameworkMethodMock,null]);
			methodMock = strict(Method,null,[new XML(),false]);
			freshInstance = new Object();
			methodCompleteWithParamStatement = new MethodCompleteWithParamsStatement(frameworkMethodMock, theoryAnchorMock, assignmentsMock, freshInstance);
		}
		//--------------------------
		// TEARDOWN AFTER EACH TEST
		//--------------------------
		[After(description="Remove the reference to the instance of the MethodCompleteWithParamStatement class")]
		public function destroyMethodCompleteWithParamStatement():void {
			parentToken = null;
			assignmentsMock = null;
			frameworkMethodMock = null;
			theoryAnchorMock = null;
			methodMock = null;
			freshInstance = null;
			methodCompleteWithParamStatement = null;
		}
		
		//-------------------------
		// TESTS
		//-------------------------
		[Ignore("Until ClassInternal Namespace can be recognized")]
		[Test(description="Ensure that the evaluate function makes the correct calls when no exception is thrown")]
		public function evaluateNoExceptionTest():void {
			
			var argumentsArray:Array = new Array();
			
			//Set properties and expectations
			mock(assignmentsMock).method("getMethodArguments").args(true).returns(argumentsArray).once();
			mock(theoryAnchorMock).method("nullsOk").noArgs().returns(true).once();
			mock(frameworkMethodMock).method("applyExplosively").args(freshInstance, argumentsArray).once();
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			verify(assignmentsMock);
			verify(theoryAnchorMock);
			verify(frameworkMethodMock);
		}
		[Ignore("Until ClassInternal Namespace can be recognized")]
		[Test(description="Ensure that the evaluate function makes the correct calls when an CouldNotGenerateValueException is thrown")]
		public function evaluateCouldNotGenerateValueExceptionTest():void {
			
			var argumentsArray:Array = new Array();
			var couldNotGenerateValueException:CouldNotGenerateValueException = new CouldNotGenerateValueException();
			
			mock(assignmentsMock).method("getMethodArguments").args(true).returns(argumentsArray).once();
			mock(theoryAnchorMock).method("nullsOk").noArgs().returns(true).once();
			mock(frameworkMethodMock).method("applyExplosively").args(freshInstance, argumentsArray).throws(couldNotGenerateValueException).once();
			mock(parentToken).method("sendResult").args(null).once();
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			verify(assignmentsMock);
			verify(theoryAnchorMock);
			verify(frameworkMethodMock);
			verify(parentToken);
		}
		[Ignore("Until ClassInternal Namespace can be recognized")]
		[Test(description="Ensure that the evaluate function makes the correct calls when an AssumptionViolatedException is thrown")]
		public function evaluateAssumptionViolatedExceptionTest():void {
			
			var argumentsArray:Array = new Array();
			var assumptionViolatedException:AssumptionViolatedException = new AssumptionViolatedException(new Object());

			mock(assignmentsMock).method("getMethodArguments").args(true).returns(argumentsArray).once();
			mock(theoryAnchorMock).method("nullsOk").noArgs().returns(true).once();
			mock(frameworkMethodMock).method("applyExplosively").args(freshInstance, argumentsArray).throws(assumptionViolatedException).once();
			mock(theoryAnchorMock).method("handleAssumptionViolation").args(assumptionViolatedException).once();
			mock(parentToken).method("sendResult").args(assumptionViolatedException).once();
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			verify(assignmentsMock);
			verify(theoryAnchorMock);
			verify(frameworkMethodMock);
			verify(parentToken);
		}
		[Ignore("Until ClassInternal Namespace can be recognized")]
		[Test(description="Ensure that the evaluate function makes the correct calls when an other exception thrown")]
		public function evaluateOtherExceptionsTest():void {
			
			var argumentsArray:Array = new Array();
			var error:Error = new Error();
			var newError:Error = new Error();
			
			mock(assignmentsMock).method("getMethodArguments").args(true).returns(argumentsArray).once();
			mock(assignmentsMock).method("getArgumentStrings").args(true).returns(argumentsArray).once();
			mock(theoryAnchorMock).method("nullsOk").noArgs().returns(true).twice();
			
			mock(frameworkMethodMock).method("applyExplosively").args(freshInstance, argumentsArray).throws(error).once();
			mock(theoryAnchorMock).method("reportParameterizedError").args(error,argumentsArray).returns(newError).once();
			mock(frameworkMethodMock).getter("name").returns("name");
			mock(parentToken).method("sendResult").args(Error).once();
			
			methodCompleteWithParamStatement.evaluate(parentToken);
			
			verify(assignmentsMock);
			verify(theoryAnchorMock);
			verify(frameworkMethodMock);
			verify(parentToken);
		}
		
		//TODO: Determine how to correctly execute this test when the parent token has not been set
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete correctly calls sendComplete")]
		public function handleChildExecuteCompleteTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var messageString:String = "message";
//			var error:Error = new Error(messageString);
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, error);
//			
//			methodCompleteWithParamStatement.handleChildExecuteComplete(childResult);
		}
		
		[Test(description="Ensure that the toString method returns a valid string value")]
		public function toStringTest():void {
			

			var nameString:String = "testName";
			var assignmentsString:String = "assignments";
			
			mock(frameworkMethodMock).getter("method").returns(methodMock);
			mock(methodMock).getter("name").returns(nameString);
			mock(assignmentsMock).method("toString").noArgs().returns(assignmentsString).once();
			
			var statementString:String = "MethodCompleteWithParamsStatement :\n";
			statementString += "          Method : "+ nameString + "\n";		
			statementString += "          Complete :\n"+ assignmentsString + "\n";		
			statementString += "          Instance : "+ freshInstance;
			
			Assert.assertEquals( statementString, methodCompleteWithParamStatement.toString() );
			
			verify(assignmentsMock);
			verify(frameworkMethodMock);
		}
	}
}