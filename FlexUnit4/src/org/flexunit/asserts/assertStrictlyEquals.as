package org.flexunit.asserts
{
	import org.flexunit.Assert;

	public function assertStrictlyEquals(... rest):void {
		Assert.assertEquals.apply( null, rest );
	}
}