package org.flexunit.reporting.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.hamcrest.AssertionError;
	import org.flexunit.reporting.FailureFormatter;

	public class FailureFormatterCase
	{
		//TODO: Ensure that the tests and test case are being implemented correctly
		
		[Test(description="Ensure that a regular Error is a failure")]
		public function isErrorFlexUnitAssertionErrorTest():void {
			Assert.assertTrue( FailureFormatter.isError(new Error()) );
		}
		
		[Test(description="Ensure that a Flex Unit AssertionError is not a failure")]
		public function isErrorNormalErrorTest():void {
			Assert.assertFalse( FailureFormatter.isError(new org.flexunit.AssertionError("test")) );
		}
		
		[Test(description="Ensure that a Hamcrest AssertionError is not a failure")]
		public function isErrorHamcrestAssertionErrorTest():void {
			Assert.assertFalse( FailureFormatter.isError(new org.hamcrest.AssertionError("test")) );
		}
		
		[Test(description="Ensure that a Falex Unit AssertionFailedError is not a failure")]
		public function isErrorFlexUnitAssertionFailedErrorTest():void {
			Assert.assertFalse( FailureFormatter.isError(new flexunit.framework.AssertionFailedError("test")) );
		}

		CONFIG::useFlexClasses {
		[Test(description="Ensure that a Fluint AssertionFailedError is not a failure")]
		public function isErrorFluintAssertionFailedErrorTest():void {
			import net.digitalprimates.fluint.assertion.AssertionFailedError;
			Assert.assertFalse( FailureFormatter.isError(new net.digitalprimates.fluint.assertion.AssertionFailedError("test")) );
		}
		}
		
		[Test(description="Ensure that the message string is returned from the xmlEscapeMessage function")]
		public function xmlEscapeMessageWithMessageTest():void {
			var testMessage:String= "testMessage";
			
			Assert.assertEquals( testMessage, FailureFormatter.xmlEscapeMessage(testMessage) );	
		}
		
		[Test(description="Ensure that an empty string is returned from the xmlEscapeMessage function")]
		public function xmlEscapeMessageWithNoMessageTest():void {
			Assert.assertEquals( "", FailureFormatter.xmlEscapeMessage(null) );
		}
	}
}