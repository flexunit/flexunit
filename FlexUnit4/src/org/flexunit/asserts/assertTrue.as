package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertTrue method
	 * 
	 * @param rest
	 * 			Accepts an argument of type Boolean.
	 * 			If two arguments are passed the first argument must be  a String
	 * 			and will be used as the error message.
	 * 			
	 * 			<code>assertTrue( String, Boolean );</code>
	 * 			<code>assertTrue( Boolean );</code>
	 * 
	 * @see org.flexunit.Assert assertTrue;
	 */
	public function assertTrue(... rest):void {
		Assert.assertTrue.apply( null, rest );
	}
}