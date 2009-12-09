package org.flexunit.asserts.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;

	public class assertEqualsCase
	{
		[Test(description="Ensure that the assertEquals alias function correctly determines if two non-strictly equal items are equal")]
		public function testAssertEquals():void {
			var o:Object = new Object();
			
			assertEquals( null, null );
			assertEquals( o, o );
			assertEquals( 5, 5 );
			assertEquals( "5", "5" );
			assertEquals( 5, "5" );
		}
		
		[Test(description="Ensure that the assertEquals alias function correctly determines if two non-strictly equal items are equal when a message is provided")]
		public function testAssertEqualsWithMessage():void {
			assertEquals( "Assert equals fail", "5", 5 );
		}
		
		[Test(description="Ensure that the assertEquals alias function fails when two items are not equal")]
		public function testAssertEqualsFails():void {
			var failed:Boolean = false;

			try {
				assertEquals( 2, 4 );
			} catch ( error : AssertionFailedError ) {
				failed = true;
				Assert.assertEquals( "expected:<2> but was:<4>", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert equals didn't fail" );
			}
		}
		
		[Test(description="Ensure that the assertEquals alias function fails when two items are not equal and the proper passed message is displayed")]
		public function testAssertEqualsWithMessageFails():void {
			var message:String = "Assert equals fail";
			var failed:Boolean = false;
			
			try {
				assertEquals( message, 2, 4 );
				// if we get an error with the right message we pass
			} catch (error:AssertionFailedError) {
				failed = true;
				Assert.assertEquals( message + " - expected:<2> but was:<4>", error.message );
			}
			if ( !failed ) {
				Assert.fail( "Assert equals didn't fail" );
			}
		}
		
	}
}