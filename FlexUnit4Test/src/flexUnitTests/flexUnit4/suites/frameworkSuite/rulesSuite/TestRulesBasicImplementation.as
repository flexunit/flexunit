package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.BasicImplementationRule;
	
	import flexunit.framework.Assert;

	public class TestRulesBasicImplementation
	{
		public var calledByRuleApply : Boolean = false;
		public var calledByRuleEvaluate : Boolean = false;
		public var calledByTestMethod : Boolean = false;
		public var calledByRuleHandleStatementComplete : Boolean = false;
		public var calledByBefore : Boolean = false;
		public var calledByAfter : Boolean = false;
		
		[Rule]
		public var basicImplementationRule : BasicImplementationRule = new BasicImplementationRule();
		
		public static var calledByBeforeAfterClass : Boolean = false;
		
		[BeforeClass]
		public static function beforeClass() : void
		{
			calledByBeforeAfterClass = true;
		}
		
		[AfterClass]
		public static function afterClass() : void
		{
			calledByBeforeAfterClass = false;
		}
		
		[Before]
		public function before() : void
		{
			Assert.assertTrue( calledByRuleApply );
			Assert.assertTrue( calledByRuleEvaluate );
			Assert.assertFalse( calledByRuleHandleStatementComplete );
			calledByBefore = true;
		}
		
		[After]
		public function after() : void
		{
			Assert.assertTrue( calledByRuleApply );
			Assert.assertTrue( calledByRuleEvaluate );
			Assert.assertFalse( calledByRuleHandleStatementComplete );
			calledByAfter = true;
		}
		
		[Test]
		public function rule_CalledEvaluateBeforeTest() : void
		{
			calledByTestMethod = true;
			Assert.assertTrue( calledByRuleApply );
		}
		
		[Test]
		public function rule_CalledApplyBeforeTest() : void
		{
			calledByTestMethod = true;
			Assert.assertTrue( calledByRuleEvaluate );
		}
		
		[Test]
		public function test_CalledAfterApplyEvaluateBeforeStatementComplete() : void
		{
			calledByTestMethod = true;
		}
		
		[Test]
		public function rule_CalledHandleStatementCompleteAfterTest() : void
		{
			calledByTestMethod = true;
			Assert.assertFalse( calledByRuleHandleStatementComplete );
		}
	}
}