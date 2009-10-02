package org.flexunit.cases
{
	import org.flexunit.assumeThat;
	import org.hamcrest.object.equalTo;
	

	public class AssumeThatCase
	{
		[Test(expects="org.flexunit.internals.AssumptionViolatedException")]
		public function AssumeThatTest() : void {
			assumeThat( true, equalTo( false ) );
		}
	}
}
