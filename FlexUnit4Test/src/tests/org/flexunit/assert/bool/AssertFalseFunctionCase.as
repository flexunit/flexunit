package tests.org.flexunit.assert.bool
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertFalse;

	public class AssertFalseFunctionCase
	{
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false is provided")]
		public function shouldPassWhenFalse():void {
			assertFalse( false );
		}
		
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false and a message are provided")]
		public function shouldPassWhenFalseWithCustomMessage():void {
			assertFalse( "Assert false fail", false );
		}
		
		[Test(description="Ensure that the assertFalse alias function fails when a value of true is provided")]
		public function shouldFailWhenTrue():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				assertFalse( true )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}
			if ( !failed ) {
				Assert.fail( "Assert false didn't fail" );
			}
			
			Assert.assertEquals( "expected false but was true", message );
		}
		
		[Test(description="Ensure that the assertFalse alias function fails when a value of true is provided and the proper message is displayed")]
		public function shouldFailWhenTrueWithCustomMessage():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				assertFalse( "Yo Yo Yo", true )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}

			if ( !failed ) {
				Assert.fail( "Assert false didn't fail" );
			}

			Assert.assertEquals( "Yo Yo Yo" + " - expected false but was true", message );
		}
	}
}