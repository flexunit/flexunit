package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;

	public class assertNotNullCase
	{
		[Test(description="Ensure the the assertNotNull function correctly works when a non-null value is provided")]
		public function testAssertNotNull():void {
			var o:Object = new Object();
			Assert.assertNotNull( o );
		}
		
		[Test(description="Ensure that the assertNotNull function correctly works when a non-null value and a message are provided")]
		public function testAssertNotNullWithMessage():void {
			var o:Object = new Object();
			Assert.assertNotNull( "Assert not null fail", o );
		}
		
		[Test(description="Ensure that the assertNotNull function fails when a null value is provided")]
		public function testAssertNotNullFails():void {
			var failed:Boolean = false;
			try {
				Assert.assertNotNull( null )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( "object was null: null", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert not null didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertNotNull function fails when a null value is provided and the proper message is displayed")]
		public function testAssertNotNullWithMessageFails():void {
			var failed:Boolean = false;
			var message:String = "Assert not null fail";
			try {
				Assert.assertNotNull( message, null )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( message + " - object was null: null", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert not null didn't fail" );
			}
		}
	}
}