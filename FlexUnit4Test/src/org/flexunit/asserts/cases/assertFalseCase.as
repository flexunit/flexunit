package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertFalse;

	public class assertFalseCase
	{
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false is provided")]
		public function testAssertFalse():void {
			assertFalse( false );
		}
		
		[Test(description="Ensure that the assertFalse alias function correctly works when a value of false and a message are provided")]
		public function testAssertFalseWithMessage():void {
			assertFalse( "Assert false fail", false );
		}
		
		[Test(description="Ensure that the assertFalse alias function fails when a value of true is provided")]
		public function testAssertFalseFails():void {
			var failed:Boolean = false;
			
			try {
				assertFalse( true )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( "expected false but was true", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert false didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertFalse alias function fails when a value of true is provided and the proper message is displayed")]
		public function testAssertFalseWithMessageFails():void {
			var message:String = "Assert false fail";
			var failed:Boolean = false;
			
			try {
				assertFalse( message, true )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( message + " - expected false but was true", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert false didn't fail" );
			}
		}
	}
}