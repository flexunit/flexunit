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
package org.flexunit.async {
	import flash.utils.Dictionary;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
	public class AsyncLocator {
		private static var asyncHandlerMap:Dictionary = new Dictionary();
		
		public static function registerStatementForTest( expectAsyncInstance:IAsyncHandlingStatement, testCase:Object ):void {
			asyncHandlerMap[ testCase ] = expectAsyncInstance;
		} 
		
		public static function getCallableForTest( testCase:Object ):IAsyncHandlingStatement {
			var handler:IAsyncHandlingStatement = asyncHandlerMap[ testCase ];
			
			if ( !handler ) {
				throw new AssertionError("Cannot add asynchronous functionality to methods defined by Test,Before or After that are not marked async");	
			}

			return handler;
		} 

		public static function cleanUpCallableForTest( testCase:Object ):void {
			delete asyncHandlerMap[ testCase ];
		} 
		
/*		private static var instance:AsyncLocator;
		public static function getInstance():AsyncLocator {
			if ( !instance ) {
				instance = new AsyncLocator();
			}
			
			return instance;
		}

		public function AsyncLocator() {
			callableMap = new Dictionary();
		}
*/	}
}