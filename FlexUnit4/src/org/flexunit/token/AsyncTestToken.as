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
	
	/**
	 * The <code>AsyncTestToken</code> is responsible for indicating that a given task has completed.  The token
	 * can then notify other tasks and provide the results of the just completed task to the notified parent
	 * task through the use of a notification method.  In order to notify a parent task about the completion of a
	 * task performed by a child task, the parent task must add a notification method to the <code>AsyncTestToken</code>
	 * using the <code>#addNotificationMethod()</code>.<br/>
	 * 
	 * The <code>AsyncTestToken</code> is used throughout much of FlexUnit4.  It is used to notify <code>FlexUnitCore</code>,
	 * runners, statements, and parts of a test when a certain activity has finished.
	 */
	dynamic public class AsyncTestToken implements IAsyncTestToken {
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
		private var _token:IAsyncTestToken;
		
		/**
		 * Returns the parentToken of the <code>AsyncTestToken</code>.
		 */
		public function get parentToken():IAsyncTestToken {
			return _token;
		}

		public function set parentToken( value:IAsyncTestToken ):void {
			_token = value;
		}
		
		/**
		 * Returns the error associated with the <code>AsyncTestToken</code>.
		 */
		public function get error():Error {
			return _error;
		}
		
		/**
		 * Adds a notification <code>method</code> to the <code>AsyncTestToken</code> and returns the token.
		 * 
		 * @param method A <code>Function</code> that will be invoked when results are sent.
		 * @param debugClassName The name of the class.
		 * 
		 * @return this <code>AsyncTestToken</code> with the added <code>method</code>.
		 */
		public function addNotificationMethod( method:Function, debugClassName:String=null ):IAsyncTestToken {
			if (methodsEntries == null)
				methodsEntries = [];
	
			methodsEntries.push( new MethodEntry( method, debugClassName?debugClassName:this.debugClassName ) );			

			return this;
		}
		
		/**
		 * Creates a <code>ChildResult</code> using this <code>AsynctestToken</code> and the provided <code>error</code>.
		 * 
		 * @param error The error to provide to the <code>ChildResult</code>.
		 * 
		 * @return a <code>ChildResult</code> using this <code>AsynctestToken</code> and the provided <code>error</code>.
		 */
		private function createChildResult( error:Error ):ChildResult {
			if ( error ) {
				//trace("break here");
			}
			return new ChildResult( this, error );
		}
		
		/**
		 * If any notification methods exist, invokes the notification methods with a <code>ChildResult</code> that
		 * contains a references to this token and the provided <code>error</code>.
		 * 
		 * @parameter error The error to be provided to the <code>ChildResult</code>.
		 */
		public function sendResult( error:Error=null ):void {
			if ( methodsEntries && methodsEntries[ 0 ] ) {
				//Right now we only really have 1 level of responders
				//this is more just for debugging to see a cleaner stack trace
				methodsEntries[ 0 ].method( createChildResult( error ) );
				
				/*for ( var i:int=0; i<methodsEntries.length; i++ ) {
					methodsEntries[ i ].method( createChildResult( error ) );
				}*/
			}
		}
		
		/**
		 * Returns a string that inculdes the <code>debugClassName</code>, if it exists, and the
		 * current number of listeners.
		 */
		public function toString():String {
			var output:String = "";
			var numEntries:int = 0;
			
			if ( debugClassName ) {
				output += ( debugClassName + ": " );
			}
			
			if ( methodsEntries ) {
				numEntries = methodsEntries.length;
			}
			
			output += ( numEntries + " listeners" );
			
			return output; 
		}
		
		/**
		 * Constructor.
		 * 
		 * @param debugClassName The name of the debug class.
		 */
		public function AsyncTestToken( debugClassName:String = null ) {
			this.debugClassName = debugClassName;
		}
	}
}

class MethodEntry {
	public var method:Function;
	public var className:String;
	
	public function MethodEntry( method:Function, className:String="" ) {
		this.method = method;
		this.className = className;
	}
}