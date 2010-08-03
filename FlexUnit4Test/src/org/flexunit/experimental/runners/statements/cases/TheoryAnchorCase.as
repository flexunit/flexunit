package org.flexunit.experimental.runners.statements.cases
{
	import mockolate.mock;
	import mockolate.strict;
	import mockolate.verify;
	import mockolate.runner.MockolateRule;
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.experimental.theories.internals.ParameterizedAssertionError;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.runners.model.TestClass;

	use namespace classInternal;
	
	public class TheoryAnchorCase
	{	
		
		//------------------------------
		// MOCKOLATE
		//------------------------------
		
		[Rule]
		public var mockolateRule:MockolateRule = new MockolateRule();
		
		[Mock(type="strict")]
		public var frameworkMethodMock:FrameworkMethod;
		
		[Mock(type="strict")]
		public var testClassMock:TestClass
		
		protected var theoryAnchor:TheoryAnchor;
		
		
		[Before(description="Create an instance of the TheoryAnchor class")]
		public function createTheoryAnchor():void {
			theoryAnchor = new TheoryAnchor(frameworkMethodMock, testClassMock);

		}
		
		[After(description="Destroy the reference to the instance of the TheoryAnchor class")]
		public function destroyTheoryAnchor():void {
			theoryAnchor = null;
			frameworkMethodMock = null;
			testClassMock = null;
		}
		
		//TODO: How can it be determined that this function has correctly executed
		//TODO:: Getting a mock expectation error for the frameworkMethodMock that is set. Need to set expectations properly.
		[Ignore]
		[Test(description="Ensure that the evaluate function correctly operates")]
		public function evaluateTest():void {
			//var parentToken:AsyncTestTokenMock = new AsyncTestTokenMock();
			//frameworkMethodMock.mock.method("apply").returns(["test"]).once;
			//theoryAnchor.evaluate(parentToken);
			//frameworkMethodMock.mock.verify();
		}
		
		//TODO: How can it be determined that this function has correctly executed
		[Ignore]
		[Test(description="Ensure that the handleAssumptionViolation function correctly adds an AssumptionViolatedException to the invalidParameters array")]
		public function handleAssumptionViolationTest():void {
			//var assumptionViolationException:AssumptionViolatedException = new AssumptionViolatedException(new Object());
			
			//theoryAnchor.handleAssumptionViolation(assumptionViolationException);
		}
		
		[Test(description="Ensure that the reportParameterizedError function returns the passed error if no additional parameters are passed")]
		public function reportParameterizedErrorNoParamsTest():void {
			var error:Error = new Error();
			
			Assert.assertEquals( error, theoryAnchor.reportParameterizedError(error) );
		}
		
		[Test(description="Ensure that the reportParameterizedError function returns a ParameterizedAssertionError if additional parameters are passed")]
		public function reportParameterizedErrorParamsTest():void {
			var error:Error = new Error();
			mock(frameworkMethodMock).getter("name").returns("test").once();
			Assert.assertTrue( theoryAnchor.reportParameterizedError(error, "valueOne", "valueTwo") is ParameterizedAssertionError );
			verify(frameworkMethodMock);
		}
		
		[Test(description="Ensure that the nullsOk function returns a value of true")]
		public function nullsOkTest():void {
			Assert.assertTrue( theoryAnchor.nullsOk() );
		}
		
		//TODO: How can it be determined that this function has correctly executed
		[Ignore]
		[Test(description="Ensure that the handleDataPointSuccess function updates the number of successes")]
		public function handleDataPointSuccessTest():void {
			
		}
	}
}