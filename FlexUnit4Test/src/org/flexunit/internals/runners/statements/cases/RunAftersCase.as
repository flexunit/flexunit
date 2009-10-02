package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.RunAfters;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class RunAftersCase
	{
		//TODO: Ensure that these tests and this test case are properly designed
		
		protected var runAfters:RunAfters;
		protected var frameworkMethodMock:FrameworkMethodMock;
		protected var afters:Array;
		protected var target:Object;
		
		[Before(description="Create an instance of the RunAfters class")]
		public function createRunAfters():void {
			frameworkMethodMock = new FrameworkMethodMock();
			afters = [frameworkMethodMock];
			target = new Object();
			runAfters = new RunAfters(afters, target);
		}
		
		[After(description="Remove the reference to the instance of the RunAfters class")]
		public function destroyRunAfters():void {
			frameworkMethodMock = null;
			runAfters = null;
			afters = null;
			target = null;
		}
		
		//TODO: It currently is hard to determine which IAsyncStatement is being returned with the withPotentialAsync function
		[Test(description="Ensure that the overridden withPotentialAsync function returns the correct instance of an IAsyncStatement when the metadata does not have an 'After'")]
		public function withPotentialAsyncNoAfterTest():void {
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("After", "async").once.returns("notTrue");
			
			runAfters.handleChildExecuteComplete(new ChildResult(new AsyncTestTokenMock()));
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the overridden withPotentialAsync function returns the correct instance of an IAsyncStatement when the metadata has an 'After'")]
		public function withPotentialAsyncHasAfterTest():void {
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("After", "async").once.returns("true");
			
			runAfters.handleChildExecuteComplete(new ChildResult(new AsyncTestTokenMock()));
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the toString function returns the correct string value")]
		public function toStringTest():void {
			Assert.assertEquals( "RunAfters", runAfters.toString() );
		}
	}
}