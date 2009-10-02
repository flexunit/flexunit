package org.flexunit.reporting
{
	import org.flexunit.reporting.cases.FailureFormatterCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ReportingSuite
	{
		public var failureFormatterCase:FailureFormatterCase;
	}
}