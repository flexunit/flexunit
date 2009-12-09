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
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	
	/**
	 * A <code>Sorter</code> orders tests. In general you will not need
	 * to use a <code>Sorter</code> directly. Instead, use <code>org.flexunit.runner.Request#sortWith(Function)</code>.
	 * 
	 * @see org.flexunit.runner.Request#sortWith()
	 */
	public class Sorter implements ISorter
	{	
		/**
		 * @private
		 */
		private var comparator:Function;
		
		/**
		 * Constructor.
		 * 
		 * Creates a <code>Sorter</code> that uses the <code>comparator</code>
		 * to sort tests.
		 * 
		 * @param comparator the <code>Function</code> to use when sorting tests.
		 */
		public function Sorter(comparator:Function) {
			this.comparator = comparator;
		}
		
		/**
		 * Sorts the test in <code>runner</code> using <code>comparator</code>/
		 * 
		 * @param object
		 */
		public function apply(object:Object):void {
			if (object is ISortable) {
				var sortable:ISortable = (object as ISortable);
				sortable.sort(this);
			}
		}
		
		/**
		 * Compares its two arguments for order. Returns a negative integer, zero, or a positive integer 
		 * as the first argument is less than, equal to, or greater than the second.
		 * 
		 * @param o1 <code>IDescription</code> the first object to be compared.
		 * @param o2 <code>IDescription</code> the second object to be compared.
		 * */
		public function compare(o1:IDescription, o2:IDescription):int {
			return comparator(o1, o2);
		}
	}
}