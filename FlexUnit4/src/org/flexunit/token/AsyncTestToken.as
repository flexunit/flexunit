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
	 * Responsible for indicating that a given task has completed
	 */
	dynamic public class AsyncTestToken {
		private var methodsEntries:Array;
		private var _error:Error;
		private var debugClassName:String;
		private var _token:AsyncTestToken;
		
		/**
		 * Returns the parentToken of the AsyncTestToken
		 */
		public function get parentToken():AsyncTestToken {
			return _token;
		}

		public function set parentToken( value:AsyncTestToken ):void {
			_token = value;
		}
		
		/**
		 * Returns the error associated with the AsyncTestToken
		 */
		public function get error():Error {
			return _error;
		}
		
		/**
		 * Adds a notification method to the AsyncTestToken and returns the token
		 * 
		 * @param function A method that will be invoked when results are sent
		 * @param debugClassName The name of the class
		 * 
		 * @return the AsyncTestToken
		 */
		public function addNotificationMethod( method:Function, debugClassName:String=null ):AsyncTestToken {
			if (methodsEntries == null)
				methodsEntries = [];
	
			methodsEntries.push( new MethodEntry( method, debugClassName?debugClassName:this.debugClassName ) );			

			return this;
		}
		
		private function createChildResult( error:Error ):ChildResult {
			if ( error ) {
				//trace("break here");
			}
			return new ChildResult( this, error );
		}
		
		/**
		 * If any notification methods exist, invokes the notification methods with a <code>ChildResult</code> that
		 * contains a references to this token and the error parameter
		 * 
		 * @parameter error The error to be provided to the ChildResult
		 */
		public function sendResult( error:Error=null ):void {
			if ( methodsEntries && methodsEntries[ 0 ] ) {
				//Right now we only really have 1 level of responders
				//this is more just for debugging to see a cleaner stack trace
				methodsEntries[ 0 ].method( createChildResult( error ) );
				
/* 				for ( var i:int=0; i<methodsEntries.length; i++ ) {
					methodsEntries[ i ].method( createChildResult( error ) );
				}
 */			}
		}
		
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
		 * @param debugClassName The name of the class
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