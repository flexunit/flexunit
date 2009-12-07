package org.flexunit.asserts {
	import org.flexunit.Assert;

	public function assertNull(... rest):void {
		Assert.assertNull.apply( null, rest );
	}
}