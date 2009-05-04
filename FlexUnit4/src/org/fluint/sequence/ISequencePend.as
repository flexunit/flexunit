/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/ 
 package org.fluint.sequence {
	
	/**
	 * Interface defined by any step who's primary purpose is to pend 
	 * (or wait) for an action to occur before continuing the test.
	 */
	public interface ISequencePend extends ISequenceStep {
		/** 
		 * The name of the event that this step is pending upon.
		 */
		function get eventName():String;

		/** 
		 * Time in milliseconds this operation is allowed before it is considered a 
		 * failure.
		 */
		function get timeout():int;
	
		/** 
		 * Event handler to call on a timeout.
		 */
		function get timeoutHandler():Function;
		
		/** 
		 * Called to cause implementors to setup their wait conditions.
		 */
		function setupListeners( testCase:*, sequence:SequenceRunner ):void;
	}
}