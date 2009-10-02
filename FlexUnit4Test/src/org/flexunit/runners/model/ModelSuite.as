package org.flexunit.runners.model
{
	import org.flexunit.runners.model.cases.TestClassCase;
	import org.flexunit.runners.model.cases.FrameworkMethodCase;
	import org.flexunit.runners.model.cases.RunnerBuilderBaseCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ModelSuite
	{
		public var frameworkMethodCase:FrameworkMethodCase;
		public var runnerBuilderBaseCase:RunnerBuilderBaseCase;
		public var testClassCase:TestClassCase;
	}
}