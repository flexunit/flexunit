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
package org.flexunit.internals.runners.statements {
	import flash.utils.*;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.model.MultipleFailureException;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;

	public class ExpectException extends AsyncStatementBase implements IAsyncStatement {
		private var exceptionName:String;
		private var exceptionClass:Class;
		private var statement:IAsyncStatement;
		private var receivedError:Boolean = false;

		public function ExpectException( exceptionName:String, statement:IAsyncStatement ) {
			this.exceptionName = exceptionName;
			this.statement = statement;
			
			exceptionClass = getDefinitionByName( exceptionName ) as Class;
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
		}
		
		public static function hasExpected( method:FrameworkMethod ):String {
			var expected:String = method.getSpecificMetaDataArg( "Test", "expected" );
			var hasExpected:Boolean = expected && ( expected.length>0 );
			 
			return hasExpected?expected:null;			
		}
		
		private function validErrorType( e:Error ):Boolean {
			return ( e is exceptionClass );
		}
		
		private function createInvalidError( e:Error ):Error {
			var message:String = "Unexpected exception, expected<"
						+ exceptionName + "> but was<"
						+ getQualifiedClassName( e ) + ">";			
			
			return new Error( message );
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
 			this.parentToken = parentToken; 			

			try {
				statement.evaluate( myToken );
			} catch ( e:Error ) {
				receivedError = true;
				if ( validErrorType( e ) ) {
					//all is well
					handleNextExecuteComplete( new ChildResult( myToken ) );
				} else {
					handleNextExecuteComplete( new ChildResult( myToken, createInvalidError( e ) ) );								
				}
			}
		}

		public function handleNextExecuteComplete( result:ChildResult ):void {
			var errorToSendBack:Error;
			
			if ( result && result.error ) {
				receivedError = true;
				if ( validErrorType( result.error ) ) {
					//all is well
					errorToSendBack = null;
				} else {
					errorToSendBack = createInvalidError( result.error );								
				}				
			}

			if (!receivedError) {				
				//We have a problem, we didn't get an error. In this case, that's an issue
				var localError:Error = new AssertionError("Expected exception: "	+ exceptionName );
				if ( result.error ) {
					if ( result.error is MultipleFailureException ) {
						errorToSendBack = MultipleFailureException( result.error ).addFailure( localError );
					} else {
						errorToSendBack = new MultipleFailureException( [result.error, localError] );
					} 
				}
				
				if ( !errorToSendBack ) {
					errorToSendBack = localError;
				} 
			}
			
			sendComplete( errorToSendBack );
		}
	}
}