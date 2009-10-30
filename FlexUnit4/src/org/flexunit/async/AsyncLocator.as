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
package org.flexunit.async {
	import flash.utils.Dictionary;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
	/**
	 * The AsyncLocator is used to keep track of asynchronous test cases.
	 */
	public class AsyncLocator {
		private static var asyncHandlerMap:Dictionary = new Dictionary();
		
		/**
		 * Registers the (@link IAsyncHandlingStatement) with a particular testCase.
		 * @param (@link IAsyncHandlingStatement) the AsyncHandlingStatement to be registered
		 * @param object
		 */
		public static function registerStatementForTest( expectAsyncInstance:IAsyncHandlingStatement, testCase:Object ):void {
			asyncHandlerMap[ testCase ] = expectAsyncInstance;
		} 
		
		/**
		 * Retrieves the (@link IAsyncHandlingStatement) for a particular testCase.  If no AsyncHandlingStatement has been registered
		 * for the testCase, an (@link AssertionError) will be thrown
		 * @param testCase
		 */
		public static function getCallableForTest( testCase:Object ):IAsyncHandlingStatement {
			var handler:IAsyncHandlingStatement = asyncHandlerMap[ testCase ];
			
			//If no handler was obtained from the dictionary, the test case was never marked as asynchronous, throw an AssertionError
			if ( !handler ) {
				throw new AssertionError("Cannot add asynchronous functionality to methods defined by Test,Before or After that are not marked async");	
			}

			return handler;
		} 
		
		/**
		 * Removes the (@link IAsyncHandlingStatement) for a particular testCase.
		 * @param testCase
		 */
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