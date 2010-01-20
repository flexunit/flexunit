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
package org.flexunit.async {
	/**
	 * A respoder for tests that contains <code>Function</code>s for the test succeeding or the test 
	 * failing to succeed.
	 */
	public class TestResponder extends Object implements ITestResponder {
		/**
		 * @private
		 */
		private var resultFunction:Function;
		/**
		 * @private
		 */
		private var faultFunction:Function;
		
		/**
		 * @inheritDoc
		 */
		public function fault( info:Object, passThroughData:Object ):void {
			faultFunction( info, passThroughData );
		}
		
		/**
		 * @inheritDoc
		 */
		public function result( data:Object, passThroughData:Object ):void {
			resultFunction( data, passThroughData );
		}
		
		/**
		 * Constructor.
		 * 
		 * @param result A <code>Function</code> that handles results and expects an info and passThroughData parameter.
		 * 
		 * <code>public function result( info:Object, passThroughData:Object ):void { ...
		 * }</code><br/>
		 * 
		 * @param fault A <code>Function</code> that handles faults and expects a data and passThroughData parameter.
		 * 
		 * <code>public function fault( data:Object, passThroughData:Object ):void { ...
		 * }</code><br/>
		 */
		public function TestResponder( result:Function, fault:Function ) {
			resultFunction = result;
			faultFunction = fault;
		}
	}
}