package org.flexunit.runners.cases.stub {
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.MethodRuleBase;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	public class SynchronousRule extends MethodRuleBase implements IMethodRule {
		override public function evaluate( parentToken:AsyncTestToken ):void {
			super.evaluate( parentToken );
			
			//Do something synchronous if you wanted to

			//Tell the framework to execute the next statement moving toward the actual test execution
			proceedToNextStatement();
		}
		
		override public function apply(base:IAsyncStatement, method:FrameworkMethod, test:Object):IAsyncStatement {
			//You have access to the method and test if you need it
			return super.apply( base, method, test );
		}
		
		override protected function handleStatementComplete( result:ChildResult ):void {
			//You can also examine the results of the other statements and change if desired... for example
			//if you were expecting an exception, you could check the result and make this test now pass if the result
			//was the correct error
			super.handleStatementComplete( result );
		}
		
		override public function toString():String {
			//Please override the toString() or debugging is... rough
			return "Synchronous Rule";
		}		
	}
}