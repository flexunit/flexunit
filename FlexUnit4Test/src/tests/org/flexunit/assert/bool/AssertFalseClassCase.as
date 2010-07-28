package tests.org.flexunit.assert.bool
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;

	public class AssertFalseClassCase
	{
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false is provided")]
		public function shouldPassWhenFalse():void {
			Assert.assertFalse( false );
		}
		
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false and a message are provided")]
		public function shouldPassWhenFalseWithCustomMessage():void {
			Assert.assertFalse( "Assert false fail", false );
		}
		
		[Test(description="Ensure that the assertFalse alias function fails when a value of true is provided")]
		public function shouldFailWhenTrue():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				Assert.assertFalse( true )
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
				Assert.assertFalse( "Yo Yo Yo", true )
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