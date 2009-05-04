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
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;

	public class FailOnTimeout extends AsyncStatementBase implements IAsyncStatement {
		private var timeout:Number = 0;
		private var statement:IAsyncStatement;
		private var timer:Timer;
		private var timerComplete:Boolean = false;
		private var returnMessageSent:Boolean = false;

		public function FailOnTimeout( timeout:Number, statement:IAsyncStatement ) {
			this.timeout = timeout;
			this.statement = statement;
			
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
			
			timer = new Timer( timeout, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true );
		}

		public static function hasTimeout( method:FrameworkMethod ):String {
			var timeout:String = String( method.getSpecificMetaDataArg( "Test", "timeout" ) );
			var hasTimeout:Boolean = timeout && ( timeout != "null" ) && ( timeout.length>0 );

			return hasTimeout?timeout:null;			
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
 			this.parentToken = parentToken; 			
 			
 			timer.start();
 			statement.evaluate( myToken );
		}

		private function handleTimerComplete( event:TimerEvent ):void {
			timerComplete = true;
			handleNextExecuteComplete( new ChildResult( myToken, new Error( "Test did not complete within specified timeout " + timeout + "ms" ) ) );
		}

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