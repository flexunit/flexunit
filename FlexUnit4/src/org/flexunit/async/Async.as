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
	 * Contains static methods for handling asynchronous events.
	 */
	public class Async
	{	
		/**
		 * Creates an object that implements an <code>IAsyncHandlingStatement</code> and will either proceed or call the timeoutHandler based on whether the target has dispatched 
		 * an event with the correct eventName within the timeout period.
		 * 
		 * @param testCase The current test class.
		 * @param target The target to watch for the dispatched event.
		 * @param eventName The name of the event to listen to that comes from the target.
		 * @param timeout The length of time in milliseconds before the async call will timeout.
		 * @param timeoutHandler The function that will be executed if the target does not dispatched the expected event before the timeout time is reached.
		 */
		public static function proceedOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.pendUntilComplete, timeout, null, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Creates an object that implements an <code>IAsyncHandlingStatement</code> and will fail based on whether the target has dispatched 
		 * an event with the correct eventName within the timeout period.
		 * 
		 * @param testCase The current test class.
		 * @param target The target to watch for the dispatched event.
		 * @param eventName The name of the event to listen to that comes from the target.
		 * @param timeout The length of time in milliseconds before the async call will timeout.
		 * @param timeoutHandler The function that will be executed if the timeout time is reached.
		 */
		public static function failOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncErrorConditionHandler( asyncHandlingStatement.failOnComplete, timeout, null, asyncHandlingStatement.pendUntilComplete );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Creates an object that implements an <code>IAsyncHandlingStatement</code> that will either call the eventHandler or the timeoutHandler
		 * based on whether the target has dispatched an event with the correct eventName within the timeout period.
		 * 
		 * @param testCase The current test class.
		 * @param target The target to watch for the dispatched event.
		 * @param eventName The name of the event to listen to that comes from the target.
		 * @param eventHandler The function that will be executed if the the target dispatches an event with a name of eventName.
		 * @param timeout The length of time in milliseconds before the async call will timeout.
		 * @param passThroughData An Object that can be given information about the current test, this information will be available for both the eventHandler and timeoutHandler.
		 * @param timeoutHandler The function that will be executed if the target does not dispatched the expected event before the timeout time is reached.
		 */
		public static function handleEvent( testCase:Object, target:IEventDispatcher, eventName:String, eventHandler:Function, timeout:int=500, passThroughData:Object = null, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;
                   
			handler = asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * Creates an object that implements an <code>IAsyncHandlingStatement</code> and returns a function that will either call the eventHandler or the timeoutHandler
		 * based on whether time has timed out.
		 * 
		 * @param testCase The current test class.
		 * @param eventHandler The function that will be executed if the timeout has not expired.
		 * @param timeout The length of time in milliseconds before the async call will timeout.
		 * @param passThroughData An Object that can be given information about the current test, this information will be available for both the eventHandler and timeoutHandler.
		 * @param timeoutHandler The function that will be executed if the target does not dispatched the expected event before the timeout time is reached.
		 */
		public static function asyncHandler( testCase:Object, eventHandler:Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Function {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
						
			return asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
		}
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		/**
		 * Creates an object that implements an <code>IAsyncHandlingStatement</code> and returns a function that will either call 
		 * the responder or the timeoutHandler based on whether time has timed out.
		 * 
		 * @param testCase The current test class.
		 * @param responder The responder to handle the test when it succeeds of fails.
		 * @param timeout The length of time in milliseconds before the async call will timeout.
		 * @param passThroughData An Object that can be given information about the current test, this information will be available for both the eventHandler and timeoutHandler.
		 * @param timeoutHandler The function that will be executed if the target does not dispatched the expected event before the timeout time is reached.
		 */
		CONFIG::useFlexClasses
		public static function asyncResponder( testCase:Object, responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			
			return asyncHandlingStatement.asyncResponder( responder, timeout, passThroughData, timeoutHandler );
		}
	}
}