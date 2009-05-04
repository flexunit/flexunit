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
 package org.flexunit.runner.notification.async {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.logging.ILogger;
	
	import org.flexunit.runner.notification.IAsyncStartupRunListener;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncListenersToken;

	public class AsyncListenerWatcher {
		public static const LISTENER_READY:String = "listenerReady";
		public static const LISTENER_FAILED:String = "listenerFailed";

		//public static const ALL_LISTENERS_READY:String = "allListenersReady";

		private var _pendingCount:int;
		private var _totalCount:int;
		private var notifier:IRunNotifier;
		private var logger:ILogger;
		private var _token:AsyncListenersToken;

		public function get token():AsyncListenersToken {
			return _token;
		}

		public function get allListenersReady():Boolean {
			return (pendingCount==0);
		}

		public function get pendingCount():int {
			return _pendingCount;
		}

		public function get totalCount():int {
			return _totalCount;
		}

		protected function monitorForAsyncStartup( listener:IAsyncStartupRunListener ):void {
			listener.addEventListener( LISTENER_READY, handleListenerReady );
			listener.addEventListener( LISTENER_FAILED, handleListenerFailed );
		}

		protected function cleanupListeners( listener:IAsyncStartupRunListener ):void {
			listener.removeEventListener( LISTENER_READY, handleListenerReady );
			listener.removeEventListener( LISTENER_FAILED, handleListenerFailed );
		}

		protected function sendReadyNotification():void {
			token.sendReady();
		}

		protected function handleListenerReady( event:Event ):void {
			var asyncListener:IAsyncStartupRunListener = event.target as IAsyncStartupRunListener;

			cleanupListeners( asyncListener );
			_pendingCount--;
			
			if ( allListenersReady ) {
				sendReadyNotification();
			}
		}
		
		protected function handleListenerFailed( event:Event ):void {
			var asyncListener:IAsyncStartupRunListener = event.target as IAsyncStartupRunListener;

			cleanupListeners( asyncListener );
			_pendingCount--;

			logger.error( "Listener {0} failed to start ", asyncListener );
			notifier.removeListener( asyncListener );

			if ( allListenersReady ) {
				sendReadyNotification();
			}
		}

		public function unwatchListener( listener:IAsyncStartupRunListener ):void {
			_totalCount--;
			
			if ( !listener.ready ) {
				_pendingCount--;
				cleanupListeners( listener );
			}
		}

		public function watchListener( listener:IAsyncStartupRunListener ):void {
			_totalCount++;
			
			if ( !listener.ready ) {
				_pendingCount++;
				monitorForAsyncStartup( listener );
			}
		}

		public function AsyncListenerWatcher( notifier:IRunNotifier, logger:ILogger ) {
			this.notifier = notifier;
			this.logger = logger;
			this._token = new AsyncListenersToken();
		}
	}
}