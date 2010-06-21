package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules.ordered
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRuleOrder;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.MethodRuleBase;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	public class RuleNoOrder extends MethodRuleBase implements IMethodRule
	{
		public var ruleOrderTest : TestRuleOrder;
		
		override public function evaluate( parentToken : AsyncTestToken ):void
		{
			if ( ruleOrderTest )
				ruleOrderTest.rulesCalledArray.push( this.toString() );
			
			super.evaluate( parentToken );
			//Tell the framework to execute the next statement moving toward the actual test execution
			proceedToNextStatement();
		}
		
		override public function apply( base : IAsyncStatement, method : FrameworkMethod, test : Object ) : IAsyncStatement
		{
			ruleOrderTest = test as TestRuleOrder;
			//You have access to the method and test if you need it
			return super.apply( base, method, test );
		}
		
		override protected function handleStatementComplete( result : ChildResult ) : void
		{
			if ( ruleOrderTest )
			{
				ruleOrderTest.rulesCalledArray.pop();
				Assert.assertEquals( ruleOrderTest.rulesCalledArray.length, 0 );
			}

			//You can also examine the results of the other statements and change if desired... for example
			//if you were expecting an exception, you could check the result and make this test now pass if the result
			//was the correct error
			super.handleStatementComplete( result );
		}
		
		override public function toString():String
		{
			return "Rule No Order Rule";
		}
	}
}