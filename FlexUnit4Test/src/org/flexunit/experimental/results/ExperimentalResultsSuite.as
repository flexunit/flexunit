package org.flexunit.experimental.results
{
	import org.flexunit.experimental.results.cases.FailureListCase;
	import org.flexunit.experimental.results.cases.PrintableResultCase;
	import org.flexunit.experimental.results.cases.ResultMatchersCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalResultsSuite
	{
		public var failureList:FailureListCase;
		public var printableResult:PrintableResultCase;
		public var resultMatcher:ResultMatchersCase;
	}
}
