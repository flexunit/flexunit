package org.flexunit.reporting.cases
{
	import org.flexunit.Assert;
	import org.flexunit.reporting.FailureFormatter;

	public class FailureFormatterFlexCase
	{		
		
		[Test(description="Ensure that a Fluint AssertionFailedError is not a failure")]
		public function isErrorFluintAssertionFailedErrorTest():void {
			import net.digitalprimates.fluint.assertion.AssertionFailedError;
			Assert.assertFalse( FailureFormatter.isError(new net.digitalprimates.fluint.assertion.AssertionFailedError("test")) );
		}
		
		
	}
}