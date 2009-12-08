package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertFalse method
	 * 
	 * @param rest
	 * 			Accepts an argument of type Boolean.
	 * 			If two arguments are passed the first argument must be a String
	 * 			and will be used as the error message.
	 * 			
	 * 			<code>assertFalse( String, Boolean );</code>
	 * 			<code>assertFalse( Boolean );</code>
	 * 
	 * @see org.flexunit.Assert assertFalse 
	 */

	public function assertFalse(... rest):void {
		Assert.assertFalse.apply( null, rest );
	}
}