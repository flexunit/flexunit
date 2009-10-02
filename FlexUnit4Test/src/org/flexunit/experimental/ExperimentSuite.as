package org.flexunit.experimental
{
	import org.flexunit.experimental.results.ExperimentalResultsSuite;
	import org.flexunit.experimental.runners.ExperimentalRunnersSuite;;
	import org.flexunit.experimental.theories.ExperimentalTheoriesSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentSuite
	{
		public var experimentalRunnersSuite:ExperimentalRunnersSuite;
		public var experimentalTheoriesSuite:ExperimentalTheoriesSuite;
		
		//Not yet implemented
		public var expirementalResultsSuite : ExperimentalResultsSuite;
	}
}