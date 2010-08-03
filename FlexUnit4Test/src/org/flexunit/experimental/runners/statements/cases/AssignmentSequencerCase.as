package org.flexunit.experimental.runners.statements.cases
{
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.experimental.runners.statements.AssignmentSequencer;
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;

	use namespace classInternal;
	
	public class AssignmentSequencerCase
	{
		//TODO: This test case still needs additional classes written for it
		//Not all of the code in sendComplete will be reached because no errors are passed to it in the AssignmentSequencerC class
		
		protected var assignmentSequencer:AssignmentSequencer;
		protected var testClass:Class;
		
		//----------------------
		// MOCKOLATE
		//---------------------
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock(type="strict")]
		public var assignmentsMock:Assignments;
		[Mock(type="strict")]
		public var parentToken:AsyncTestToken;
		[Mock(type="strict")]
		public var frameworkMethodMock:FrameworkMethod;
		[Mock(type="strict")]
		public var theoryAnchorMock:TheoryAnchor;
		
		
		//-----------------------
		// SETUP
		//-----------------------
		[Before(description="Create an instance of the AssignmentSequencer class")]
		public function createAssignmentSequencer():void {	
			testClass = Object;
			assignmentSequencer = new AssignmentSequencer(assignmentsMock, frameworkMethodMock, testClass, theoryAnchorMock)
		}
		
		//----------------------
		// TEAR DOWN
		//-----------------------
		[After(description="Remove the reference to the instance of the AssignmentSequencer class")]
		public function destroyAssignmentSequencer():void {
			assignmentsMock = null;
			parentToken = null;
			frameworkMethodMock = null;
			theoryAnchorMock = null;
			assignmentSequencer = null;
			testClass = null;
		}
		//------------------------
		// TEST METHODS
		//------------------------
		[Test(description="Ensure that the evaluate function calls handleChildExecuteComplete with a null ChildResult if the parameterAssignment's complete property is false")]
		public function evaluateNotCompleteTest():void {
			
			//Set the parameterAssignment's complete property to false
			mock(assignmentsMock).getter("complete").returns(false);
			
			//Set expectations
			mock(assignmentsMock).method("potentialsForNextUnassigned").noArgs().returns(new Array()).once();
			mock(parentToken).method("sendResult").args(null).once();
			
			
			assignmentSequencer.evaluate(parentToken);
			
			//Verify expectations were met
			verify(assignmentsMock);
			verify(parentToken);
		}
		
		//TODO: This test is running into an issue with the nullsOk method in the theoryAnchorMock
		[Ignore]
		[Test(description="Ensure that the evaluate function calls runWithCompleteAssignment with the parameterAssignment if the parameterAssignment's complete property is false")]
		public function evaluateCompleteTest():void {

			mock(assignmentsMock).getter("complete").returns(true);
			
			mock(theoryAnchorMock).method("reportParameterizedError").args(Error,[]).once();
			mock(assignmentsMock).method("getArgumentStrings").args(true).returns(new Array()).once();
			mock(theoryAnchorMock).method("nullsOk").noArgs().returns(true).once();
			
			assignmentSequencer.evaluate(parentToken);
			
			//verify(theoryAnchorMock2);
			//verify(assignmentsMock2);
			//Set the parameterAssignment's complete property to true
			//assignmentsMock.mock.property("complete").returns(true);
			
			//Set expectations, this will ensure that parameterAssignment has been called
			//theoryAnchorMock.mock.method("reportParameterizedError").withArgs(Error, Array).once;
			//assignmentsMock.mock.method("getArgumentStrings").withArgs(true).once.returns(Array);
			//theoryAnchorMock.mock.method("nullsOk").withNoArgs.once.returns(true);
			
			//assignmentSequencer.evaluate(parentToken);
			
			//Verify expectations were met
			//theoryAnchorMock.mock.verify();
			//assignmentsMock.mock.verify();
		}
		
		//TODO: This function will call sendComplete and there currently isn't a parent token, this will cause this test to fail
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete function correctly operates when there are no errors and no potential array")]
		public function handleChildExecuteCompleteNoPotentialTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock);
//			
//			assignmentSequencer.handleChildExecuteComplete(childResult);
		}
		
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete function correctly operates when there are no errors, there is a potential array, and the counter is less than the length of the array")]
		public function handleChildExecuteCompletePotentialTest():void {
//			var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var potentialAssignmentMock:PotentialAssignmentMock = new PotentialAssignmentMock();
//			var array:Array = [potentialAssignmentMock];
//			
//			//Set the parameterAssignment's complete property to false
//			assignmentsMock.mock.property("complete").returns(false);
//			
//			//Set expectations
//			assignmentsMock.mock.method("potentialsForNextUnassigned").withNoArgs.once.returns(array);
//			assignmentsMock.mock.method("assignNext").withArgs(potentialAssignmentMock).once;
//			
//			assignmentSequencer.evaluate(parentToken);
//			
//			//Verify expectations were met
//			assignmentsMock.mock.verify();
		}
		
		//TODO: This function will call sendComplete and there currently isn't a parent token, this will cause this test to fail
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete function correctly operates when the result contains an AssumptionViolationException")]
		public function handleChildExecuteCompleteAssumptionErrorTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var assumptionViolatedException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, assumptionViolatedException);
//			
//			assignmentSequencer.handleChildExecuteComplete(childResult);
		}
		
		//TODO: This function will call sendComplete and there currently isn't a parent token, this will cause this test to fail
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete function correctly operates when the result contains an error")]
		public function handleChildExecuteCompleteSingleErrorTest():void {
//			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var error:Error = new Error();
//			var childResult:ChildResult = new ChildResult(asyncTestTokenMock, error);
//			
//			assignmentSequencer.handleChildExecuteComplete(childResult);
		}
		
		//TODO: This function will call sendComplete and there currently isn't a parent token, this will cause this test to fail
		[Ignore]
		[Test(description="Ensure that the handleChildExecuteComplete function correctly operates when the multiple results with errors are passed")]
		public function handleChildExecuteCompleteMultipleErrorTest():void {
//			//This tests is to ensure that the overriden send complete method genertes a mulitple failure exception
//			//Create the first result
//			var asyncTestTokenMockOne:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var errorOne:Error = new Error();
//			var childResultOne:ChildResult = new ChildResult(asyncTestTokenMockOne, errorOne);
//			
//			//Create the second result
//			var asyncTestTokenMockTwo:AsyncTestTokenMock = new AsyncTestTokenMock();
//			var errorTwo:Error = new Error();
//			var childResultTwo:ChildResult = new ChildResult(asyncTestTokenMockTwo, errorTwo);
//			
//			assignmentSequencer.handleChildExecuteComplete(childResultOne);
//			assignmentSequencer.handleChildExecuteComplete(childResultTwo);
		}
	}
}