package org.flexunit.experimental.theories.internals
{
	import org.flexunit.experimental.theories.internals.cases.AssignmentsCase;
	import org.flexunit.experimental.theories.internals.cases.ParameterizedAssertionErrorCase;
	import org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueExceptionCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalTheoriesInteralsSuite
	{
		public var assignmentsCase:AssignmentsCase;
		public var couldNotGenerateValueExceptionCase:CouldNotGenerateValueExceptionCase;
		public var parameterizedAssertionErrorCase:ParameterizedAssertionErrorCase;
	}
}