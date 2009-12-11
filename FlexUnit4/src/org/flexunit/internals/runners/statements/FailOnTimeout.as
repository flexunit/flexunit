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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * The <code>FailOnTimeout</code> is a decorator that is responsible for determing 
	 * whether a specific test method has exceeded a timeout period for execution.  A test
	 * method normally will run to completion regardless of how long it takes the test to
	 * execute; however, if a timeout is imposed on the test method, the test will
	 * fail if the test does not finish within the time limit.<br/>
	 * 
	 * In order to fail on a timeout, a test method must include metadata indicating it has
	 * a timeout time limit.  The timeout time limit is expected to be provided in milliseconds.<br/>
	 * 
	 * <pre><code>
	 * [Test(timeout=100)]
	 * public function timeoutTest():void {
	 * 	//Test to run
	 * }
	 * </code></pre>
	 */
	public class FailOnTimeout extends AsyncStatementBase implements IAsyncStatement {
		/**
		 * @private
		 */
		private var timeout:Number = 0;
		/**
		 * @private
		 */
		private var statement:IAsyncStatement;
		/**
		 * @private
		 */
		private var timer:Timer;
		/**
		 * @private
		 */
		private var timerComplete:Boolean = false;
		/**
		 * @private
		 */
		private var returnMessageSent:Boolean = false;
		
		/**
		 * Constructor.
		 * 
		 * @param timeout The amount of time in milliseconds to wait before attempting to fail the test.
		 * @param statement The current object that implements <code>IAsyncStatement</code> to decorate.
		 */
		public function FailOnTimeout( timeout:Number, statement:IAsyncStatement ) {
			this.timeout = timeout;
			this.statement = statement;
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
			
			timer = new Timer( timeout, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true );
		}
		
		/**
		 * Determine if the <code>method</code> test has a timeout by checking its metadata to see if it
		 * contains a "timeout" string.
		 * 
		 * @param method The <code>FrameworkMethod</code> to check to see if it has a timeout.
		 * 
		 * @return a String indicating the length of the the timeout if the <code>method</code>
		 * contains metadata that indicates the method contains a timeout; otherwise, a value of <code>null</code>
		 * will be returned.
		 */
		public static function hasTimeout( method:FrameworkMethod ):String {
			var timeout:String = String( method.getSpecificMetaDataArgValue( "Test", "timeout" ) );
			var hasTimeout:Boolean = timeout && ( timeout != "null" ) && ( timeout.length>0 );

			return hasTimeout?timeout:null;			
		}
		
		/**
		 * Evaluates the object that implements the <code>IAsyncStatement</code> and starts the timeout timer.
		 * 
		 * @param parentToken The token to be notified when it has been determined if a timeout has occured.
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
 			this.parentToken = parentToken; 			
 			
 			timer.start();
 			statement.evaluate( myToken );
		}
		
		/**
		 * The timer has completed and the test has not finished; the test has timed out.
		 */
		private function handleTimerComplete( event:TimerEvent ):void {
			timerComplete = true;
			handleNextExecuteComplete( new ChildResult( myToken, new Error( "Test did not complete within specified timeout " + timeout + "ms" ) ) );
		}
		
		/**
		 * Stops the timer and sends any error the <code>result</code> has encountered to the parentToken.  If
		 * the timer has already finished, the parentToken has been already notified of the failure and nothing
		 * further will occur.
		 * 
		 * @param result The <code>ChildResult</code> to check to see if there is an error.
		 */
		public function handleNextExecuteComplete( result:ChildResult ):void {
			timer.stop();
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, handleTimerComplete, false );
			
			if ( returnMessageSent ) {
				//this means we have already sent an error because the timer expired, but we are now
				//getting into this method because the async call completed... just a bit too late though
				//we need to ignore the return as the testing framework has gone onto new tests and this is 
				//no longer our concern
				return;
			}

			returnMessageSent = true;
			sendComplete( result.error );	
		}
	}
}