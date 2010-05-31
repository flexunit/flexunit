package org.flexunit.runners.cases.stub {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.MethodRuleBase;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	public class AsynchronousRule extends MethodRuleBase implements IMethodRule {
		private var timer:Timer;
		
		public function AsynchronousRule( delay:int ) {
			//this is an async version, note it takes a parameter
			timer = new Timer( delay, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, timerComplete );
		}
		
		private function timerComplete( event:TimerEvent ):void {
			//Tell the framework to execute the next statement moving toward the actual test execution
			proceedToNextStatement();
		}

		override public function evaluate( parentToken:AsyncTestToken ):void {
			super.evaluate( parentToken );
			
			//Start an async operation
			timer.start();
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
			return "Asynchronous Rule";
		}		
	}
}