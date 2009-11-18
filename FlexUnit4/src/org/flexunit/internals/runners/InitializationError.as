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
package org.flexunit.internals.runners {
	
	/**
	 * The <code>InitializationError</code> represents one or more problems encountered while 
	 * initializing an <code>IRunner</code>.
	 */
	public class InitializationError extends Error {
		/**
		 * @private
		 */
		private var _errors:Array = new Array();;

		/**
		 * Construct a new <code>InitializationError</code> with one or more
		 * errors <code>arg</code> as causes.
		 * 
		 * @param arg The issue that cuased the <code>InitializationError</code> to occur.
		 */
		public function InitializationError( arg:* ) {
			if ( arg is Array ) {
				_errors = arg;
			} else if ( arg is String ) {
				_errors = new Array( new Error( arg ) );
			} else {
				_errors = new Array( arg );
			}
			super("InitializationError", 0);
		}

		/**
		 * Returns one or more Throwables that led to this initialization error.
		 * 
		 * @return an array contiaining the causes of the <code>InitializationError</code>.
		 */
		public function getCauses():Array {
			return _errors;
		}
	}
}