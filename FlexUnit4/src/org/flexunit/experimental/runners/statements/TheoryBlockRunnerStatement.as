/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
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
package org.flexunit.experimental.runners.statements
{
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	/**
	 * The <code>TheoryBlockRunnerStatement</code> is responsible for reporting whether the theory 
	 * method with specific arguments was successful.
	 */
	public class TheoryBlockRunnerStatement extends AsyncStatementBase implements IAsyncStatement {
		use namespace classInternal;
	
		/**
		 * @private
		 */
		private var statement:IAsyncStatement;
		/**
		 * @private
		 */
		private var anchor:TheoryAnchor;
		/**
		 * @private
		 */
		private var complete:Assignments;
		
		/**
		 * Constructor.
		 * 
		 * @param statement The <code>IAsyncStatement</code> to execute.
		 * @param anchor The anchor associated with the theory method.
		 * @param complete The <code>Assignments</code> associated with the current theory method test.
		 */
		public function TheoryBlockRunnerStatement( statement:IAsyncStatement, anchor:TheoryAnchor, complete:Assignments ) {
			this.statement = statement;
			this.anchor = anchor;
			this.complete = complete;
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( "TheoryBlockRunnerStatement" );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}	
		
		/**
		 * Executes the current <code>IAsyncStatement</code> that is wrapping the theory method test.
		 * 
		 * @param parentToken The token to be notified when the the current theory method test has finished all other statements.
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
	
	 		try {
	 			//trace( statement );
				statement.evaluate( myToken );				
			} catch ( e:AssumptionViolatedException ) {
				anchor.handleAssumptionViolation( e );
				sendComplete( e );	
			} catch ( e:Error ) {
				trace( e.getStackTrace() );
				anchor.reportParameterizedError(e, complete.getArgumentStrings(anchor.nullsOk()));
				//sendComplete( e );			
			}
		}
		
		/**
		 * Notifies the anchor if the statement successfully executed and the parent token of any errors that were encountered
		 * while running the theory method test.
		 * 
		 * @param result A <code>ChildResult</code> that contains potential errors encountered during the statements execution.
		 */
		public function handleChildExecuteComplete( result:ChildResult ):void {
			var assumptionError:Boolean = false;

			if ( result && result.error && result.error is AssumptionViolatedException) {
				assumptionError = true;
			}  
			
			//If no assumption errors were encountered when running the current theory method test, notify the anchor that one
			//set of data points were successful
			if ( !assumptionError ) {
				anchor.handleDataPointSuccess();
			}

			sendComplete( result.error );
		}
	}

}