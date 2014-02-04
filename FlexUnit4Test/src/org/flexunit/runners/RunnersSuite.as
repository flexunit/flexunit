package org.flexunit.runners
{
	import org.flexunit.runners.cases.BlockFlexUnit4ClassRunnerCase;
	import org.flexunit.runners.cases.ParameterizedCase;
	import org.flexunit.runners.cases.ParentRunnerCase;
	import org.flexunit.runners.cases.RunRulesCase;
	import org.flexunit.runners.cases.SuiteCase;
	import org.flexunit.runners.model.ModelSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class RunnersSuite
	{
		public var modelSuite:ModelSuite;
		
		public var blockFlexUnit4ClassRunnerCase:BlockFlexUnit4ClassRunnerCase;
		public var parentRunnerCase:ParentRunnerCase;
		public var parametizedCase:ParameterizedCase;
		public var suiteCase:SuiteCase;
		public var rulesCase:RunRulesCase;
	}
}