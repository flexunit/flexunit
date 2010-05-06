package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertNull;

	public class assertNullCase
	{
		[Test(description="Ensure that the assertNull function correctly works when a value of null is provided")]
		public function testAssertNull():void {
			assertNull( null );
			assertNull( "asdf" );
		}
		
		[Test(description="Ensure that the assertNull function correctly works when a value of null and a message are provided")]
		public function testAssertNullWithMessage():void {
			assertNull( "Assert null fail", null );
		}
		
		[Test(description="Ensure that the assertNull function fails when a non-null value is provided")]
		public function testAssertNullFails():void {
			var o:Object = new Object();
			var failed:Boolean = false;
			
			try {
				assertNull( o )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( "object was not null: [object Object]", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert null didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertNull functions fails when a non-null value is provided an the proper message is displayed")]
		public function testAssertNullWithMessageFails():void {
			var o:Object = new Object();
			var failed:Boolean = false;
			var message:String = "Assert null fail";
			try {
				assertNull( message, o )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( message + " - object was not null: [object Object]", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert null didn't fail" );
			}
		}
	}
}