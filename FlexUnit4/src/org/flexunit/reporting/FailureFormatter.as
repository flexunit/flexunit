package org.flexunit.reporting {
	import flash.utils.getQualifiedClassName;
	
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.AssertionError;
	import org.hamcrest.AssertionError;
	
	/**
	 * Responsible for formatting potential failures
	 */
	public class FailureFormatter {
		
		/**
		 * Returns a boolean indicating whether the the error parameter is an actual failure or an expected failure
		 * 
		 * @param error The error that was thrown
		 */
		//Determines if this is a failure or Error for reporting purposes
		//This will eventually need to be dynamic, but this will get us started
		public static function isError( error:Error ):Boolean {
			var failure:Boolean = 
			   ( ( error is org.flexunit.AssertionError ) ||
				 ( error is org.hamcrest.AssertionError ) ||
				 ( error is flexunit.framework.AssertionFailedError ) ||
				 ( getQualifiedClassName( error ) == "net.digitalprimates.fluint.assertion::AssertionFailedError" ) );

			return !failure;
		}
		
		/**
		 * Filters XML characters out of a String
		 * 
		 * @param message The String that will have XML characters filtered out of it
		 * 
		 * @return the input String without XML characters
		 */
		public static function xmlEscapeMessage( message:String ):String {
			var escape:XML = <escape/>;
			var escaped:String = '';
			
			if ( message ) {
				//Set the children of the escape XML as the string message, and then retrieve the first item of
				//the XMLList of children and convert the XML to a string, resulting in a string without XML characters
				escape.setChildren( message );
				escaped = escape.children()[0].toXMLString();
			}

			return escaped;
		}
		
	}
}