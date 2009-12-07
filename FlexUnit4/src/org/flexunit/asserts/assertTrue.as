package org.flexunit.asserts {
	import org.flexunit.Assert;

	public function assertTrue(... rest):void {
		Assert.assertTrue.apply( null, rest );
	}
}