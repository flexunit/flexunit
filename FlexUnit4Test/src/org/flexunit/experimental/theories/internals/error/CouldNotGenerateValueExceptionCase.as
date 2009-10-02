package org.flexunit.experimental.theories.internals.error
{
	import org.flexunit.Assert;

	public class CouldNotGenerateValueExceptionCase
	{
		//TODO: Ensure that the tests and test case have been implemented correctly
		
		[Test(description="Ensure the CouldNotGenerateValueException class is correctly constructed with no parameters passed")]
		public function cngveConstructorNoParamsTest():void {
			var couldNotGenerateValueException:CouldNotGenerateValueException = new CouldNotGenerateValueException();
			
			try {
				throw couldNotGenerateValueException;
			} 
			catch(e:CouldNotGenerateValueException) {
				Assert.assertEquals("", e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}
		
		[Test(description="Ensure the CouldNotGenerateValueException class is correctly constructed with a message parameter passed")]
		public function cngveConstructorMessageParamTest():void {
			var testMessage:String = "testMessage";
			var couldNotGenerateValueException:CouldNotGenerateValueException = new CouldNotGenerateValueException(testMessage);
			
			try {
				throw couldNotGenerateValueException;
			} 
			catch(e:CouldNotGenerateValueException) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}
		
		[Test(description="Ensure the CouldNotGenerateValueException class is correctly constructed with a message and id parameter passed")]
		public function cngveConstructorMessageAndIdParamsTest():void {
			var testMessage:String = "testMessage";
			var id:int = 512;			
			var couldNotGenerateValueException:CouldNotGenerateValueException = new CouldNotGenerateValueException(testMessage, id);
			
			try {
				throw couldNotGenerateValueException;
			} 
			catch(e:CouldNotGenerateValueException) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(id, e.errorID);
			}
		}
	}
}