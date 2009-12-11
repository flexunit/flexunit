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
 package org.flexunit.runner.notification.async {
	import flash.events.Event;
	
	//import mx.logging.ILogger;
	
	import org.flexunit.runner.notification.IAsyncCompletionRunListener;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncListenersToken;
	
	/**
	 * The <code>AsyncListenerWatcher</code> is responsible for determing whether all
	 * <code>IAsyncStartupRunListener</code>s that it is watching are ready.  This is used
	 * in order to make sure that all potential <code>IAsyncStartupRunListener</code>s that
	 * are used in a test run are ready before the test run begins.<br/>
	 * 
	 * In order to track a <code>IAsyncStartupRunListener</code>, the listener must be watched
	 * by calling the <code>#watchListener()</code> method.  Once a listener is being watched,
	 * it will be counted as a pending listener.  Once the lister reports that it is ready or
	 * it has failed, it will be removed as a pending listener.  Once all listeners are no longer
	 * pending, the test run can begin.<br/>
	 * 
	 * In order to unwatch a listener, the <code>#unwatchListener()</code> method needs to be called,
	 * providing the method with the <code>IAsyncStartupRunListener</code> to stop watching.
	 */
	public class AsyncListenerWatcher {
		public static const LISTENER_READY:String = "listenerReady";
		public static const LISTENER_FAILED:String = "listenerFailed";
		public static const LISTENER_COMPLETE:String = "listenerComplete";

		//public static const ALL_LISTENERS_READY:String = "allListenersReady";
		/**
		 * @private
		 */
		private var _pendingStartupCount:int;
		/**
		 * @private
		 */
		private var _totalStartUpCount:int;
		/**
		 * @private
		 */
		private var notifier:IRunNotifier;
		//private var logger:ILogger;
		/**
		 * @private
		 */
		private var _startToken:AsyncListenersToken;
		/**
		 * @private
		 */
		private var _completeToken:AsyncListenersToken;
		
		/**
		 * Returns the start up <code>AsyncListenersToken</code>
		 */
		public function get startUpToken():AsyncListenersToken {
			return _startToken;
		}
		
		/**
		 * Returns the complete <code>AsyncListenersToken</code>
		 */
		public function get completeToken():AsyncListenersToken {
			return _completeToken;
		}
		
		/**
		 * Returns a Boolean value indicating whether all listeners are ready
		 */
		public function get allListenersReady():Boolean {
			return (pendingCount==0);
		}
		
		/**
		 * Returns a Boolean value indicating whether all are complete
		 */
		public function get allListenersComplete():Boolean {
			return (pendingCount==0);
		}
		
		/**
		 * Returns the number of pending start ups
		 */
		public function get pendingCount():int {
			return _pendingStartupCount;
		}
		
		/**
		 * Returns the number of total start ups
		 */
		public function get totalCount():int {
			return _totalStartUpCount;
		}
		
		/**
		 * Monitors the <code>IAsyncStartupRunListener</code> to determine if the listener is ready or if
		 * the listener has failed
		 * 
		 * @param listener The <code>IAsyncStartupRunListener</code> to listen to
		 */
		protected function monitorForAsyncStartup( listener:IAsyncStartupRunListener ):void {
			listener.addEventListener( LISTENER_READY, handleListenerReady );
			listener.addEventListener( LISTENER_FAILED, handleListenerFailed );
		}
		
		/**
		 * Stop monitoring the <code>IAsyncStartupRunListener</code> 
		 * 
		 * @param listener The <code>IAsyncStartupRunListener</code> to stop listening to
		 */
		protected function cleanupStartupListeners( listener:IAsyncStartupRunListener ):void {
			listener.removeEventListener( LISTENER_READY, handleListenerReady );
			listener.removeEventListener( LISTENER_FAILED, handleListenerFailed );
		}
	
		/**
		 * Instruct the start up token that all listeners are now ready
		 */
		protected function sendReadyNotification():void {
			startUpToken.sendReady();
		}
		
		/**
		 * Stops listening when the listener will be ready and determines if all other listeners are ready
		 * 
		 * @param event
		 */
		protected function handleListenerReady( event:Event ):void {
			var asyncListener:IAsyncStartupRunListener = event.target as IAsyncStartupRunListener;

			cleanupStartupListeners( asyncListener );
			_pendingStartupCount--;
			
			if ( allListenersReady ) {
				sendReadyNotification();
			}
		}
		
		/**
		 * Stops listening when the listener will be ready, removes the listener from the <code>IRunNotifier</code>.
		 * and determines if all other listeners are ready
		 * 
		 * @param event
		 */
		protected function handleListenerFailed( event:Event ):void {
			var asyncListener:IAsyncStartupRunListener = event.target as IAsyncStartupRunListener;

			cleanupStartupListeners( asyncListener );
			_pendingStartupCount--;

			//logger.error( "Listener {0} failed to start ", asyncListener );
			notifier.removeListener( asyncListener );

			if ( allListenersReady ) {
				sendReadyNotification();
			}
		}
		
		/**
		 * Makes the AsyncListenerWatcher stop watching the provided <code>IAsyncStartupRunListener</code>
		 * 
		 * @param listener The <code>IAsyncStartupRunListener</code> to stop watching
		 */
		public function unwatchListener( listener:IAsyncStartupRunListener ):void {
			if ( listener is IAsyncStartupRunListener ) {
				_totalStartUpCount--;

				var startListener:IAsyncStartupRunListener = listener as IAsyncStartupRunListener; 
				
				//The listener still was not ready, stop watching it 
				if ( !startListener.ready ) {
					_pendingStartupCount--;
					cleanupStartupListeners( startListener );
				}
			}
			
			if ( listener is IAsyncCompletionRunListener ) {
				var completeListener:IAsyncCompletionRunListener = listener as IAsyncCompletionRunListener;
			}
		}
		
		/**
		 * Makes the AsyncListenerWatcher start watching the provided <code>IAsyncStartupRunListener</code>
		 * 
		 * @param listener The <code>IAsyncStartupRunListener</code> to watch
		 */
		public function watchListener( listener:IAsyncStartupRunListener ):void {
			if ( listener is IAsyncStartupRunListener ) {
				_totalStartUpCount++;

				var startListener:IAsyncStartupRunListener = listener as IAsyncStartupRunListener; 
				
				//If this listener is not ready, wait for it
				if ( !startListener.ready ) {
					_pendingStartupCount++;
					monitorForAsyncStartup( startListener );
				}
			}
			
			if ( listener is IAsyncCompletionRunListener ) {
				var completeListener:IAsyncCompletionRunListener = listener as IAsyncCompletionRunListener;
			}

		}
		
		/**
		 * Constructor.
		 * 
		 * @param notifier
		 * @param logger 
		 */
		public function AsyncListenerWatcher( notifier:IRunNotifier, logger:* ) {
			this.notifier = notifier;
			//this.logger = logger;
			this._startToken = new AsyncListenersToken();
		}
	}
}