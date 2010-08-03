package tests.org.flexunit.assert.nullHandling {
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;

	public class AssertFailNotNull {
		[Test(description="Ensure that the failNotNull function works correctly when a null value is provided")]
		public function shouldPassNull():void {
			Assert.failNotNull( "Fail not null fail", null );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailNotNull():void {
			Assert.failNotNull( "Fail not null fail", new Object() );
		}

		[Test(description="Ensure that the failNotNull function fails when a non-null value is provided")]
		public function shouldFailNotNullWithCustomMessage():void {
			var o:Object = new Object();
			var message:String;
			
			try {
				Assert.failNotNull( "Yo Yo Yo", o );
			} catch(error:AssertionFailedError) {
				Assert.assertEquals( "Yo Yo Yo" + " - object was not null: [object Object]", error.message );
			}
		}
	}
}