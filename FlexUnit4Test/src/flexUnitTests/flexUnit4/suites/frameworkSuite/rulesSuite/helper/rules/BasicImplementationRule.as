package flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.helper.rules
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.TestRulesBasicImplementation;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.MethodRuleBase;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	public class BasicImplementationRule extends MethodRuleBase implements IMethodRule
	{
		public var rulesTest : TestRulesBasicImplementation;
		
		override public function evaluate( parentToken : AsyncTestToken ):void
		{
			super.evaluate( parentToken );
			
			if ( rulesTest )
			{
				Assert.assertTrue( TestRulesBasicImplementation.calledByBeforeAfterClass );
				Assert.assertTrue( rulesTest.calledByRuleApply );
				Assert.assertFalse( rulesTest.calledByBefore );
				Assert.assertFalse( rulesTest.calledByTestMethod );
				Assert.assertFalse( rulesTest.calledByAfter );
				Assert.assertFalse( rulesTest.calledByRuleHandleStatementComplete );
				rulesTest.calledByRuleEvaluate = true;
			}
			
			//Tell the framework to execute the next statement moving toward the actual test execution
			proceedToNextStatement();
		}
		
		override public function apply( base : IAsyncStatement, method : FrameworkMethod, test : Object ) : IAsyncStatement
		{
			rulesTest = test as TestRulesBasicImplementation;
			
			if ( rulesTest )
			{
				Assert.assertTrue( TestRulesBasicImplementation.calledByBeforeAfterClass );
				Assert.assertFalse( rulesTest.calledByRuleEvaluate );
				Assert.assertFalse( rulesTest.calledByBefore );
				Assert.assertFalse( rulesTest.calledByTestMethod );
				Assert.assertFalse( rulesTest.calledByAfter );
				Assert.assertFalse( rulesTest.calledByRuleHandleStatementComplete );
				rulesTest.calledByRuleApply = true;
			}
				
			//You have access to the method and test if you need it
			return super.apply( base, method, test );
		}
		
		override protected function handleStatementComplete( result : ChildResult ) : void
		{
			//You can also examine the results of the other statements and change if desired... for example
			//if you were expecting an exception, you could check the result and make this test now pass if the result
			//was the correct error
			
			if ( rulesTest )
			{
				Assert.assertTrue( TestRulesBasicImplementation.calledByBeforeAfterClass );
				Assert.assertTrue( rulesTest.calledByRuleApply );
				Assert.assertTrue( rulesTest.calledByRuleEvaluate );
				Assert.assertTrue( rulesTest.calledByBefore );
				Assert.assertTrue( rulesTest.calledByTestMethod );
				Assert.assertTrue( rulesTest.calledByAfter );
				rulesTest.calledByRuleHandleStatementComplete = true;
			}
			
			super.handleStatementComplete( result );
		}
		
		override public function toString():String
		{
			return "Basic Implementation Rule";
		}
		
		public function BasicImplementationRule()
		{
			super();
		}
	}
}