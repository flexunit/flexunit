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
package org.flexunit.token {
	/**
	 * The <code>ChildResult</code> stores an <code>AsyncTestToken</code> and a potential <code>Error</code> 
	 * associated with the execution of an <code>IAsyncStatement</code>.  <code>ChildResult</code>s are created
	 * in order to provided information about the execution of one particular task to another task.<br/>
	 * 
	 * <code>ChildResult</code>s are used throughout much of FlexUnit4.  They are used to report information to
	 * <code>FlexUnitCore</code>, runners, statements, and parts of a test when a certain activity has finished.
	 */
	public class ChildResult {
		/**
		 * The <code>AsyncTestToken</code> associated with the result.
		 */
		public var token:AsyncTestToken;
		
		/**
		 * The <code>Error</code> associated with the result.
		 */
		public var error:Error;

		/**
		 * Creates a new ChildResult with the provided <code>token</code> and <code>erorr</code>.
		 * 
		 * @param token The token to associate with this result.
		 * @param error The potential <code>Error</code> that was generated from this operation.  If an
		 * <code>Error</code> was not genereated, the <code>error</code> will default to <code>null</code>.
		 */
		public function ChildResult( token:AsyncTestToken, error:Error=null ){
			this.token = token;
			this.error = error;
		}
	}
}