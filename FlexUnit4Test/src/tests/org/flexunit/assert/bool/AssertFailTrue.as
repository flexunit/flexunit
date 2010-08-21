package tests.org.flexunit.assert.bool {
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	
	public class AssertFailTrue {

		[Test]
		public function shouldPass():void {
			Assert.failTrue( "Fail true fail", false );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFail():void {
			Assert.failTrue( "Blah", true );
		}

		[Test]
		public function shouldFailWithCustomMessage():void {
			var message:String;
			var failed:Boolean = false;
			
			try {
				Assert.failTrue( "Yo Yo Yo", true );
				// if we get an error with the right message we pass
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}

			if ( !failed ) {
				Assert.fail( "Fail true fail didn't fail" );
			}
			
			Assert.assertEquals( "Yo Yo Yo" + " - expected false but was true", message );
		}
		
	}
}