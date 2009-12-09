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
	 * An <code>ITestResponder</code> is an interface for to be implemented by classes that want to handle the results
	 * of running a test.
	 */
	public interface ITestResponder {
		/**
		 * This method is called by TestCase when an error has been received.
		 * 
		 * @param info An Object containing information about why the fault occured
		 * @param passThroughData An Object containing data that is to be passed to the fault handler function
		 **/
		function fault( info:Object, passThroughData:Object ):void 

		/**
		 * This method is called by TestCase when the return value has been received.
		 * 
		 * @param info An Object containing information about the result
		 * @param passThroughData An Object containing data that is to be passed to the result handler function
		 **/
		function result( data:Object, passThroughData:Object ):void 
	}
}