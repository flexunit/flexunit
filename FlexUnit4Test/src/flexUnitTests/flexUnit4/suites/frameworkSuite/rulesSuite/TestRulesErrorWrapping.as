package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.errors.RuleError;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ErrorWrappingRule;
	
	import flexunit.framework.Assert;

	public class TestRulesErrorWrapping
	{
		[Rule]
		public var basicImplementationRule : ErrorWrappingRule = new ErrorWrappingRule();
		
		[Test]
		public function rule_WrapsErrorsThrownInTest() : void
		{
			throw new RuleError( "This shouldn't cause a failed test." );
		}
		
		[Test]
		public function rule_WrapsFailuresInTest() : void
		{
			Assert.assertTrue( false );
		}
	}
}