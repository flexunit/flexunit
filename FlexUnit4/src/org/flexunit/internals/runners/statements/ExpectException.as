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
	 * The <code>ExpectException</code> is a decorator that is responsible for determing 
	 * whether a specific test method throws an expected exception.  Normally, if a test method
	 * throws an specific exception, the test will fail; however, if the test is expecting a 
	 * specific exception and that exception is thrown, the test will be a success.  If an
	 * exception is expected and is not encountered through the course of running the test, the
	 * test will be considered a failure.<br/>
	 * 
	 * In order to expect an exception, a test method must include metadata indicating it is
	 * expecting an exception.  The exception that it is expecting must be in the form of
	 * the qualified class name of the exception class.<br/>
	 * 
	 * <pre><code>
	 * [Test(expected="org.flexunit.runner.notification.StoppedByUserException")]
	 * public function exceptionTest():void {
	 * 	//Test will throw a StoppedByUserException
	 * }
	 * </code></pre>
	 */
	public class ExpectException extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private
		 */
		private var exceptionName:String;
		/**
		 * @private
		 */
		private var exceptionClass:Class;
		/**
		 * @private
		 */
		private var statement:IAsyncStatement;
		/**
		 * @private
		 */
		private var receivedError:Boolean = false;
		
		/**
		 * Constructor.
		 * 
		 * @param exceptionName The qualified class name of the exception to expect.
		 * @param statement The current object that implements <code>IAsyncStatement</code> to decorate.
		 */
		public function ExpectException( exceptionName:String, statement:IAsyncStatement ) {
			this.exceptionName = exceptionName;
			this.statement = statement;
			
			//Get the excpetion class
			exceptionClass = getDefinitionByName( exceptionName ) as Class;
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
		}
		
		/**
		 * Determine if a <code>method</code> test is expecting an exception by checking its metadata to see if
		 * it contains either an "expects" or "expected" string.
		 * 
		 * @param method The <code>FrameworkMethod</code> to check to see if its expecting an exception.
		 * 
		 * @return a String containing the qualified path name of the expected exception if the <code>method</code>
		 * contains metadata that indicates the method is expecting an exception; otherwise, a value of <code>null</code> will be returned.
		 */
		public static function hasExpected( method:FrameworkMethod ):String {
			//There is conflicting docs in the JUnit world about expects versus expected being the right metadata for this
			//particular case, so we are going to support them both
			var expected:String = method.getSpecificMetaDataArgValue( "Test", "expects" );
			var hasExpected:Boolean = expected && ( expected.length>0 );

			if ( !hasExpected ) {
				//check for the tag expected too, as it is documented both ways
				expected = method.getSpecificMetaDataArgValue( "Test", "expected" );
				hasExpected = expected && ( expected.length>0 );
			} 
			return hasExpected?expected:null;			
		}
		
		/**
		 * Returns a Boolean value indicating whether the provided error matches the error that
		 * was expected.
		 * 
		 * @param e The error to check and determine whether it is of the type that is expected.
		 */
		private function validErrorType( e:Error ):Boolean {
			return ( e is exceptionClass );
		}
		
		/**
		 * Generates a new error indicating the expected error was not thrown by the test but
		 * instead another error was encountered.
		 * 
		 * @param e The error that was thrown but was not of the expected type.
		 */
		private function createInvalidError( e:Error ):Error {
			var message:String = "Unexpected exception, expected<"
						+ exceptionName + "> but was<"
						+ getQualifiedClassName( e ) + ">";			
			
			return new Error( message );
		}
		
		/**
		 * Evaluates the object that implements the <code>IAsyncStatement</code> and checks to see if an exception is thrown
		 * by that <code>IAsyncStatement</code>.  If an exception is thrown, check to see if the error is of the expected type.
		 * 
		 * @param parentToken The token to be notified when the check for an exception being thrown has finished.
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
					//another error we were not expecting was encountered
					handleNextExecuteComplete( new ChildResult( myToken, createInvalidError( e ) ) );								
				}
			}
		}
		
		/**
		 * Determines if the excpetion in the <code>result</code> contains an exception that is of the expected type.  
		 * If the exception is not of the expected type, an error will be generated that includes the type of error that 
		 * was encountered.  If no exception was thrown, a new error will be created because an excpetion should have been 
		 * thrown in this instance.
		 * 
		 * @param result The <code>ChildResult</code> to check to see if there is an error was provided.
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