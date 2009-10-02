package org.flexunit.internals.requests.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.requests.ClassRequest;
	import org.flexunit.runner.IRunner;
	
	public class ClassRequestCase
	{
		//TODO: Ensure that this test and this test case are being implemented correctly
		
		protected var classRequest:ClassRequest;
		
		[Before(description="Create an instance of ClassRequest")]
		public function createClassRequest():void {
			classRequest = new ClassRequest( Object ); 
		}
		
		[After(description="Remove the reference to the instance of the ClassRequest")]
		public function destroyClassRequest():void {
			classRequest = null;
		}
		
		//TODO: What steps need to be taken in order to determine if the correct iRunner was obtained?
		[Test(description="Ensure the IRunner is successfully obtained")]
		public function getIRunnerTest():void {
			Assert.assertTrue( classRequest.iRunner is IRunner);
		}
	}
}