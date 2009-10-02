package org.flexunit.experimental.theories
{
	import org.flexunit.experimental.theories.cases.ParameterSignatureCase;
	import org.flexunit.experimental.theories.cases.ParametersSuppliedByCase;
	import org.flexunit.experimental.theories.cases.PotentialAssignmentCase;
	import org.flexunit.experimental.theories.internals.ExperimentalTheoriesInteralsSuite;
	import org.flexunit.experimental.theories.suppliers.ExperimentalTheoriesSupplierSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalTheoriesSuite
	{
		public var experimentalTheoriesInteralsSuite:ExperimentalTheoriesInteralsSuite;
		
		public var parameterSignatureCase:ParameterSignatureCase;
		public var potentialAssignmentCase:PotentialAssignmentCase;
		
		//not yet implemented
		public var parametersSuppliedByCase:ParametersSuppliedByCase;
		public var experimentalTheorySuppliersSuite : ExperimentalTheoriesSupplierSuite;
	}
}