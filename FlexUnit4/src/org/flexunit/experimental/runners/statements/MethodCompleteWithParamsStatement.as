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
package org.flexunit.experimental.runners.statements {
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	
	use namespace classInternal;
	
	/**
	 * The <code>MethodCompleteWithParamsStaetement</code> is responsible for executing a theory method with a single 
	 * set of parameters.
	 */
	public class MethodCompleteWithParamsStatement extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private
		 */
		private var frameworkMethod:FrameworkMethod;
		/**
		 * @private
		 */
		private var anchor:TheoryAnchor;
		/**
		 * @private
		 */
		private var complete:Assignments;
		/**
		 * @private
		 */
		private var freshInstance:Object;
		
		/**
		 * Constructor.
		 * 
		 * @param frameworkMethod The current theory that is being tested.
		 * @param anchor The anchor for the current theory that is being tested.
		 * @param complete Contains values that can be applied to the theory method.
		 * @param freshInstance An instance of the current test class.
		 */
		public function MethodCompleteWithParamsStatement( frameworkMethod:FrameworkMethod, anchor:TheoryAnchor, complete:Assignments, freshInstance:Object ) {
			this.frameworkMethod = frameworkMethod;
			this.complete = complete;
			this.freshInstance = freshInstance;
			this.anchor = anchor;
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( "MethodCompleteWithParamsStatement" );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}	
		
		/**
		 * Executes the current theory method with the provided values from the complete <code>Assignments</code>.
		 * 
		 * @param parentToken The token to be notified when the theory method has finished running.
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;	
	
	 		try {
				var values:Object = complete.getMethodArguments( anchor.nullsOk() );
				frameworkMethod.applyExplosivelyAsync( myToken, freshInstance, values as Array );
			} catch ( e:CouldNotGenerateValueException ) {
				sendComplete( null );	
			} catch ( e:AssumptionViolatedException ) {
				anchor.handleAssumptionViolation( e );
				sendComplete( e );	
			} catch ( e:Error ) {
				//trace( e.getStackTrace() );
				//TODO: Trace from this point forward to determine why stack overflow is happening in ParameterizedAssertionError
				var newError:Error = anchor.reportParameterizedError(e, complete.getArgumentStrings(anchor.nullsOk()));
				sendComplete( newError );			
			}
	 	}
		
		/**
		 * Tells the parent token that the method has finished running and provides it with any encountered errors.
		 * 
		 * @param result A <code>ChildResult</code> that contains potential errors encountered during execution.
		 */
		public function handleChildExecuteComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
		
		/**
		 * Returns a string that includes the name of the method, the assigned parameters, and the 
		 * new instance of the current test class.
		 */
		override public function toString():String {
			var statementString:String = "MethodCompleteWithParamsStatement :\n";
	
			statementString += "          Method : "+frameworkMethod.method.name + "\n";		
			statementString += "          Complete :\n"+complete + "\n";		
			statementString += "          Instance : "+freshInstance;		
			
			return statementString;
		}
		
	}
}