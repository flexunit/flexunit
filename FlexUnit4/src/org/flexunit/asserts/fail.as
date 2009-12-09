package org.flexunit.asserts {
	import org.flexunit.Assert;

	/**
	 * Fails a test with the given message.
	 * 
	 * @param failMessage
	 *            the identifying message for the <code> AssertionFailedError</code> 
	 * @see AssertionFailedError
	 */	
	public function fail( failMessage:String = "" ):void {
		Assert.fail( failMessage );
	}
}