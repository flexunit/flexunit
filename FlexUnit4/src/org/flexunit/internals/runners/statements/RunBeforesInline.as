package org.flexunit.internals.runners.statements {
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.IAsyncTestToken;
	import org.flexunit.utils.ClassNameUtil;

	/**
	 * Runs the [Before] methods of a test in the BlockFlexUnit4ClassRunner inline before
	 * procceding to the actual test.
	 *  
	 * @author mlabriola
	 * 
	 */
	public class RunBeforesInline extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private 
		 */
		private var befores:Array;
		/**
		 * @private 
		 */
		private var target:Object;
		/**
		 * @private 
		 */
		private var nextStatement:IAsyncStatement;
		/**
		 * @private 
		 */
		private var runBefores:RunBefores;
		/**
		 * @private 
		 */
		private var myTokenForSequence:AsyncTestToken;
		
		/**
		 * Constructor  
		 * @param befores Array of FrameworkMethod instances with Before metadata
		 * @param target The test class 
		 * @param statement the statement being wrapped by this class
		 * 
		 */
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

		/**
		 * Begins execution of the Before methods
		 * @param parentToken
		 * 
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
			runBefores.evaluate( myTokenForSequence );
		}

		/**
		 * Called when all Before methods have been run 
		 * @param result
		 * 
		 */		
		public function handleSequenceExecuteComplete( result:ChildResult ):void {
			
			if ( result && result.error ) {
				//we have an error during the execution of the Before,
				//we need to abort
				sendComplete( result.error )
			} else {			
				nextStatement.evaluate( myToken );
			}
		}
		
		/**
		 * Called to provide this class an opportunity to inspect or change the result
		 * of the test run before allowing control to continue passing up the wrapped 
		 * statements.
		 * 
		 * @param result
		 * 
		 */		
		public function handleNextStatementExecuteComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
	}
}