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

	public class MethodCompleteWithParamsStatement extends AsyncStatementBase implements IAsyncStatement {
		private var frameworkMethod:FrameworkMethod;
		private var anchor:TheoryAnchor;
		private var complete:Assignments;
		private var freshInstance:Object;
		
		public function MethodCompleteWithParamsStatement( frameworkMethod:FrameworkMethod, anchor:TheoryAnchor, complete:Assignments, freshInstance:Object ) {
			this.frameworkMethod = frameworkMethod;
			this.complete = complete;
			this.freshInstance = freshInstance;
			this.anchor = anchor;
			
			myToken = new AsyncTestToken( "MethodCompleteWithParamsStatement" );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}	
	
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
				var newError:Error = anchor.reportParameterizedError(e, complete.getArgumentStrings(anchor.nullsOk()));
				sendComplete( newError );			
			}
	 	}
		
		public function handleChildExecuteComplete( result:ChildResult ):void {
			sendComplete( result.error );
		}
		
		override public function toString():String {
			var statementString:String = "MethodCompleteWithParamsStatement :\n";
	
			statementString += "          Method : "+frameworkMethod.method.name + "\n";		
			statementString += "          Complete :\n"+complete + "\n";		
			statementString += "          Instance : "+freshInstance;		
			
			return statementString;
		}
		
	}
}