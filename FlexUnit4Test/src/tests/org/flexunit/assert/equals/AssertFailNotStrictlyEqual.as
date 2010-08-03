package tests.org.flexunit.assert.equals {
	import org.flexunit.Assert;

	public class AssertFailNotStrictlyEqual {
		[Test(description="Ensure that the failNotEquals function correctly determines if two non-strictly equal values are equal")]
		public function shouldPassAsSameObject():void {
			var o:Object = new Object();
			Assert.failNotEquals( "Failure", o, o );
		}
		
		[Test(exptects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithConversion():void {
			Assert.failNotEquals( "Failure", "5", 5 );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFail():void {
			Assert.failNotEquals( "Failure", 2, 4 );
		}
		
		[Test]
		public function shouldFailWithProperMessage():void {
			var fail:Boolean = false;
			var message:String;
			
			try {
				Assert.failNotEquals( "Yo Yo Yo", 2, 4 );
			}
			catch ( error:Error ) {
				fail = true;
				message = error.message;
			}
			
			Assert.assertTrue( "Did not fail as expected", fail );
			Assert.assertEquals( "Yo Yo Yo" + " - expected:<2> but was:<4>", message );
		}

	}
}