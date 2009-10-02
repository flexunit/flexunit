package org.flexunit.experimental.theories.suppliers
{
	import org.flexunit.experimental.theories.suppliers.cases.TestedOnCase;
	import org.flexunit.experimental.theories.suppliers.cases.TestedOnSupplierCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalTheoriesSupplierSuite
	{
		public var testedOnCase : TestedOnCase;
		public var testedOnSupplierCase : TestedOnSupplierCase;
	}
}
