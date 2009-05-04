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
package org.flexunit.async
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
	public class Async
	{
		public static function proceedOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.pendUntilComplete, timeout, null, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 

		public static function failOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.failOnComplete, timeout, null, asyncHandlingStatement.pendUntilComplete );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 

		public static function handleEvent( testCase:Object, target:IEventDispatcher, eventName:String, eventHandler:Function, timeout:int=500, passThroughData:Object = null, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		public static function asyncHandler( testCase:Object, eventHandler:Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Function {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
						
			return asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
		}

		public static function asyncResponder( testCase:Object, responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			
			return asyncHandlingStatement.asyncResponder( responder, timeout, passThroughData, timeoutHandler );
		}
	}
}