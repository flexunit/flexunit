package org.flexunit.asserts {
	import org.flexunit.Assert;

	public static function assertFalse(... rest):void {
		Assert.assertFalse.apply( null, rest );
	}
}