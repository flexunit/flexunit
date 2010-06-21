package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRuleOrder;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRulesBasicImplementation;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRulesErrorWrapping;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class RulesSuite
	{
		public var test1:flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRuleOrder;
		public var test2:flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRulesBasicImplementation;
		public var test3:flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRulesErrorWrapping;
	}
}