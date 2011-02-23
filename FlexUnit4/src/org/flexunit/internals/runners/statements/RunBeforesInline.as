/**
 * Copyright (c) 2010 Digital Primates
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
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