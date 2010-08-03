package tests.org.flexunit.async {
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.AssertionError;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;

	public class AsyncLocatorCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var handlingStatement:IAsyncHandlingStatement;
		
		[Test(description="Ensure an IAsyncHandlingStatement is successfully registered to a TestCase")]
		public function shouldRegisterAndFindHandler():void {
			var testCase:Object = new Object();
			
			AsyncLocator.registerStatementForTest( handlingStatement, testCase );
			assertStrictlyEquals( handlingStatement, AsyncLocator.getCallableForTest( testCase ) );
		}
		
		[Test(expected="org.flexunit.AssertionError",
			description="Ensure an AssertionError is thrown when no IAsyncHandlingStatement is returned for a given TestCase")]
		public function shouldFailWhenAskedForNonExistantTest():void {
			AsyncLocator.getCallableForTest( new Object() );
		}
		
		[Test(expected="org.flexunit.AssertionError",description="Ensure an IAsyncHandlingStatement is successfully removed for a given TestCase")]
		public function shouldThrowErrorRetrievingStatement():void {
			var testCase:Object = new Object();
			
			AsyncLocator.registerStatementForTest( handlingStatement, testCase );
			AsyncLocator.cleanUpCallableForTest( testCase );

			//should error out
			AsyncLocator.getCallableForTest( testCase );
		}
	}
}