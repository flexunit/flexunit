package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.StackAndFrameManagement;
	import org.flexunit.internals.runners.statements.mock.AsyncStatementMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class StackAndFrameManagementCase
	{
		protected var stackAndFrameManagement:StackAndFrameManagement;
		protected var asyncStatementMock:AsyncStatementMock;
		
		[Before(description="Create an instance of the StackAndFrameManagement class")]
		public function createStackAndFrameManagement():void {
			asyncStatementMock = new AsyncStatementMock();
			stackAndFrameManagement = new StackAndFrameManagement(asyncStatementMock);
		}
		
		[After(description="Remove the reference to the StackAndFrameManagement class")]
		public function destroyStackAndFrameManagement():void {
			stackAndFrameManagement = null;
			asyncStatementMock = null;
		}
		
		//TODO: Is there a way that the timing can be altered so that it is known with certainity what branch of the function is being tested?
		[Ignore("Is there a way that the timing can be altered so that it is known with certainity what branch of the function")]
		[Test(description="Ensure that the evaluate correctly calls evalute function of the statement passed in the constructor")]
		public function evaluateTest():void {
			var previousToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			
			asyncStatementMock.mock.method("evaluate").withArgs(AsyncTestToken).once;
			
			stackAndFrameManagement.evaluate(previousToken);
			
			asyncStatementMock.mock.verify();
		}
		
		//TODO: Access is needed to a parent token
		[Ignore]
		[Test(description="Ensure that the sendResult of the parentToken is called with the error provided by the child result")]
		public function handleNextExecuteCompleteTest():void {
			var asyncTestToeknMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var error:Error = new Error("testError");
			var childResult:ChildResult = new ChildResult(asyncTestToeknMock, error);
			
			stackAndFrameManagement.handleNextExecuteComplete(childResult);
		}
		
		[Test(description="Ensure that the toString method returns the correct string")]
		public function toStringTest():void {
			Assert.assertEquals( "Stack Management Base", stackAndFrameManagement.toString() );
		}
	}
}