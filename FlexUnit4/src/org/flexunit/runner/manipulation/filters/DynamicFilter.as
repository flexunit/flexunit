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
package org.flexunit.runner.manipulation.filters {
	import org.flexunit.runner.IDescription;
	
	
	/**
	 * The canonical case of filtering is when you want to run a single test method in a class. Rather
	 * than introduce runner API just for that one case, FlexUnit provides a general filtering mechanism.
	 * If you want to filter the tests to be run, extend <code>Filter</code> and apply an instance of
	 * your filter to the <code>org.flexunit.runner.Request</code> before running it (see 
	 * <code>org.flexunit.runner.FlexUnitCore#run(Request)</code>. 
	 * 
	 * //TODO: IRunner is an interface, there is no pre-existing implementing class, does the following 
	 * //still apply? Is there a RunWith equivalent
	 * Alternatively, apply a <code>Filter</code> to 
	 * a org.junit.runner.Runner before running tests (for example, in conjunction with 
	 * org.junit.runner.RunWith.
	 * 
	 * @see org.flexunit.runner.FlexUnitCore#run()
	 */
	public class DynamicFilter extends AbstractFilter {
		private var _shouldRunFunction:Function;
		private var _describeFunction:Function;

		/**
		 * @param description the description of the test to be run
		 * @return <code>true</code> if the test should be run
		 */
		override public function shouldRun( description:IDescription ):Boolean {
			return _shouldRunFunction( description );
		}
		
		/**
		 * Returns a textual description of this Filter
		 * @return a textual description of this Filter
		 */
		override public function describe( description:IDescription ):String {
			return _describeFunction( description );			
		}

		public function DynamicFilter( shouldRunFunction:Function, describeFunction:Function ) {
			if ( ( shouldRunFunction == null ) || ( describeFunction == null ) ) {
				throw new TypeError("Must provide functions for comparison and description to Filter");
			}
			this._shouldRunFunction = shouldRunFunction;
			this._describeFunction = describeFunction;
		}
	}
}

