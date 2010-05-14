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
package org.flexunit.experimental.theories.internals {
	import org.flexunit.AssertionError;
	
	/**
	 * Thrown when an assertion is false and provides the parameters that caused the test to fail.
	 */
	public class ParameterizedAssertionError extends AssertionError {
		/**
		 * The exception that was thrown.
		 */
		public var targetException:Error;
		
		/**
		 * Constructor.
		 * 
		 * @param targetException The exception that was thrown.
		 * @param methodName The name of the method that threw the exception.
		 * @param params The parameters that were provided to the method that threw the exception.
		 */
		public function ParameterizedAssertionError( targetException:Error, methodName:String, ...params ) {
			this.targetException = targetException;
			//super( methodName + " " + ( params as Array ).join( ", " ) );
			//This blows up on Mac FP10... I believe the params may be getting a this pointer causing a stack overflow.
			//For the moment, we will only pass the methodname until this is resolved 
			super( methodName );
		}
	
//		public function equals( obj:Object ):Boolean {
//			return this.toString() == (obj.toString());
//		}
		
		public static function join( delimiter:String, ...params):String {
			return ( params as Array ).join( delimiter );
		}

//TODO: Figure out when this is needed and how to distinguish from above
/*  		public static function String join(String delimiter,
				Collection<Object> values) {
			StringBuffer buffer = new StringBuffer();
			Iterator<Object> iter = values.iterator();
			while (iter.hasNext()) {
				Object next = iter.next();
				buffer.append(stringValueOf(next));
				if (iter.hasNext()) {
					buffer.append(delimiter);
				}
			}
			return buffer.toString();
		}
 */ 
 		//public function toString():String {
// 			return stringValueOf( this );
 		//}

		private static function stringValueOf( next:Object ):String {
			var result:String;
			
			try {
				result = String(next);
			} catch ( e:Error ) {
				result = "[toString failed]";
			}
			
			return result;
		}
	}
}