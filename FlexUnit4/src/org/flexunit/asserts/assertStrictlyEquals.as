package org.flexunit.asserts
{
	import org.flexunit.Assert;

	public function assertStrictlyEquals(... rest):void {
		Assert.assertStrictlyEquals.apply( null, rest );
	}
}