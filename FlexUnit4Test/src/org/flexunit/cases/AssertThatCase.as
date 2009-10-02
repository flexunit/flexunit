package org.flexunit.cases
{
	import org.flexunit.assertThat;

	public class AssertThatCase
	{
		[Test(expects="org.hamcrest.AssertionError")]
		public function assertThatTest() : void {
			assertThat( true, false );
		}
	}
}