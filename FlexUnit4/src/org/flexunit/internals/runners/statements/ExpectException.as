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
package org.flexunit.internals.runners.statements {
	import flash.utils.*;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.runners.model.MultipleFailureException;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * Responsible for determing whether a specific test method is expecting a certain exception
	 */
	public class ExpectException extends AsyncStatementBase implements IAsyncStatement {
		private var exceptionName:String;
		private var exceptionClass:Class;
		private var statement:IAsyncStatement;
		private var receivedError:Boolean = false;
		
		/**
		 * Constructor.
		 * 
		 * @param exceptionName The qualified class name fo the exception to expect
		 * @param statement The current object that implements <code>IAsyncStatement</code> to decorate
		 */
		public function ExpectException( exceptionName:String, statement:IAsyncStatement ) {
			this.exceptionName = exceptionName;
			this.statement = statement;
			
			//Get the excpetion class
			exceptionClass = getDefinitionByName( exceptionName ) as Class;
			
			//Create a new token that will track when a potentially thrown exception has been thrown
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
		}
		
		/**
		 * Determine if a <code>FrameworkMethod</code> test is expecting an exception by checking its metadata to see if
		 * it contains either an "expects" or "expected" String
		 * 
		 * @param method The <code>FrameworkMethod</code> to check to see if its expecting an exception
		 * 
		 * @return a String containing the qualified path name of the expected exception
		 */
		public static function hasExpected( method:FrameworkMethod ):String {
			//There is conflicting docs in the JUnit world about expects versus expected being the right metadata for this
			//particular case, so we are going to support them both
			var expected:String = method.getSpecificMetaDataArg( "Test", "expects" );
			var hasExpected:Boolean = expected && ( expected.length>0 );

			if ( !hasExpected ) {
				//check for the tag expected too, as it is documented both ways
				expected = method.getSpecificMetaDataArg( "Test", "expected" );
				hasExpected = expected && ( expected.length>0 );
			} 
			return hasExpected?expected:null;			
		}
		
		/**
		 * Returns a boolean value indicating whether the provided error was expected
		 * 
		 * @param The error to evaluate
		 */
		private function validErrorType( e:Error ):Boolean {
			return ( e is exceptionClass );
		}
		
		/**
		 * Generates a new error indicating the expected error was not thrown
		 * 
		 * @param The error that was thrown
		 */
		private function createInvalidError( e:Error ):Error {
			var message:String = "Unexpected exception, expected<"
						+ exceptionName + "> but was<"
						+ getQualifiedClassName( e ) + ">";			
			
			return new Error( message );
		}
		
		/**
		 * Evaluates the object that implements the <code>IAsyncStatement</code> and checks to see if an exception is thrown
		 * 
		 * @param parentToken The token to be notified when the check for an exception being thrown has finished
		 */
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
					//another error we were not expected was encountered
					handleNextExecuteComplete( new ChildResult( myToken, createInvalidError( e ) ) );								
				}
			}
		}
		
		/**
		 * Determines if the excpetion in the <code>ChildResult</code> is the expected value.  If not, one is created because
		 * an excpetion should have been thrown in this instance.
		 * 
		 * @param result The <code>ChildResult</code> to check to see if there is an error
		 */
		public function handleNextExecuteComplete( result:ChildResult ):void {
			var errorToSendBack:Error;
			
			//Determine if an error was received in the child result
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