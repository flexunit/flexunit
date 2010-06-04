package org.flexunit.internals.runners.statements {
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.IAsyncTestToken;
	import org.flexunit.utils.ClassNameUtil;
	
	public class RunAftersInline extends AsyncStatementBase implements IAsyncStatement {
		private var afters:Array;
		private var target:Object;
		private var nextStatement:IAsyncStatement;
		private var runAfters:RunAfters;
		private var myTokenForSequence:AsyncTestToken;
		
		public function RunAftersInline( afters:Array, target:Object, statement:IAsyncStatement ) {
			super();
			
			this.afters = afters;
			this.target = target;
			this.nextStatement = statement;
			
			var className:String = ClassNameUtil.getLoggerFriendlyClassName( this );
			
			//This is the token for the general chain of statements moving toward method invocation
			myToken = new AsyncTestToken( className );
			myToken.addNotificationMethod( handleNextStatementExecuteComplete );
			
			//This is the token used by the begin sequence so we know when it is complete
			myTokenForSequence = new AsyncTestToken( className );
			myTokenForSequence.addNotificationMethod( handleSequenceExecuteComplete );
			
			runAfters = new RunAfters( afters, target );
		}
		
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
			
			nextStatement.evaluate( myToken );
		}
		
		public function handleNextStatementExecuteComplete( result:ChildResult ):void {
			runAfters.evaluate( myTokenForSequence );			
		}

		public function handleSequenceExecuteComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
	}
}