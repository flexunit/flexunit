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
	 * The <code>AsyncStatementBase</code> is responsible for notifiying a parent token that a task has been completed.
	 * Many statement classes extend from this class in order to notify a parent statement that it has finished.
	 * Classes that extend from the <code>AsyncStatementBase</code> can communicate with a parent class that has provided
	 * an <code>AsyncTestToken</code> and notify the parent class when the class has finished its specific task.<br/>
	 * 
	 * A class that extends from the <code>AsyncStatementBase</code> calls the <code>#sendComplete()</code> method once
	 * a parent <code>AsyncTestToken</code> is supplied.  The parent token will then be notified of a potential error
	 * that was encountered when running the <code>AsyncStatementBase</code>.
	 */
	public class AsyncStatementBase {
		/**
		 * The <code>AsyncTestToken</code> for the parent of the current statment.  This is notified when the
		 * current statement has finished.
		 * 
		 * @see #sendComplete()
		 */
		protected var parentToken:AsyncTestToken;
		/**
		 * The <code>AsyncTestToken</code> for the current statment.
		 */
		protected var myToken:AsyncTestToken;
		/**
		 * @private
		 */
		protected var sentComplete:Boolean = false;
		
		/**
		 * Constructor.
		 */
		public function AsyncStatementBase() {
			super();
		}
		
		/**
		 * If the parentToken has not already been alerted that the statement has completed, alert the parent token that
		 * the current statement has finished.
		 * 
		 * @param error The Error to send to the parentToken.
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
		 */
		public function toString():String {
			return "Async Statement Base";
		}
		
	}
}