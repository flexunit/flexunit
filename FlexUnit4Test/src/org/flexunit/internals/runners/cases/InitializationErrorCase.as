package org.flexunit.internals.runners.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.InitializationError;

	public class InitializationErrorCase
	{
		//TODO: Ensure that these tests and test case are being implemented correctly
		
		[Test(description="Ensure that the error array is successfully retrived")]
		public function getCausesErrorArrayTest():void {
			var errorArray:Array = new Array(new Error(), new Error(), new Error());
			var initilizationError:InitializationError = new InitializationError(errorArray);
			
			Assert.assertEquals(errorArray, initilizationError.getCauses());
		}
		
		[Test(description="Ensure that an error array contains an error that has the type based on the provided string")]
		public function getCausesStringTest():void {
			var testMessage:String = "testMessage";
			var initilizationError:InitializationError = new InitializationError(testMessage);
			
			var error:Error = initilizationError.getCauses()[0] as Error;
			Assert.assertEquals(testMessage, error.message);
		}
		
		[Test(description="Ensure that the error array contains the error")]
		public function getCausesErrorTest():void {
			var error:Error = new Error();
			var initilizationError:InitializationError = new InitializationError(error);
			
			Assert.assertEquals(error, initilizationError.getCauses()[0] as Error);
		}
	}
}