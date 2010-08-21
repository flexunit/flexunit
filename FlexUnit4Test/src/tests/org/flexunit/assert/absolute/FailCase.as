package tests.org.flexunit.assert.absolute {
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.flexunit.asserts.fail;
	
	public class FailCase {
		[Test(description="Ensure that the function correctly throws an AssertionFailedError and sends the proper message")]
		public function shouldFailFunctionWithCustomMessage():void {
			var message:String;;
			var failed:Boolean = false;
			
			try {
				fail( "Yo Yo Yo" );
			} catch(error:AssertionFailedError) {
				failed = true;
				message = error.message;
			}

			if(!failed) {
				Assert.fail("The fail function has failed");
			}
			
			Assert.assertEquals( "Yo Yo Yo", message );			
		}
		
		[Test(description="Ensure that the function correctly throws an AssertionFailedError and sends the proper message")]
		public function shouldFailStaticClassWithCustomMessage():void {
			var message:String;;
			var failed:Boolean = false;
			
			try {
				Assert.fail( "Yo Yo Yo" );
			} catch(error:AssertionFailedError) {
				failed = true;
				message = error.message;
			}
			
			if(!failed) {
				//better throw this instead of use the fail function :)
				throw new AssertionError( "The Assert.fail function has failed" );
				//Assert.fail("The fail function has failed");
			}
			
			Assert.assertEquals( "Yo Yo Yo", message );			
		}
	}
}