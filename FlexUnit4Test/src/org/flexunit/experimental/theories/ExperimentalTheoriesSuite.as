package org.flexunit.experimental.theories
{
	import org.flexunit.experimental.theories.cases.ParameterSignatureCase;
	import org.flexunit.experimental.theories.cases.PotentialAssignmentCase;
	import org.flexunit.experimental.theories.internals.ExperimentalTheoriesInteralsSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalTheoriesSuite
	{
		public var experimentalTheoriesInteralsSuite:ExperimentalTheoriesInteralsSuite;
		
		public var parameterSignatureCase:ParameterSignatureCase;
		public var potentialAssignmentCase:PotentialAssignmentCase;
		
	}
}