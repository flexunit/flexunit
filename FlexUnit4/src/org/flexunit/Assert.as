/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.flexunit
{
	import flexunit.framework.AssertionFailedError;
 	
	/**
	 * A set of assert methods.  Messages are only displayed when an assert fails.
	 */
	public class Assert
	{
		/**
		 * @private
		 */
		public static var _assertCount:int = 0;
		
		/**
		 * Returns the number of assertions that have been made
		 */
		public static function get assertionsMade() : Number {
			return _assertCount;
		}
		
		
		/**
		 * Resets the count for the number of assertions that have been made back to zero
		 */
		public static function resetAssertionsFields() : void {
			_assertCount = 0;
		}

		public static function assertWithApply( asserter:Function, args:Array ):void {
			_assertCount++;
			asserter.apply( null, args );
		}

		public static function assertWith( asserter:Function, ...rest ):void {
			_assertCount++;
			asserter.apply( null, rest );
		}

		/**
		 * Asserts that two provided values are equal.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments with possible length of 3. 
		 * 			If the length is three the first item is used as the error message.
		 */
		public static function assertEquals(... rest):void
		{
			_assertCount++;
			if ( rest.length == 3 )
				failNotEquals( rest[0], rest[1], rest[2] );
			else
				failNotEquals( "", rest[0], rest[1] );
		}
	
        /**
         * @private
         */
		public static function failNotEquals( message:String, expected:Object, actual:Object ):void
		{
			if ( expected != actual )
			   failWithUserMessage( message, "expected:<" + expected + "> but was:<" + actual + ">" );
		}
	
		/**
		 * /**
		 * Asserts that the provided values are strictly equal.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments with possible length of 3. 
		 * 			If the length is three the first item is used as the error message.
		 */
		public static function assertStrictlyEquals(... rest):void
		{
			_assertCount++;
			if ( rest.length == 3 )
				failNotStrictlyEquals( rest[0], rest[1], rest[2] );
			else
				failNotStrictlyEquals( "", rest[0], rest[1] );
		}
	
        /**
         * @private
         */
		public static function failNotStrictlyEquals( message:String, expected:Object, actual:Object ):void
		{
			if ( expected !== actual )
			   failWithUserMessage( message, "expected:<" + expected + "> but was:<" + actual + ">" );
		}
	
		/**
		 * Asserts that a condition is true. If it isn't it throws an
		 * <code> AssertionFailedError</code> with the given message.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments of length one or two. 
		 * 			If the length is two the first item is used as the error message.
		 */
		public static function assertTrue(... rest):void
		{
			_assertCount++;
			if ( rest.length == 2 )
				failNotTrue( rest[0], rest[1] );
			else
				failNotTrue( "", rest[0] );
		}
	
        /**
         * @private
         */
		public static function failNotTrue( message:String, condition:Boolean ):void
		{
			if ( !condition )
			   failWithUserMessage( message, "expected true but was false" );
		}
	
		/**
		 * Asserts that a condition is false. If it isn't it throws an
		 * <code> AssertionFailedError</code> with the given message.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments of length one or two. 
		 * 			If the length is two the first item is used as the error message.
		 */
		public static function assertFalse(... rest):void
		{
			_assertCount++;
			if ( rest.length == 2 )
				failTrue( rest[0], rest[1] );
			else
				failTrue( "", rest[0] );
		}
	
        /**
         * @private
         */
		public static function failTrue( message:String, condition:Boolean ):void
		{
			if ( condition )
			   failWithUserMessage( message, "expected false but was true" );
		}
	
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Asserts that an object is null. If it is not, an <code> AssertionFailedError</code>
		 * is thrown with the given message.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments of length one or two. 
		 * 			If the length is two the first item is used as the AssertionFailedError message. 
		 * 			(<code>null</code> okay)
		 */
		public static function assertNull(... rest):void
		{
			_assertCount++;
			if ( rest.length == 2 )
				failNotNull( rest[0], rest[1] );
			else
				failNotNull( "", rest[0] );
		}
	
        /**
         * @private
         */
		public static function failNull( message:String, object:Object ):void
		{
			if ( object == null )
			   failWithUserMessage( message, "object was null: " + object );
		}
	
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Asserts that an object isn't null. If it is an <code> AssertionFailedError</code> is
		 * thrown with the given message.
		 * 
		 * @param rest
		 * 			a comma-delimited list of arguments of length one or two. 
		 * 			If the length is two the first item is used as the AssertionFailedError message. 
		 * 			(<code>null</code> okay)
		 */
		public static function assertNotNull(... rest):void
		{
			_assertCount++;
			if ( rest.length == 2 )
				failNull( rest[0], rest[1] );
			else
				failNull( "", rest[0] );
		}
	
        /**
         * @private
         */
		public static function failNotNull( message:String, object:Object ):void
		{
			if ( object != null )
			   failWithUserMessage( message, "object was not null: " + object );
		}
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Fails a test with the given message.
		 * 
		 * @param failMessage
		 *            the identifying message for the <code> AssertionFailedError</code> (<code>null</code>
		 *            okay)
		 * @see AssertionFailedError
		 */
		public static function fail( failMessage:String = ""):void
		{
			throw new AssertionFailedError( failMessage );
		}
	

        /**
         * @private
         */
		private static function failWithUserMessage( userMessage:String, failMessage:String ):void
		{
			if ( userMessage.length > 0 )
				userMessage = userMessage + " - ";
	
			throw new AssertionFailedError( userMessage + failMessage );
		}
	}
}