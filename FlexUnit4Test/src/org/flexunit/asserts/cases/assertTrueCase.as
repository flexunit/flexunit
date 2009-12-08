package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertTrue;
	
	public class assertTrueCase
	{
		[Test(description="Ensure that the assertTrue fucntion correctly works when a true value is provided")]
		public function testAssertTrue():void {
			assertTrue( true );
		}
		
		[Test(description="Ensure that the assertTrue function correctly works when a true value and a message are provided")]
		public function testAssertTrueWithMessage():void {
			assertTrue( "Assert true fail", true );
		}
		
		[Test(description="Ensure that the assertTrue function fails when a false value is provided")]
		public function testAssertTrueFails():void {
			var failed:Boolean = false;
			
			try {
				assertTrue( false )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( "expected true but was false", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert true didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertTrue functions fails when a false value is provided and the proper passed message is displayed")]
		public function testAssertTrueWithMessageFails():void {
			var message:String = "Assert true fail";
			var failed:Boolean = false;
			
			try {
				assertTrue( message, false )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( message + " - expected true but was false", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert true didn't fail" );
			}
		}
	}
}