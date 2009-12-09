package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertNotNull method
	 * 
	 * @param rest
	 *			Accepts an argument of type Object.
	 * 			If two arguments are passed the first argument must be a String
	 * 			and will be used as the error message.
	 * 			
	 * 			<code>assertNotNull( String, Object );</code>
	 * 			<code>assertNotNull( Object );</code>
	 * 
	 * @see org.flexunit.Assert assertNotNull 
	 */
	public function assertNotNull(... rest):void {
		Assert.assertNotNull.apply( null, rest );
	}
}