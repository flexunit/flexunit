package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertNull method
	 * 
	 * @param rest
	 * 			Accepts an argument of type Object.
	 * 			If two arguments are passed the first argument must be a String
	 * 			and will be used as the error message.
	 * 			
	 * 			<code>assertNull( String, Object );</code>
	 * 			<code>assertNull( Object );</code>
	 * 
	 * @see org.flexunit.Assert assertNull
	 */
	public function assertNull(... rest):void {
		Assert.assertNull.apply( null, rest );
	}
}