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
		public static var _assertCount:uint = 0;
		
		/**
		 * Returns the number of assertions that have been made
		 */
		public static function get assertionsMade() : uint {
			return _assertCount;
		}
		
		
		/**
		 * Resets the count for the number of assertions that have been made back to zero
		 */
		public static function resetAssertionsFields() : void {
			_assertCount = 0;
		}
		
		/**
		 * @private
		 */
		public static function assertWithApply( asserter:Function, args:Array ):void {
			_assertCount++;
			asserter.apply( null, args );
		}

		/**
		 * @private
		 */
		public static function assertWith( asserter:Function, ...rest ):void {
			_assertCount++;
			asserter.apply( null, rest );
		}

		/**
		 * Asserts that two provided values are equal.
		 * 
		 * @param rest
		 * 			Must be passed at least two arguments of type Object to compare for equality.
		 * 			If three arguments are passed, the code determines if the first parameter
		 * 			is the error message, or the third parameter is the delta (see note).
		 * 			The delta is used for asserting that two values are almost equal (when
		 * 			Math.abs(actual - expected) &lt;= delta).
		 * 			If four arguments are passed, the first parameter is the error message and
		 * 			the last is the delta.
		 * 
		 * 			<code>assertEquals( Object, Object );</code>
		 * 			<code>assertEquals( String, Object, Object );</code>
		 * 			<code>assertEquals( Object, Object, Number );</code>
		 * 			<code>assertEquals( String, Object, Object, Number );</code>
		 *
		 * 			NOTE: In determining, with three arguments, whether the first parameter
		 * 			is the error message, or the last is the delta, there is one susceptibility
		 * 			to misinterprentation: when comparing two numbers, the error message must
		 * 			not be a number (<code>!(errorMessage is Number)</code>) or else the error
		 * 			message will be interpreted as the first number to compare to.
		 */
		public static function assertEquals(... rest):void
		{
			_assertCount++;
			var needsBlankMessage:Boolean;
			if ( rest.length == 2 )
			{
				needsBlankMessage = true;
			}
			else if ( rest.length == 4 )
			{
				needsBlankMessage = false;
			}
			else
			{
				needsBlankMessage = true;
				for each ( var value:Object in rest )
				{
					var num:Number = Number( value );
					if ( isNaN( num ) )
					{
						needsBlankMessage = false;
						break;
					}
				}
			}

			if ( needsBlankMessage )
				rest = [ "" ].concat( rest );
			failNotEquals.apply( null, rest );
		}
	
        /**
         * @private
         */
		public static function failNotEquals( message:String, expected:Object, actual:Object, delta:Number=0.0 ):void
		{
			var isFail:Boolean = false;
			if ( delta == 0.0 )
			{
				if ( expected != actual )
					isFail = true;
			}
			else
			{
				var actualNum:Number = Number( actual );
				var expectedNum:Number = Number( expected );
				if ( Math.abs( actualNum - expectedNum ) > delta )
					isFail = true;
			}
			if ( isFail )
				failWithUserMessage( message, "expected:<" + expected + "> but was:<" + actual + ">" );
		}
	
		/**
		 * /**
		 * Asserts that the provided values are strictly equal.
		 * 
		 * @param rest
		 * 			Must be passed at least 2 arguments of type Object to compare for strict equality.
		 * 			If three arguments are passed, the first argument must be a String
		 * 			and will be used as the error message.
		 * 
		 * 			<code>assertStrictlyEquals( String, Object, Object );</code>
		 * 			<code>assertStrictlyEquals( Object, Object );</code>
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
		 * Asserts that a condition is true.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String 
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertTrue( String, Boolean );</code>
		 * 			<code>assertTrue( Boolean );</code>
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
         * Asserts that a condition is not true.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String 
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertTrue( String, Boolean );</code>
		 * 			<code>assertTrue( Boolean );</code>
         */
		public static function failNotTrue( message:String, condition:Boolean ):void
		{
			if ( !condition )
			   failWithUserMessage( message, "expected true but was false" );
		}
	
		/**
         * Asserts that a condition is false.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertFalse( String, Boolean );</code>
		 * 			<code>assertFalse( Boolean );</code>
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
         * Asserts that a condition is false. 
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String 
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertTrue( String, Boolean );</code>
		 * 			<code>assertTrue( Boolean );</code>
         */
		public static function failTrue( message:String, condition:Boolean ):void
		{
			if ( condition )
			   failWithUserMessage( message, "expected false but was true" );
		}
	
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Asserts that an object is null.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Object.
		 * 			If two arguments are passed the first argument must be a String
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertNull( String, Object );</code>
		 * 			<code>assertNull( Object );</code>
		 * 
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
         * Asserts that an object is not null. 
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String 
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertTrue( String, Boolean );</code>
		 * 			<code>assertTrue( Boolean );</code>
         */
		public static function failNull( message:String, object:Object ):void
		{
			if ( object == null )
			   failWithUserMessage( message, "object was null: " + object );
		}
	
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Asserts that an object is not null.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Object.
		 * 			If two arguments are passed the first argument must be a String
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertNotNull( String, Object );</code>
		 * 			<code>assertNotNull( Object );</code>
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
         * Asserts that an object is not null.
		 * 
		 * @param rest
		 * 			Accepts an argument of type Boolean.
		 * 			If two arguments are passed the first argument must be a String 
		 * 			and will be used as the error message.
		 * 			
		 * 			<code>assertTrue( String, Boolean );</code>
		 * 			<code>assertTrue( Boolean );</code>
         */
		public static function failNotNull( message:String, object:Object ):void
		{
			if ( object != null )
			   failWithUserMessage( message, "object was not null: " + object );
		}
		//TODO:  (<code>null</code> okay) needs removal?
		/**
		 * Fails a test with the argument message.
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
