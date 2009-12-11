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
	 * The <code>AsyncLocator</code> is used to keep track of test cases that have implemented asynchronous 
	 * functionality.  The test cases are registered with the <code>AsyncLocator</code> and reference an
	 * object that implements <code>IAsyncHandlingStatement</code>.  Test cases are registered using the
	 * method <code>#registerStatementForTest()</code>.<br/>
	 * 
	 * The <code>IAsyncHandlingStatement</code> is then retrieved using the method <code>#getCallableForTest()</code>
	 * and providing the test case.  If a test case has not been registered, an <code>AssertionError</code> will be
	 * thrown.<br/>
	 * 
	 * Once an asynchronous test has completed, the method <code>#cleanUpCallableForTest</code> should be called in 
	 * order to disassociate the test case and the <code>IAsyncHandlingStatement</code>.
	 * 
	 * @see org.flexunit.async.Async
	 */
	public class AsyncLocator {
		/**
		 * @private
		 */
		private static var asyncHandlerMap:Dictionary = new Dictionary();
		
		/**
		 * Registers the <code>expectAsyncInstance</code> with the provided <code>testCase</code>.
		 * 
		 * @param expectAsyncInstance the <code>IAsyncHandlingStatement</code> to be registered.
		 * @param testCase The test case to associate with the particular <code>expectAsyncInstance</code>.
		 */
		public static function registerStatementForTest( expectAsyncInstance:IAsyncHandlingStatement, testCase:Object ):void {
			asyncHandlerMap[ testCase ] = expectAsyncInstance;
		} 
		
		/**
		 * Retrieves the <code>IAsyncHandlingStatement</code> for the provided <code>testCase</code>.  If no 
		 * <code>IAsyncHandlingStatement</code> has been registered for the <code>testCase</code>, an 
		 * <code>AssertionError</code> will be thrown.
		 * 
		 * @param testCase The test case used to retrieve the <code>IAsyncHandlingStatement</code>.
		 * 
		 * @return an <code>IAsyncHandlingStatement</code> associated with the <code>testCase</code>.
		 * 
		 * @throws org.flexunit.AssertionError Thrown if an <code>IAsyncHandlingStatement</code> was not registered
		 * for the provided <code>testCase</code>.
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
		 * Removes the registration for the <code>IAsyncHandlingStatement</code> that was associated with the
		 * provided <code>testCase</code>.
		 * 
		 * @param testCase The test case to remove the association with the <code>IAsyncHandlingStatement</code>.
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