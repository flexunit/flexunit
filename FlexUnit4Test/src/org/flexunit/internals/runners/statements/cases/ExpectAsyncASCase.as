package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.ExpectAsync;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;

	public class ExpectAsyncASCase
	{
		//TODO: There are still tests that need to be created in this test case
		//The objectUnderTest Object parameter in the constructor changes behavior based on its type, can a before / after still be used?
		
		[Test(description="Ensure that the bodyExecuting property returns a value of false when methodBodyExecutiong is false")]
		public function bodyExecutingFalseTest():void {
			
		}
		
		[Test(description="Ensure that the bodyExecuting property returns a value of true when methodBodyExecutiong is true")]
		public function bodyExecutingTrueTest():void {
			
		}
		
		[Test(description="Ensure that the hasPendingAsync property returns a value of false when the pendingAsyncCalls array is empty")]
		public function hasPendingAsyncFalseTest():void {
			
		}
		
		[Test(description="Ensure that the hasPendingAsync property returns a value of true when the pendingAsyncCalls array is not empty")]
		public function hasPendingAsyncTrueTest():void {
			
		}
		
		[Test(description="Ensure that the hasAsync function returns a value of true if the FrameworkMethod class has an async test")]
		public function hasAsyncFalseTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var type:String = "test";
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs(type, "async").once.returns("true");
			
			Assert.assertTrue( ExpectAsync.hasAsync(frameworkMethodMock, type) );
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that the hasAsync function returns a value of false if the FrameworkMethod class does not have an async test")]
		public function hasAsyncTrueTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var type:String = "value";
			frameworkMethodMock.mock.method("getSpecificMetaDataArg").withArgs(type, "async").once.returns("otherValue");
			
			Assert.assertFalse( ExpectAsync.hasAsync(frameworkMethodMock, type) );
			
			frameworkMethodMock.mock.verify();
		}
	}
}