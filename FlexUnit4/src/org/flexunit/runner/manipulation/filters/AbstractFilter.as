package org.flexunit.runner.manipulation.filters {
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.manipulation.IFilter;
	import org.flexunit.runner.manipulation.IFilterable;
	
	public class AbstractFilter implements IFilter {
		/**
		 * @param description the description of the test to be run
		 * @return <code>true</code> if the test should be run
		 */		
		public function shouldRun(description:IDescription):Boolean {
			return false;
		}
		
		/**
		 * Returns a textual description of this Filter
		 * @return a textual description of this Filter
		 */
		public function describe(description:IDescription):String {
			return null;
		}
		
		/**
		 * Invoke with a <code> org.flexunit.runner.IRunner</code> to cause all tests it intends to run
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
		
		public function AbstractFilter() {
		}
		
	}
}