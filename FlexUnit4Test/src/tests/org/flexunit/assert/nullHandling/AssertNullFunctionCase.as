package tests.org.flexunit.assert.nullHandling
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertNull;

	public class AssertNullFunctionCase
	{
		[Test(description="Ensure that the assertNull function correctly works when a value of null is provided")]
		public function shouldPassWhenNull():void {
			assertNull( null );
		}
		
		[Test(description="Ensure that the assertNull function correctly works when a value of null and a message are provided")]
		public function shouldPassWhenNullWithCustomMessage():void {
			assertNull( "Assert null fail", null );
		}
		
		[Test(description="Ensure that the assertNull function fails when a non-null value is provided")]
		public function shouldFailWhenNotNull():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				assertNull( new Object() )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
				
			}
			
			if ( !failed ) {
				Assert.fail( "Assert null didn't fail" );
			}
			
			Assert.assertEquals( "object was not null: [object Object]", message );
		}
		
		[Test(description="Ensure that the assertNull functions fails when a non-null value is provided an the proper message is displayed")]
		public function shouldFailWhenNotNullWithCustomMessage():void {
			var failed:Boolean = false;
			var message:String;

			try {
				assertNull( "Yo Yo Yo", new Object() )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}
			
			if ( !failed ) {
				Assert.fail( "Assert null didn't fail" );
			}
			
			Assert.assertEquals( "Yo Yo Yo" + " - object was not null: [object Object]", message );
		}
	}
}