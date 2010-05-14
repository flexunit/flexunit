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
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.core.Application;
	
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	
	/**
	 * The <code>StackAndFrameManagement</code> decorator implements green threading to deal with flash 
	 * frames. This class allows us to break execution across frames and ensure a stack overflow does not 
	 * occur. It does this by starting a timer when it is asked to evaluate itself. When the timer fires, 
	 * which will be the following frame, execution will resume.<br/>
	 * 
	 * Each time we get to the beginning of a new test, we calculate the elapsed time versus the framerate.
	 * If we get to the point where we have used mroe than about 80% of a given frame, we then defer until the
	 * next one. This prevents the player from being locked into a single frame for the entire duration of the 
	 * tests preventing it from communicating with external servers, updating the UI and potentially timing out 
	 * after 15 seconds.
	 **/
	public class StackAndFrameManagement implements IAsyncStatement {
		/**
		 * @private
		 */
		protected var parentToken:AsyncTestToken;
		/**
		 * @private
		 */
		protected var myToken:AsyncTestToken;
		/**
		 * @private
		 */
		protected var timer:Timer;
		/**
		 * @private
		 */
		protected var statement:IAsyncStatement;
		
		/**
		 * @private
		 */
		private static var greenThreadStartTime:Number = 0; //this can eventually be computed
		/**
		 * @private
		 */
  		private static var frameLength:Number = 40; //given standard frame rates for flex a frame passes every 42 or so milliseconds, so we are going to try to use about 38 of those
  		
		/**
		 * Constructor.
		 * 
		 * @param statement The current object that implements the <code>IAsyncStatement</code> to decorate.
		 */
		public function StackAndFrameManagement( statement:IAsyncStatement ) {
			super();
			
			this.statement = statement;
			
/*			//Determine if the greenThreadStartTime has been obtained
			if ( !greenThreadStartTime ) {
				//if this is the very first time we have gotten here, we should automatically bounce to a new frame
				//as the framework has just spent a lot of time coutning tests and building runners.... it is way
				//over time presently. We accomplish this
				greenThreadStartTime = 0;
			}*/
			
			//Create a new token that will track the progress of frame management
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
		}
		
		/**
		 * Determines if there is time in the frame to start running the <code>IAsyncStatement</code>.  If there is still time,
		 * the <code>IAsyncStatement</code> will be evaluated; otherwise, a timer will be started that will wait until the
		 * next frame before the <code>IAsyncStatement</code> is evaluated.
		 * 
		 * @param previousToken The token to be notified when that <code>IAsyncStatement</code> has finished executing.
		 */
		public function evaluate( previousToken:AsyncTestToken ):void {
			parentToken = previousToken;
			
			var now:Number = getTimer();
			
			//this algorithm is still imperfect. Right now, it waits an extra frame after async tests because they always effectively
			//took more than a frame, so we need to make this a bit better. Eventually we may need a component that actaully watches
			//the frames directly to make better choices
			if ( ( now - greenThreadStartTime ) > frameLength ) {
				//If we have been going for more than 80% of the framelength, it is time to give
				//the player a chance to catch up 
				//This timer must *NOT* have a weak reference. Sometimes things run fast enough
				//that this class will be eligible for garbage collection in between the frames
				//which causes the tests to cease, keeping this strong prevents collection until
				//we are ready
				timer = new Timer( 5, 1 );
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, false );
				timer.start();
				greenThreadStartTime = now;
				//trace("restart");
			} else {
				//trace("continue");
				statement.evaluate( myToken );	
			}
		}
		
		/**
		 * Evaluates the <code>IAsyncStatement</code> after the timer has waited and the player is
		 * now in the next frame.
		 * 
		 * @param event
		 */
		protected function handleTimerComplete( event:TimerEvent ):void {
			timer.removeEventListener( TimerEvent.TIMER_COMPLETE, handleTimerComplete, false );
			statement.evaluate( myToken );
		}
		
		/**
		 * Report any errors the <code>ChildResult</code> has encountered to the parentToken, notifying
		 * the parentToken that we are done.
		 * 
		 * @param result The <code>ChildResult</code> to check to see if there is an error.
		 */
		public function handleNextExecuteComplete( result:ChildResult ):void {
			parentToken.sendResult( result.error );
		}

		/**
		 * @private 
		 * @return
		 */
		public function toString():String {
			return "Stack Management Base";
		}
	}
}
