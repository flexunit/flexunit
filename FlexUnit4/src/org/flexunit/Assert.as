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
 * @author     Michael Labriola <labriola@digitalprimates.net>
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
		public static var assertCount:int = 0;

		public static function assertWithApply( asserter:Function, args:Array ):void {
			asserter.apply( null, args );
		}

		public static function assertWith( asserter:Function, ...rest ):void {
			asserter.apply( null, rest );
		}

		/**
		 * Asserts that two provided values are equal. If three values are 
		 * provided the first is the message to be displayed on fail.
		 */
		public static function assertEquals(... rest):void
		{
			assertCount++;
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
		 * Asserts that the provided values are strictly equal.
		 */
		public static function assertStrictlyEquals(... rest):void
		{
			assertCount++;
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
		 * {@link AssertionFailedError} with the given message.
		 * 
		 * @param rest
		 * 			array of length one or two. Contains the value to be
		 * 			tested. If the length is two the first index contains
		 * 			the error message to be thrown.
		 */
		public static function assertTrue(... rest):void
		{
			assertCount++;
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
		 * {@link AssertionFailedError} with the given message.
		 * 
		 * @param rest
		 * 			array of length one or two. Contains the value to be
		 * 			tested. If length is two the first index contains
		 * 			the error message to be thrown.
		 */
		public static function assertFalse(... rest):void
		{
			assertCount++;
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
		 * Asserts that an object is null. If it is not, an {@link AssertionFailedError}
		 * is thrown with the given message.
		 * 
		 * @param rest
		 * 			array of length one or two. Contains the Object to be
		 * 			null checked. If the length is two the first index contains
		 *          the identifying message for the {@link AssertionFailedError} 
		 * 			(<code>null</code> okay)
		 */
		public static function assertNull(... rest):void
		{
			assertCount++;
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
		 * Asserts that an object isn't null. If it is an {@link AssertionFailedError} is
		 * thrown with the given message.
		 * 
		 * @param rest
		 * 			array of length one or two. Contains the Object to be
		 * 			null checked. If length is two the first index contains 
		 * 			the identifying message for the {@link AssertionFailedError} 
		 * 			(<code>null</code> okay)
		 */
		public static function assertNotNull(... rest):void
		{
			assertCount++;
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
		 *            the identifying message for the {@link AssertionFailedError} (<code>null</code>
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