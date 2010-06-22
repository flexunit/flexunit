package org.flexunit.runner.manipulation.filters
{
	import org.flexunit.runner.IDescription;

	/**
	 * Implementation of a filter that includes all children 
	 * @author mlabriola
	 * 
	 */
	public class IncludeAllFilter extends AbstractFilter {
		/**
		 * @inheritDoc
		 * 
		 */
		override public function shouldRun(description:IDescription) : Boolean {
			return true;
		}
		
		/**
		 * @inheritDoc
		 * 
		 */
		override public function describe(description:IDescription) : String {
			return "all tests";
		}

		/**
		 * Constructor 
		 * 
		 */
		public function IncludeAllFilter() {
			super();
		}
	}
}