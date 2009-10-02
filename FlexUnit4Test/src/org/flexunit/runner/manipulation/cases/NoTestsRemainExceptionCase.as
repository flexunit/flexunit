package org.flexunit.runner.manipulation.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.manipulation.NoTestsRemainException;

	public class NoTestsRemainExceptionCase
	{
		//TODO: Ensure that this test case and the tests are correctly implemented
		
		[Test(description="Ensure the NoTestsReaminException class is correctly constructed with no parameters passed")]
		public function noParamAssertionErrorConstructorTest():void {
			var noTestsRemainException:NoTestsRemainException = new NoTestsRemainException();
			
			try {
				throw noTestsRemainException;
			} 
			catch(e:NoTestsRemainException) {
				Assert.assertEquals("", e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}
		
		[Test(description="Ensure the NoTestsReaminException class is correctly constructed with a message parameter passed")]
		public function messageParamAssertionErrorConstructorTest():void {
			var testMessage:String = "testMessage";
			var noTestsRemainException:NoTestsRemainException = new NoTestsRemainException(testMessage);
			
			try {
				throw noTestsRemainException;
			} 
			catch(e:NoTestsRemainException) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(0, e.errorID);
			}
		}
		
		[Test(description="Ensure the NoTestsReaminException class is correctly constructed with a message and id parameter passed")]
		public function allParamAssertionErrorConstructorTest():void {
			var testMessage:String = "testMessage";
			var id:int = 216;			
			var noTestsRemainException:NoTestsRemainException = new NoTestsRemainException(testMessage, id);
			
			try {
				throw noTestsRemainException;
			} 
			catch(e:NoTestsRemainException) {
				Assert.assertEquals(testMessage, e.message);
				Assert.assertEquals(id, e.errorID);
			}
		}
	}
}