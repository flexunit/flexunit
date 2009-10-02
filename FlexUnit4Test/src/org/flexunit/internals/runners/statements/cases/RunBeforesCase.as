package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.RunBefores;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class RunBeforesCase
	{
		//TODO: Ensure that these tests and this test case are properly designed
		
		protected var runBefores:RunBefores;
		protected var frameworkMethodMock:FrameworkMethodMock;
		protected var befores:Array;
		protected var target:Object;
		
		[Before(description="Create an instance of the RunBefores class")]
		public function createRunBefores():void {
			frameworkMethodMock = new FrameworkMethodMock();
			befores = [frameworkMethodMock];
			target = new Object();
			runBefores = new RunBefores(befores, target);
		}
		
		[After(description="Remove the reference to the instance of the RunBefores class")]
		public function destroyRunBefores():void {
			runBefores = null;
			frameworkMethodMock = null;
			befores = null;
			target = null;
		}
		
		//TODO: It currently is hard to determine which IAsyncStatement is being returned with the withPotentialAsync function
		[Test(description="Ensure that the overridden withPotentialAsync function returns the correct instance of an IAsyncStatement when the metadata does not have a 'Before'")]
		public function withPotentialAsyncNoBeforeTest():void {
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Before", "async").once.returns("notTrue");
			
			runBefores.handleChildExecuteComplete(new ChildResult(new AsyncTestTokenMock()));
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the overridden withPotentialAsync function returns the correct instance of an IAsyncStatement when the metadata has a 'Before'")]
		public function withPotentialAsyncHasBeforeTest():void {
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs("Before", "async").once.returns("true");
			
			runBefores.handleChildExecuteComplete(new ChildResult(new AsyncTestTokenMock()));
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the toString function returns the correct string value")]
		public function toStringTest():void {
			Assert.assertEquals( "RunBefores", runBefores.toString() );
		}
	}
}