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
 * @author     Michael Labriola <labriola@digitalprimates.net>
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

	public class TheoryBlockRunnerStatement extends AsyncStatementBase implements IAsyncStatement {
		use namespace classInternal;
	
		private var statement:IAsyncStatement;
		private var anchor:TheoryAnchor;
		private var complete:Assignments;
	
		public function TheoryBlockRunnerStatement( statement:IAsyncStatement, anchor:TheoryAnchor, complete:Assignments ) {
			this.statement = statement;
			this.anchor = anchor;
			this.complete = complete;
			
			myToken = new AsyncTestToken( "TheoryBlockRunnerStatement" );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}	
	
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
							
		public function handleChildExecuteComplete( result:ChildResult ):void {
			var assumptionError:Boolean = false;

			if ( result && result.error && result.error is AssumptionViolatedException) {
				assumptionError = true;
			}  

			if ( !assumptionError ) {
				anchor.handleDataPointSuccess();
			}

			sendComplete( result.error );
		}
	}

}