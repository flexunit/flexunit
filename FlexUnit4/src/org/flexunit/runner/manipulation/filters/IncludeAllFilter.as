package org.flexunit.runner.manipulation.filters
{
	import org.flexunit.runner.IDescription;

	public class IncludeAllFilter extends AbstractFilter {
		override public function shouldRun(description:IDescription) : Boolean {
			return true;
		}
		
		override public function describe(description:IDescription) : String {
			return "all tests";
		}

		public function IncludeAllFilter() {
			super();
		}
	}
}