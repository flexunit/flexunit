package org.flexunit.reporting
{
	import org.flexunit.reporting.cases.FailureFormatterASCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ReportingSuite
	{
		public var ffASCase:FailureFormatterASCase;
			
		CONFIG::useFlexClasses {
			import org.flexunit.reporting.cases.FailureFormatterFlexCase;
			
			public var ffFlexCase : FailureFormatterFlexCase;
		}
	}
}