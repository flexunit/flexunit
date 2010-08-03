package tests.org.flexunit.assert.equals
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertStrictlyEquals;

	public class AssertStrictlyEqualsFunctionCase
	{
		[Test(description="Ensure that the assertStrictlyEquals function correctly determines if two values are strictly equal")]
		public function shouldPassWhenSameObject():void {
			var o:Object = new Object();
			assertStrictlyEquals( o, o );
		}
		
		[Test(description="Ensure that the assertStrictlyEquals function correctly determines if two values are strictly equal when a message is provided")]
		public function shouldPassWhenSameObjectWithCustomMessage():void {
			var o:Object = new Object();
			assertStrictlyEquals( "Assert strictly equals fail", o, o );
		}
		
		[Test(description="Ensure that the assertStrictlyEquals function fails when two items are not strictly equal")]
		public function shouldFailToConvertBetweenStringAndNumber():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				assertStrictlyEquals( 5, "5" );
			} catch (error:AssertionFailedError) {
				failed = true;
				message = error.message;				
			}
			
			if ( !failed ) {
				Assert.fail( "Assert strictly equals didn't fail" );
			}
			
			Assert.assertEquals( "expected:<5> but was:<5>", message );
		}

/*		
		I need to investigate why flash player sees these two as strictly equal
		[Test(description="Ensure that the assertStrictlyEquals function fails when two items are not strictly equal")]
		public function shouldFailToConvertBetweenIntAndNumber():void {
			var failed:Boolean = false;
			var message:String;
			
			try {
				assertStrictlyEquals( int( 5 ), Number( 5.00 ) );
			} catch (error:AssertionFailedError) {
				failed = true;
				message = error.message;				
			}
			
			if ( !failed ) {
				Assert.fail( "Assert strictly equals didn't fail" );
			}
			
			Assert.assertEquals( "expected:<5> but was:<5>", message );
		}*/
		
		[Test(description="Ensure that the assertStrictlyEquals function fails when two items are not strictly euqal and the proper passed message is displayed")]
		public function shouldFailWithCustomMessage():void {
			var message:String;
			var failed:Boolean = false;
			
			try {
				assertStrictlyEquals( "Yo Yo Yo", 5, "5" );
				// if we get an error with the right message we pass
			} catch (error:AssertionFailedError) {
				failed = true;
				message = error.message;
				
			}
			if ( !failed ) {
				Assert.fail( "Assert strictly equals didn't fail" );
			}
			
			Assert.assertEquals( "Yo Yo Yo" + " - expected:<5> but was:<5>", message );
		}
	}
}