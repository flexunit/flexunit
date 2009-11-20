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
package org.flexunit.runner.manipulation
{
	/**
	 * Interface for runners that allow sorting of tests. By sorting tests based on when they last failed, 
	 * most recently failed first, you can reduce the average time to the first test failing. Test sorting 
	 * should not be used to cope with order dependencies between tests. Tests that are isolated from each 
	 * other are less expensive to maintain and can be run individually. 
	 * */
	public interface ISortable
	{
		/**
		 * Sorts the tests using <code>sorter</code>.
		 * 
		 * @param sorter The <code>Sorter</code> to use for sorting the tests.
		 */
		function sort(sorter:ISorter):void;
	}
}