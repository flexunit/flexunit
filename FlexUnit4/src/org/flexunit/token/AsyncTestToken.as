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

package org.flexunit.token {
	import org.flexunit.async.AsyncTestResponder;
	
	dynamic public class AsyncTestToken {
		private var methodsEntries:Array;
		private var _error:Error;
		private var debugClassName:String;
		private var _token:AsyncTestToken;

		public function get parentToken():AsyncTestToken {
			return _token;
		}

		public function set parentToken( value:AsyncTestToken ):void {
			_token = value;
		}
		
		public function get error():Error {
			return _error;
		}
		
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
			
			if ( debugClassName ) {
				output += ( debugClassName + ": " );
			}
			
			output += ( methodsEntries.length + " listeners" );
			
			return output; 
		}
		
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