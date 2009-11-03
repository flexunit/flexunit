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
package org.flexunit.internals.runners.statements {
	
	import org.flexunit.token.AsyncTestToken;
	
	/**
	 * The AsyncStatementBase is responsible for notifiying a token that it has completed its task.
	 */
	public class AsyncStatementBase {
		protected var parentToken:AsyncTestToken;
		protected var myToken:AsyncTestToken;
		protected var sentComplete:Boolean = false;
		
		/**
		 * Constructor.
		 */
		public function AsyncStatementBase() {
			super();
		}
		
		/**
		 * If the parentToken has not already been alerted that the statement has completed, alert the parent token that
		 * the current statement has finished
		 * 
		 * @param error The Error to send to the parentToken
		 */
		protected function sendComplete( error:Error = null ):void {
			//If the parentToken hasn't already be notified that the statement has completed, notify the parentToken
			if ( !sentComplete ) {
				sentComplete = true;
				parentToken.sendResult( error );
			} else {
				trace("Whoa... been asked to send another complete and I already did that");
			}
			
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */
		public function toString():String {
			return "Async Statement Base";
		}
		
	}
}