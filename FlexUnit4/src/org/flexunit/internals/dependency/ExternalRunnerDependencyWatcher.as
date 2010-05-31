/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
package org.flexunit.internals.dependency {
	import flash.events.Event;
	
	import org.flexunit.runner.external.IExternalDependencyRunner;
	import org.flexunit.token.AsyncCoreStartupToken;
	
	public class ExternalRunnerDependencyWatcher implements IExternalRunnerDependencyWatcher {
		
		private var _token:AsyncCoreStartupToken;
		private var _pendingCount:int;

		/**
		 * Returns the start up <code>AsyncCoreStartupToken</code>
		 */
		public function get token():AsyncCoreStartupToken {
			return _token;
		}
		
		public function get allDependenciesResolved():Boolean {
			return (pendingCount==0);
		}
		
		/**
		 * Returns the number of pending start ups
		 */
		public function get pendingCount():int {
			return _pendingCount;
		}
		
		protected function monitorForDependency( dr:IExternalDependencyResolver ):void {
			dr.addEventListener( ExternalDependencyResolver.ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED, handleRunnerReady );
			//runner.addEventListener( RUNNER_FAILED, handleRunnerFailed );
		}
		
		protected function cleanupListeners( dr:IExternalDependencyResolver ):void {
			dr.removeEventListener( ExternalDependencyResolver.ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED, handleRunnerReady );
			//runner.removeEventListener( RUNNER_FAILED, handleRunnerFailed );
		}
		
		protected function sendReadyNotification():void {
			token.sendReady();
		}
		
		protected function handleRunnerReady( event:Event ):void {
			var dr:IExternalDependencyResolver = event.target as IExternalDependencyResolver;
			
			cleanupListeners( dr );
			_pendingCount--;
			
			if ( allDependenciesResolved ) {
				sendReadyNotification();
			}
		}

		protected function handleRunnerFailed( event:Event ):void {
			var dr:IExternalDependencyResolver = event.target as IExternalDependencyResolver;
			
			cleanupListeners( dr );
			_pendingCount--;
			
			if ( allDependenciesResolved ) {
				sendReadyNotification();
			}
		}

		public function watchDependencyResolver( dr:IExternalDependencyResolver ):void {
			if ( dr && !dr.ready ) {
				_pendingCount++;
				monitorForDependency( dr );
			}
		}
		
		/**
		 * Constructor.
		 */
		public function ExternalRunnerDependencyWatcher() {
			this._token = new AsyncCoreStartupToken();
		}
	}
}