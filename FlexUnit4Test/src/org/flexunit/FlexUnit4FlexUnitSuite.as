package org.flexunit
{
	import org.flexunit.asserts.cases.assertEqualsCase;
	import org.flexunit.asserts.cases.assertFalseCase;
	import org.flexunit.asserts.cases.assertNotNullCase;
	import org.flexunit.asserts.cases.assertNullCase;
	import org.flexunit.asserts.cases.assertStrictlyEqualsCase;
	import org.flexunit.asserts.cases.assertTrueCase;
	import org.flexunit.asserts.cases.failCase;
	import org.flexunit.async.AsyncSuite;
	import org.flexunit.cases.AssertCase;
	import org.flexunit.cases.AssertThatCase;
	import org.flexunit.cases.AssertionErrorCase;
	import org.flexunit.cases.AssumeCase;
	import org.flexunit.cases.AssumeThatCase;
	import org.flexunit.cases.ComparisonFailureCase;
	import org.flexunit.cases.IncludeFlexClassesCase;
	import org.flexunit.events.EventsSuite;
	import org.flexunit.experimental.ExperimentSuite;
	import org.flexunit.internals.InternalsSuite;
	import org.flexunit.reporting.ReportingSuite;
	import org.flexunit.runner.RunnerSuite;
	import org.flexunit.runners.RunnersSuite;
	import org.flexunit.token.TokenSuite;
	import org.flexunit.utils.UtilsSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnit4FlexUnitSuite
	{
		//Suites
		public var asyncSuite:AsyncSuite;
		public var eventsSuite:EventsSuite;
		public var experimentalSuite:ExperimentSuite;
		public var internalSuite:InternalsSuite;
		public var reportingSuite:ReportingSuite;
		public var runnerSuite:RunnerSuite;
		public var runnersSuite:RunnersSuite;
		public var tokenSuite:TokenSuite;
		public var utilsSuite:UtilsSuite;
		
		//Cases
		public var assertCase:AssertCase;
		public var assertionErrorCase:AssertionErrorCase;
		public var assertThatCase:AssertThatCase;
		public var assumeCase:AssumeCase;
		public var assumeThatCase:AssumeThatCase;
		public var includeFlexClassesCase : IncludeFlexClassesCase;
		
		//Assert Alias Cases
		public var assertEqualsAliasCase:assertEqualsCase;
		public var assertFalseAliasCase:assertFalseCase;
		public var assertNotNullAliasCase:assertNotNullCase;
		public var assertNullAliasCase:assertNullCase;
		public var assertStrictlyEqualsAliasCase:assertStrictlyEqualsCase;
		public var assertTrueAliasCase:assertTrueCase;
		public var failAliasCase:failCase;
		
		//Cases not yet implemented
		public var comparisonFailureCase:ComparisonFailureCase;
	}
}