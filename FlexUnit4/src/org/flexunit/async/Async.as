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
package org.flexunit.async
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
	/**
	 * The <code>Async</code> class contains static methods used in the handling of events in asynchronous
	 * methods in a particular test case.
	 */
	public class Async
	{	
		/**
		 * Proceeds for a given <code>testCase</code> based on the <code>IAsyncHandlingStatement</code> that has been 
		 * associated with the test when an event with the name of <code>eventName</code> is encountered by the 
		 * <code>target</code>.  If the event named <code>eventName</code> is not encountered by the <code>target</code> 
		 * within the specified <code>timeout</code> period, the <code>timeoutHandler</code> will be called.
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param timeoutHandler The function that will be executed if the <code>target<code> does not 
		 * receive expected <code>eventName</code> before the <code>timeout</code> time is reached.
		 */
		public static function proceedOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.pendUntilComplete, timeout, null, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Fails for a given <code>testCase</code> based on the <code>IAsyncHandlingStatement</code> that has been 
		 * associated with the test when an event with the name of <code>eventName</code> is encountered by the 
		 * <code>target</code>.  If the event named <code>eventName</code> is not encountered by the <code>target</code> 
		 * within the specified <code>timeout</code> period, the <code>testCase</code> will not fail.
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param timeoutHandler
		 */
		public static function failOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncErrorConditionHandler( asyncHandlingStatement.failOnComplete, timeout, null, asyncHandlingStatement.pendUntilComplete );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Handles a given <code>testCase</code> based on the <code>IAsyncHandlingStatement</code> that has been 
		 * associated with the test when an event with the name of <code>eventName</code> is encountered by the 
		 * <code>target</code>.  If the event named <code>eventName</code> is not encountered by the <code>target</code> 
		 * within the specified <code>timeout</code> period, the <code>timeoutHandler</code> will be called.
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * @param eventHandler The function that will be executed if the the <code>target</code> dispatches an event with 
		 * a name of <code>eventName</code> within the provided <code>timemout</code> period.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param passThroughData An Object that can be given information about the current test, this information will be 
		 * available to both the <code>eventHandler</code> and <code>timeoutHandler</code>.
		 * @param timeoutHandler The function that will be executed if the <code>target<code> does not 
		 * receive expected <code>eventName</code> before the <code>timeout</code> time is reached.
		 */
		public static function handleEvent( testCase:Object, target:IEventDispatcher, eventName:String, eventHandler:Function, timeout:int=500, passThroughData:Object = null, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;
                   
			handler = asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Provides a handler function for the <code>testCase</code> based on the <code>IAsyncHandlingStatement</code> 
		 * that has been associated with the test.
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param eventHandler The function that will be executed if the <code>timemout</code> period has not been reached.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param passThroughData An Object that can be given information about the current test, this information will be 
		 * available to both the <code>eventHandler</code> and <code>timeoutHandler</code>.
		 * @param timeoutHandler The function that will be executed if the <code>timeout</code> period is reached.
		 */
		public static function asyncHandler( testCase:Object, eventHandler:Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Function {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
						
			return asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
		}
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		/**
		 * Provides a handler function for the <code>testCase</code> based on the <code>IAsyncHandlingStatement</code> 
		 * that has been associated with the test.
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param responder The responder that will be executed if the <code>timemout</code> period has not been reached.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param passThroughData An Object that can be given information about the current test, this information will be 
		 * available to both the <code>eventHandler</code> and <code>timeoutHandler</code>.
		 * @param timeoutHandler The function that will be executed if the <code>timeout</code> period is reached.
		 */
		CONFIG::useFlexClasses
		public static function asyncResponder( testCase:Object, responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			
			return asyncHandlingStatement.asyncResponder( responder, timeout, passThroughData, timeoutHandler );
		}
	}
}