package org.flexunit.asserts {
	import org.flexunit.Assert;

	public static function assertNull(... rest):void {
		Assert.assertNull.apply( null, rest );
	}
}