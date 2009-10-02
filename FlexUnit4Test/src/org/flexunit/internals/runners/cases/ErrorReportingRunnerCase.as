package org.flexunit.internals.runners.cases
{
	import flash.utils.getQualifiedClassName;
	
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.ErrorReportingRunner;
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.mocks.RunNotifierMock;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class ErrorReportingRunnerCase
	{	
		//TODO: Ensure that these tests are correctly written and that this test case is properly implemented
		
		[Test(description="Ensure that getCauses function adds a single error to the array if a single error is passed to the constructor")]
		public function getCausesSingleErrorTest():void {
			var testClass:Class = Object;
			var cause:Error = new Error();
			var errorReportingRunner:ErrorReportingRunner = new ErrorReportingRunner(testClass, cause);
			
			//Determine if a single error was added by calling get description and seeing how many child description's are added
			var description:IDescription = errorReportingRunner.description;
			var children:Array = description.children;
			
			Assert.assertEquals( 1, children.length );
		}
		
		[Test(description="Ensure that getCauses function adds a multiple errors to the array if an InitializationError error is passed to the constructor")]
		public function getCausesInitializationErrorTest():void {
			var testClass:Class = Object;
			var errors:Array = [new Error(), new Error()];
			var cause:Error = new InitializationError(errors);
			var errorReportingRunner:ErrorReportingRunner = new ErrorReportingRunner(testClass, cause);
			
			//Determine if a single error was added by calling get description and seeing how many child description's are added
			var description:IDescription = errorReportingRunner.description;
			var children:Array = description.children;
			
			Assert.assertEquals( 2, children.length );
		}
		
		[Test(description="Ensure that description property returns a description with children equal to the number of errors in the error array")]
		public function getDescriptionTest():void {
			var testClass:Class = Object;
			var cause:Error = new Error();
			var errorReportingRunner:ErrorReportingRunner = new ErrorReportingRunner(testClass, cause);
			
			//Determine if a single error was added by calling get description and seeing how many child description's are added
			var description:IDescription = errorReportingRunner.description;
			var children:Array = description.children;
			
			Assert.assertTrue( description is IDescription );
			Assert.assertEquals( getQualifiedClassName(Object), description.displayName );
			Assert.assertEquals( 1, children.length );
		}
		
		[Test(description="Ensure that the run function correctly operates with the passed RunNotifier and AsyncTestToekn")]
		public function runTest():void {
			var testClass:Class = Object;
			var errors:Array = [new Error(), new Error()];
			var cause:Error = new InitializationError(errors);
			var errorReportingRunner:ErrorReportingRunner = new ErrorReportingRunner(testClass, cause);
			var runNotifiermock:RunNotifierMock = new RunNotifierMock();
			var asyncTestTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			
			//Set expectations
			runNotifiermock.mock.method("fireTestStarted").withArgs(IDescription).twice;
			runNotifiermock.mock.method("fireTestFailure").withArgs(Failure).once;
			runNotifiermock.mock.method("fireTestFinished").withArgs(IDescription).twice;
			asyncTestTokenMock.mock.method("sendResult").withArgs(null).once;
			
			errorReportingRunner.run(runNotifiermock, asyncTestTokenMock);
			
			//Verify that expectations were met
			runNotifiermock.mock.verify();
			asyncTestTokenMock.mock.verify();
		}
	}
}