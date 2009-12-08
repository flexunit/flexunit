package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertEquals method
	 * 
	 * @param rest
	 * 			Must be passed at least 2 arguments of type Object to compare for equality.
	 * 			If three arguments are passed, the first argument must be a String
	 * 			and will be used as the error message.
	 * 
	 * 			<code>assertEquals( String, Object, Object );</code>
	 * 			<code>assertEquals( Object, Object );</code>
	 * 
	 * @see org.flexunit.Assert assertEquals 
	 */
	public function assertEquals( ...rest ):void {
		Assert.assertEquals.apply( null, rest );
	}
}