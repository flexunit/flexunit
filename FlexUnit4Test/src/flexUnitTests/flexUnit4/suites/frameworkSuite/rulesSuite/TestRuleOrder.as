package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ordered.RuleFifty;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ordered.RuleNoOrder;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ordered.RuleOne;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ordered.RuleTwo;
	
	import flexunit.framework.Assert;

	public class TestRuleOrder
	{
		public var rulesCalledArray : Array = new Array();
		
		[Rule(order="1")]
		public var ruleOne : RuleOne = new RuleOne();
		
		[Rule(order="2")]
		public var ruleTwo : RuleTwo = new RuleTwo();
		
		[Rule(order="50")]
		public var ruleFifty : RuleFifty = new RuleFifty();
		
		[Rule]
		public var ruleNoOrder : RuleNoOrder = new RuleNoOrder();
		
		[Test]
		public function rule_OrderRight() : void
		{
			Assert.assertEquals( rulesCalledArray[ 0 ], ruleNoOrder.toString() );
			Assert.assertEquals( rulesCalledArray[ 1 ], ruleOne.toString() );
			Assert.assertEquals( rulesCalledArray[ 2 ], ruleTwo.toString() );
			Assert.assertEquals( rulesCalledArray[ 3 ], ruleFifty.toString() );
		}
	}
}