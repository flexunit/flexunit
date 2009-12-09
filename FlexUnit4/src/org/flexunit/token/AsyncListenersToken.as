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

package org.flexunit.token {
	import org.flexunit.runner.IRunner;
	
	/**
	 * The <code>AsyncListenersToken</code> is responsible for indicating the statuses of <code>IAsyncRunListener</code>s
	 * and indicating when the <code>IAsyncRunListener</code>s are ready or have completed.  Additionally, the token
	 * keeps track of an <code>IRunner</code> that can be stored while waiting for listeners to report that they
	 * are ready.  The <code>IRunner</code> can then be extracted an the test run can proceed.
	 * 
	 * @see org.flexunit.runner.FlexUnitCore#runRunner()
	 */
	public class AsyncListenersToken {
		/**
		 * @private
		 */
		private var methodsEntries:Array;
		/**
		 * @private
		 */
		private var _error:Error;
		/**
		 * @private
		 */
		private var debugClassName:String;
		/**
		 * @private
		 */
		private var _token:AsyncTestToken;
		/**
		 * @private
		 */
		private var _runner:IRunner;
		
		/**
		 * Returns an instance of the <code>IRunner</code> associated with the <code>AsyncListenersToken</code>.
		 */
		public function get runner():IRunner {
			return _runner;
		}
		
		public function set runner( value:IRunner ):void {
			_runner = value;	
		}
		
		/**
		 * Adds a notification method to the <code>AsyncListenersToken</code> and returns the token.
		 * 
		 * @param method A <code>Function</code> that will be invoked when the <code>AsyncListenersToken</code>
		 * are ready or have completed.
		 * 
		 * @return this <code>AsyncListenersToken</code> with the added <code>method</code>.
		 */
		public function addNotificationMethod( method:Function ):AsyncListenersToken {
			if (methodsEntries == null)
				methodsEntries = [];
	
			methodsEntries.push( method );			

			return this;
		}
		
		/**
		 * Calls each notification method and passes the current <code>IRunner</code> to that method.
		 */
		public function sendReady():void {
			if ( methodsEntries ) {
 				for ( var i:int=0; i<methodsEntries.length; i++ ) {
					methodsEntries[ i ]( runner );
				}
 			}
		}
		
		/**
		 * Calls each notification method and passes the current <code>IRunner</code> to that method.
		 */
		public function sendComplete():void {
			if ( methodsEntries ) {
 				for ( var i:int=0; i<methodsEntries.length; i++ ) {
					methodsEntries[ i ]( runner );
				}
 			}
		}
		
		/**
		 * Constructor.
		 */
		public function AsyncListenersToken() {
		}
	}
}
