package org.flexunit.asserts
{
	import org.flexunit.Assert;

	/**
	 * Alias for org.flexunit.Assert assertStrictlyEquals method
	 * 
	 * @param rest
	 * 			Must be passed at least 2 arguments of type Object to compare for strict equality.
	 * 			If three arguments are passed, the first argument must be a String
	 * 			and will be used as the error message.
	 * 
	 * 			<code>assertStrictlyEquals( String, Object, Object );</code>
	 * 			<code>assertStrictlyEquals( Object, Object );</code>
	 * 
	 * @see org.flexunit.Assert assertStrictlyEquals 
	 */
	public function assertStrictlyEquals(... rest):void {
		Assert.assertStrictlyEquals.apply( null, rest );
	}
}