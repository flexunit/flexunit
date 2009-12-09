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
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.token.AsyncTestToken;
	
	/**
	 * The <code>Fail</code> class is responsible for throwing a failure error when it
	 * is evaluated.  A <code>Fail</code> is often created if a critical piece of infomration
	 * is missing and another statement could not be properly generated.
	 * 
	 * @see org.flexunit.runners.BlockFlexUnit4ClassRunner
	 */
	public class Fail extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private
		 */
		private var error:Error;
		
		/**
		 * Constructor.
		 * 
		 * @param error The <code>Error</code> to be thrown when this statement is evalutated.
		 */
		public function Fail( error:Error ) {
			this.error = error;
		}
		
		/**
		 * Throws the error that was initially provided to <code>Fail</code>.
		 * 
		 * @param previousToken AsyncTestToken - Passed in, but not used in this method.
		 */
		public function evaluate( previousToken:AsyncTestToken ):void {
			throw error;
		}
	}
}
