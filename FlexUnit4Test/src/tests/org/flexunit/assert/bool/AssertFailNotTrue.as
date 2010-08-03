package tests.org.flexunit.assert.bool {
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	
	public class AssertFailNotTrue {
		[Test]
		public function shouldPassTrue():void {
			Assert.failNotTrue( "Fail not true fail", true );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailFalse():void {
			Assert.failNotTrue( "Fail not true fail", false );
		}

		[Test(description="Ensure that the failNotTrue function fails when a value of false is provided")]
		public function shouldFailWithCustomMessage():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				Assert.failNotTrue( "Yo Yo Yo", false );
			} catch ( error:AssertionFailedError ) {
				failed = true;
				message = error.message;
			}
			
			if ( !failed ) {
				Assert.fail( "Fail not true fail didn't fail" );
			}
			
			Assert.assertEquals( "Yo Yo Yo - expected true but was false", message );
		}
		
	}
}