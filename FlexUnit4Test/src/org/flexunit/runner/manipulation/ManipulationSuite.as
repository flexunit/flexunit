package org.flexunit.runner.manipulation
{
	import org.flexunit.runner.manipulation.cases.FilterCase;
	import org.flexunit.runner.manipulation.cases.SorterCase;
	import org.flexunit.runner.manipulation.cases.NoTestsRemainExceptionCase;
	import org.flexunit.runner.manipulation.cases.MetadataSorterCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ManipulationSuite
	{
		public var filterCase:FilterCase;
		public var sorterCase:SorterCase;
		public var metadataSorterCase:MetadataSorterCase;
		public var notTestsRemainExceptionCase:NoTestsRemainExceptionCase;
	}
}