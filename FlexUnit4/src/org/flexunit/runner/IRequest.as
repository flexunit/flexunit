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
package org.flexunit.runner {
	import org.flexunit.runner.manipulation.ISort;
	
	/**
	 * An <code>IRequest</code> is an abstract description of tests to be run.  It represents an object that 
	 * wraps tests when they are presented to the <code>FlexUnitCore</code>.  <code>IRequest</code>s can be 
	 * filtered and sorted to control the subset and order of tests to be executed.<br/>
	 * 
	 * The key property of the <code>IRequest</code> that the <code>FlexUnitCore</code> needs is the 
	 * <code>IRunner</code>.  The <code>IRunner</code> is an interface implemented by any object 
	 * capable of executing a specific type of test.<br/>
	 * 
	 * @see org.flexunit.runner.IRunner
	 */
	public interface IRequest {
		/**
		 * Returns that <code>ISort</code> that is being used by this <code>IRequest</code>.
		 */
		function get sort():ISort;
		function set sort( value:ISort ):void;
		
		/**
		 * Returns an <code>IRunner</code> for this <code>IRequest</code>.
		 */
		function get iRunner():IRunner;
		
		/**
		 * Creates a request that is filtered based on the provided
		 * <code>filterOrDescription</code> which is either an <code>Filter</code>
		 * or an <code>IDescription</code>.
		 * 
		 * @param filterOrDescription The <code>Filter</code> or <code>Description</code> 
		 * to apply to this <code>Request</code>.
		 * 
		 * @return a <code>Request</code> that has been filtered.
		 */
		function filterWith( filterOrDescription:* ):Request;
	}
}