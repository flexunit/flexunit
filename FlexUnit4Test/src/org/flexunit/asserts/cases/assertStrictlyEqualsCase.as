package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertStrictlyEquals;

	public class assertStrictlyEqualsCase
	{
		[Test(description="Ensure that the assertStrictlyEquals function correctly determines if two values are strictly equal")]
		public function testAssertStrictlyEquals():void {
			var o:Object = new Object();
			assertStrictlyEquals( o, o );
		}
		
		[Test(description="Ensure that the assertStrictlyEquals function correctly determines if two values are strictly equal when a message is provided")]
		public function testAssertStrictlyEqualsWithMessage():void {
			var o:Object = new Object();
			assertStrictlyEquals( "Assert strictly equals fail", o, o );
		}
		
		[Test(description="Ensure that the assertStrictlyEquals function fails when two items are not strictly equal")]
		public function testAssertStrictlyEqualsFails():void {
			var failed:Boolean = false;
			
			try {
				assertStrictlyEquals( 5, "5" );
			} catch (error:AssertionFailedError) {
				failed = true;
				Assert.assertEquals( "expected:<5> but was:<5>", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert strictly equals didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertStrictlyEquals function fails when two items are not strictly euqal and the proper passed message is displayed")]
		public function testAssertStrictlyEqualsWithMessageFails():void {
			var message:String = "Assert strictly equals fail";
			var failed:Boolean = false;
			
			try {
				assertStrictlyEquals( message, 5, "5" );
				// if we get an error with the right message we pass
			} catch (error:AssertionFailedError) {
				failed = true;
				Assert.assertEquals( message + " - expected:<5> but was:<5>", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert strictly equals didn't fail" );
			}
		}
	}
}