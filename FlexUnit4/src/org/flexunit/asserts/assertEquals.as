package org.flexunit.asserts {
	import org.flexunit.Assert;

	public function assertEquals( ...rest ):void {
		Assert.assertEquals.apply( null, rest );
	}
}