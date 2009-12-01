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
	 * An <code>IAsyncStatement</code> is an interface for statements that need to be evaluated and report
	 * to a parent when the statement has finish evaluating.  Often times, <code>IAsyncStatement</code> are chained together
	 * with each statement performing a specific task and notifying its parent when it has finished.
	 */
	public interface IAsyncStatement {
		/**
		 * Responisble for evaluating the current statement and reporting its completion to the provided 
		 * <code>parentToken</code>.
		 * 
		 * @param parentToken An <code>AsyncTestToken</code> that is used to notify a parent that the current 
		 * statement has finished being evalutated.
		 */
		function evaluate( parentToken:AsyncTestToken ):void;
	}
}