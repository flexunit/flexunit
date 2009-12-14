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
package org.flexunit.internals.requests
{
	import org.flexunit.runner.IRequest;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.Request;
	import org.flexunit.runner.manipulation.ISorter;
	import org.flexunit.runner.manipulation.Sorter;
	
	/**
	 * A <code>Request</code> that sorts the ordering in a test class.
	 */
	public class SortingRequest extends Request
	{
		/**
		 * @private
		 */
		private var request:IRequest;
		/**
		 * @private
		 */
		private var comparator:Function;

		/**
		 * @private
		 */
		private var sorter:ISorter;

		/**
		 * Constructor.
		 * 
		 * Creates a sorted Request.
		 * 
		 * @param request An <code>IRequest</code> describing the tests.
		 * @param sorterOrComparatorFunction is either an ISorted implementation or a comparator function to be used
		 * to define the sort order of the tests in this Request.
		 */
		public function SortingRequest(request:IRequest, sorterOrComparatorFunction:*)
		{
			super();
			this.request = request;
			
			if ( sorterOrComparatorFunction is ISorter ) {
				this.sorter = sorterOrComparatorFunction as ISorter;
			} else if ( sorterOrComparatorFunction is Function ) {
				this.comparator = sorterOrComparatorFunction as Function;
			} else {
				throw new TypeError("Provided an invalid parameter for the sorterOrComparatorFunction argument");
			}
		}
		
		//TODO: Unsure of meaning and applicability of @inheritDoc
		public override function get iRunner():IRunner {
			var runner:IRunner = request.iRunner;

			if ( sorter ) {
				sorter.apply( runner );
			} else if ( comparator != null ) {
				new Sorter(comparator).apply(runner);	
			}

			return runner;
		}

	}
}