package org.flexunit.asserts {
	import org.flexunit.Assert;

	public function assertNotNull(... rest):void {
		Assert.assertNotNull.apply( null, rest );
	}
}