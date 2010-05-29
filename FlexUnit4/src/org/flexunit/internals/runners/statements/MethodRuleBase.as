package org.flexunit.internals.runners.statements {
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;

	public class MethodRuleBase extends AsyncStatementBase implements IAsyncStatement {
		protected var baseStatement:IAsyncStatement;

		public function apply(base:IAsyncStatement, method:FrameworkMethod, test:Object):IAsyncStatement {
			this.baseStatement = base;
			return this;
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
			//Store parent token
			this.parentToken = parentToken;
		}
		
		protected function proceedToNextStatement():void {
			baseStatement.evaluate( myToken );
		}
		
		protected function handleStatementComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
		
		override public function toString():String {
			return "Rule1";
		}	

		public function MethodRuleBase() {
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleStatementComplete );
		}
	}
}