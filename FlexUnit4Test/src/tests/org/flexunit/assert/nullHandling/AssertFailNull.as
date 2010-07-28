package tests.org.flexunit.assert.nullHandling {
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;

	public class AssertFailNull {
		[Test(description="Ensure that the failNull function works correctly when a non-null value is provided")]
		public function shouldPassNotNull():void {
			Assert.failNull( "Fail null fail", new Object() );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailIsNull():void {
			Assert.failNull( "Blah", null );
		}

		[Test(description="Ensure that the failNull function fails when a null value is provided")]
		public function shouldFailIsNullWithCustomMessage():void {
			var failed:Boolean = false;
			try {
				Assert.failNull( "Yo Yo Yo", null );
			} catch ( error:AssertionFailedError ) {
				Assert.assertEquals( "Yo Yo Yo" + " - object was null: null", error.message );
			}
		}

	}
}