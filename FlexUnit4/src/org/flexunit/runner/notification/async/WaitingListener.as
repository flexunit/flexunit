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
 * @author     Jeff Tapper 
 * @version    
 **/ 
/**
 * notes
 * 
 * currently, im printing all successes, then all failures, then all ignores.
 * may make more sense to return them in order.  
 * since we need to return the total number of tests in the first result, but we can't know that until
 * all the tests are complete, we probably need to keep an array of all the results in order as they come back, 
 * and when the tests are done, loop over the array and send the messages. 
 * 
 * */

package org.flexunit.runner.notification.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;

	/**
	 * This class is simply to test async startup listeners
	 */
	public class WaitingListener extends EventDispatcher implements IAsyncStartupRunListener
	{
		/**
		 * @private
		 */
		private var _ready:Boolean = false;
		
		/**
		 * @private
		 */
		private var msgQueue:Array = new Array();

		/**
		 * Constructor.
		 */
		public function WaitingListener() {
			var timer:Timer = new Timer( 5000, 1 );
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true );
			timer.start();
		}

		/*
		 * Internal methods
		 */

		private function handleTimerComplete(event:Event):void{
			_ready = true;
			dispatchEvent( new Event( AsyncListenerWatcher.LISTENER_READY ) );
			//dispatchEvent( event );
			
		}
		
		/**
		 * Returns a Boolean value indicating whether the listener is ready
		 */
		[Bindable(event="listenerReady")]
		public function get ready():Boolean {
			return _ready;
		}
		
		public function testRunStarted( description:IDescription ):void{
			
		}

		public function testRunFinished( result:Result ):void {

		}

		public function testStarted( description:IDescription ):void {
			
		}
		
		public function testFinished( description:IDescription ):void {
		}

		public function testAssumptionFailure( failure:Failure ):void {
			
		}

		public function testIgnored( description:IDescription ):void {
		}
	
	
		public function testFailure( failure:Failure ):void {
		}
	}
}