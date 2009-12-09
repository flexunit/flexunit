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
package org.flexunit.internals
{
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.SelfDescribing;
	import org.hamcrest.StringDescription;
	
	/**
	 * The <code>AssumptionViolatedException</code> is thrown when an assumption in a test
	 * evalutes to false.  It contains information about the incorrect value that was
	 * encountered that caused the assumption to fail as well as the values that the
	 * assumption was expecting.  The <code>AssumptionViolatedException</code> is currently
	 * thrown when an assumption fails in the <code>Assume</code> class.
	 * 
	 * @see org.flexunit.Assume
	 */
	public class AssumptionViolatedException extends Error implements SelfDescribing
	{
		/**
		 * @private
		 */
		private var value:Object;
		/**
		 * @private
		 */
		private var matcher:Matcher;
		
		/**
		 * Constructor.
		 * 
		 * @param value The value that was obtained when the assumption was evaluated.
		 * @param matcher The matcher used to evaluate the assumption.
		 */
		public function AssumptionViolatedException( value:Object, matcher:Matcher=null ) {
			super(); //value instanceof Throwable ? (Throwable) value : null);
			this.value = value;
			this.matcher = matcher;
			
			//unfortunate, but best approach for now as we cannot override the message var
			this.message = getMessage();
		}
	
		public function getMessage():String {			
			return StringDescription.toString(this);
		}
	
		public function describeTo( description:Description ):void {
			if (matcher != null) {
				description.appendText("got: ");
				description.appendValue(value);
				description.appendText(", expected: ");
				description.appendDescriptionOf(matcher);
			} else {
				description.appendText("failed assumption: " + value);
			}
		}
	}
}