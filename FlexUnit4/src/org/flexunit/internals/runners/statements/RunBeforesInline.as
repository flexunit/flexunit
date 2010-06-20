package org.flexunit.internals.runners.statements {
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.IAsyncTestToken;
	import org.flexunit.utils.ClassNameUtil;

	public class RunBeforesInline extends AsyncStatementBase implements IAsyncStatement {
		private var befores:Array;
		private var target:Object;
		private var nextStatement:IAsyncStatement;
		private var runBefores:RunBefores;
		private var myTokenForSequence:AsyncTestToken;
		
		public function RunBeforesInline( befores:Array, target:Object, statement:IAsyncStatement ) {
			super();
			
			this.befores = befores;
			this.target = target;
			this.nextStatement = statement;
			
			var className:String = ClassNameUtil.getLoggerFriendlyClassName( this );

			//This is the token for the general chain of statements moving toward method invocation
			myToken = new AsyncTestToken( className );
			myToken.addNotificationMethod( handleNextStatementExecuteComplete );

			//This is the token used by the begin sequence so we know when it is complete
			myTokenForSequence = new AsyncTestToken( className );
			myTokenForSequence.addNotificationMethod( handleSequenceExecuteComplete );
			
			runBefores = new RunBefores( befores, target );
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
			runBefores.evaluate( myTokenForSequence );
		}

		public function handleSequenceExecuteComplete( result:ChildResult ):void {
			
			if ( result && result.error ) {
				//we have an error during the execution of the Before,
				//we need to abort
				sendComplete( new Error( "Failure in Before: " + result.error.message ) )
			} else {			
				nextStatement.evaluate( myToken );
			}
		}
		
		public function handleNextStatementExecuteComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
	}
}