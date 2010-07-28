package tests.org.flexunit.assert.bool
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	
	public class AssertTrueClassCase
	{
		[Test(description="Ensure that the assertTrue function correctly works when a true value is provided")]
		public function shouldPassWhenTrue():void {
			Assert.assertTrue( true );
		}
		
		[Test(description="Ensure that the assertTrue function correctly works when a true value and a message are provided")]
		public function shouldPassWhenTrueWithCustomMessage():void {
			Assert.assertTrue( "Assert true fail", true );
		}
		
		[Test(description="Ensure that the assertTrue function fails when a false value is provided")]
		public function shouldFailWhenFalse():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				Assert.assertTrue( false )
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}

			if ( !failed ) {
				Assert.fail( "Assert true didn't fail" );
			}

			Assert.assertEquals( "expected true but was false", message );
		}
		
		[Test(description="Ensure that the assertTrue functions fails when a false value is provided and the proper passed message is displayed")]
		public function shouldFailWhenFalseWithCustomMessage():void {
			var message:String;
			var failed:Boolean = false;
			
			try {
				Assert.assertTrue( "Yo Yo Yo", false )
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;				
			}

			if ( !failed ) {
				Assert.fail( "Assert true didn't fail" );
			}
			
			Assert.assertEquals( "Yo Yo Yo" + " - expected true but was false", message );
		}
	}
}