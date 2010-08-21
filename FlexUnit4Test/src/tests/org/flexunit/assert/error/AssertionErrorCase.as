package tests.org.flexunit.assert.error
{
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;

	public class AssertionErrorCase
	{
		//TODO: Ensure that this test case and the tests are correctly implemented
		
		[Test(description="Ensure the AssertionError class is correctly constructed with no parameters passed")]
		public function shouldPassWithDefaultValues():void {
			var assertionError:AssertionError = new AssertionError();
			
			try {
				throw assertionError;
			} 
			catch(e:AssertionError) {
				Assert.assertEquals("", e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}

		[Test(description="Ensure the AssertionError class is correctly constructed with a message parameter passed")]
		public function shouldPassWithCustomMessage():void {
			var testMessage:String = "testMessage";
			var assertionError:AssertionError = new AssertionError(testMessage);
			
			try {
				throw assertionError;
			} 
			catch(e:AssertionError) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}
		
		[Test(description="Ensure the AssertionError class is correctly constructed with a message and id parameter passed")]
		public function shouldPassWithCustomErrorID():void {
			var testMessage:String = "testMessage";
			var id:int = 42;			
			var assertionError:AssertionError = new AssertionError(testMessage, id);
			
			try {
				throw assertionError;
			} 
			catch(e:AssertionError) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(id, e.errorID);
			}
		}
	}
}