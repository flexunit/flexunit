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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.runner.manipulation {
	import org.flexunit.runner.IDescription;
	
	
	/**
	 * The canonical case of filtering is when you want to run a single test method in a class. Rather
	 * than introduce runner API just for that one case, FlexUnit provides a general filtering mechanism.
	 * If you want to filter the tests to be run, extend <code>Filter</code> and apply an instance of
	 * your filter to the {@link org.flexunit.runner.Request} before running it (see 
	 * {@link org.junit.runner.FlexUnitCore#run(Request)}. 
	 * 
	 * //TODO: IRunner is an interface, there is no pre-existing implementing class, does the following 
	 * //still apply? Is there a RunWith equivalent
	 * Alternatively, apply a <code>Filter</code> to 
	 * a {@link org.junit.runner.Runner} before running tests (for example, in conjunction with 
	 * {@link org.junit.runner.RunWith}.
	 */
	public class Filter {

		//only way I cold make this work
		public static var ALL:Filter = buildAllFilter();

		/**
		 * @param description the description of the test to be run
		 * @return <code>true</code> if the test should be run
		 */
		public var shouldRun:Function; //shouldRun(Description description):Boolean;
		
		/**
		 * Returns a textual description of this Filter
		 * @return a textual description of this Filter
		 */
		public var describe:Function; //describe():String

		/**
		 * Invoke with a {@link org.flexunit.runner.IRunner} to cause all tests it intends to run
		 * to first be checked with the filter. Only those that pass the filter will be run.
		 * @param child the runner to be filtered by the receiver
		 * @throws NoTestsRemainException if the receiver removes all tests
		 */
		public function apply( child:Object ):void {
			if (!(child is IFilterable ))
				return;
			
			var filterable:IFilterable = IFilterable( child );
			filterable.filter(this);
		}
	
		//TODO: Not sure if this comment should have gone here or where ALL is created and calls this
		/**
		 * A null <code>Filter</code> that passes all tests through.
		 */
		private static function buildAllFilter():Filter {
			return new Filter(			
				function( description:IDescription ):Boolean { return true; },
				function():String { return "all tests"; } );
		}
		
		public function Filter( shouldRun:Function=null, describe:Function=null ) {
			this.shouldRun = shouldRun;
			this.describe = describe;
		}
	}
}

