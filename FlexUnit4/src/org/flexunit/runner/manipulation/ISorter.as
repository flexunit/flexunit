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
	import org.flexunit.runner.IDescription;
	
	/**
	 * Sorters should implement this interface.
	 */
	public interface ISorter
	{	
		/**
		 * Sorts the test in <code>runner</code> using <code>compare function</code>.
		 * 
		 * @param object
		 */
		function apply(object:Object):void;
		
		/**
		 * Compares its two arguments for order. Returns a negative integer, zero, or a positive integer 
		 * as the first argument is less than, equal to, or greater than the second.
		 * 
		 * @param o1 <code>IDescription</code> the first object to be compared.
		 * @param o2 <code>IDescription</code> the second object to be compared.
		 * 
		 * @return a negative integer, zero, or a positive integer 
		 * as the first argument is less than, equal to, or greater than the second.
		 * */
		function compare(o1:IDescription, o2:IDescription):int;
	}
}