package org.flexunit.internals.builders.definitions
{
	import org.flexunit.Assert;

	public class FlexUnit4Class
	{
		[Test]
		public function testTrue() : void {
			Assert.assertTrue( true );
		}
		
		[Ignore]
		[Test]
		public function testIgnore() : void {
			Assert.assertTrue( true );
		}
		
		[Ignore]
		[Test]
		public function suite() : void {
			Assert.assertTrue( true );
		}
	}
}