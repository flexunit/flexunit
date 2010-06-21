package org.flexunit.internals.runners.statements {
	import org.flexunit.internals.runners.model.MultipleFailureException;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.token.IAsyncTestToken;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * Runs the [After] methods of a test in the BlockFlexUnit4ClassRunner inline after
	 * the actual test has executed.
	 *  
	 * @author mlabriola
	 * 
	 */
	public class RunAftersInline extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private 
		 */
		private var afters:Array;
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
		private var runAfters:RunAfters;
		/**
		 * @private 
		 */
		private var myTokenForSequence:AsyncTestToken;
		/**
		 * @private 
		 */
		private var executionError:Error;
		
		/**
		 * Constructor 
		 *  
		 * @param afters an array of FrameworkMethod instances marked with After metadata
		 * @param target the actual test case
		 * @param statement the statement wrapped by this class
		 * 
		 */
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
		
		/**
		 * Called to do any work or setup prior to the actual test run 
		 * @param parentToken
		 * 
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
			
			nextStatement.evaluate( myToken );
		}
		
		/**
		 * Called when the all statements between the test execution and this statement have
		 * completed. This launches the execution of any methods marked with [After]
		 *  
		 * @param result the result of the test execution and subsequent statements 
		 * 
		 */		
		public function handleNextStatementExecuteComplete( result:ChildResult ):void {
			executionError = result.error;
			runAfters.evaluate( myTokenForSequence );			
		}

		/**
		 * Called once all methods marked [After] have been executed.
		 * 
		 * @param result
		 * 
		 */		
		public function handleSequenceExecuteComplete( result:ChildResult ):void {
			var error:Error;
			
			if ( result.error || executionError ) {
				if ( result.error && executionError ) {
					error = new MultipleFailureException( [ executionError, result.error ] );
				} else if ( executionError ) {
					error = executionError;
				} else if ( result.error ) {
					error = result.error;
				}
			}
			
			sendComplete( error );
		}
	}
}