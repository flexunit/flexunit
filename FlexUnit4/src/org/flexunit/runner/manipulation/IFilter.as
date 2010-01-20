package org.flexunit.runner.manipulation {
	import org.flexunit.runner.IDescription;

	public interface IFilter {
		/**
		 * @param description the description of the test to be run
		 * @return <code>true</code> if the test should be run
		 */
		function shouldRun( description:IDescription ):Boolean;
		
		/**
		 * Returns a textual description of this Filter
		 * @return a textual description of this Filter
		 */
		function describe( description:IDescription ):String;

		/**
		 * Invoke with a <code> org.flexunit.runner.IRunner</code> to cause all tests it intends to run
		 * to first be checked with the filter. Only those that pass the filter will be run.
		 * @param child the runner to be filtered by the receiver
		 * @throws NoTestsRemainException if the receiver removes all tests
		 */
		function apply( child:Object ):void;		
	}
}