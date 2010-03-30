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
	import flash.net.Responder;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
	/**
	 * The <code>Async</code> class contains static methods used in the handling of events in asynchronous
	 * methods in a particular test case.  These methods may be called in an asynchronous test method in
	 * order to exhibit specific behavior once the proper conditions are met.<br/>
	 * 
	 * The asynchronous test methods must be labeled as asynchronous in order
	 * to successfully use <code>Async</code>'s static methods; otherwise, the test will not be registered as
	 * asynchronous and an <code>AssertionError</code> will be thrown.<br/>
	 * 
	 * <pre><code>
	 * [Test(async)]
	 * public function asyncTest():void {
	 * 	Async.proceedOnEvent(...);
	 * }
	 * </code></pre>
	 */
	public class Async
	{	
		/**
		 * This method is used when you want to ensure that a specific event fires during an asynchronous test. When the event fires, the flex unit
		 * framework simply acknowledges it internally. If there are additional outstanding asynchronous events, those will be processed individually.
		 *  
		 * This method is generally used when the existance of the event, and not the even't data is sufficient to indicate success. If you need to inspect
		 * the event's data before making a decision, then use <code>handleEvent</code> instead. 
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param timeoutHandler The function that will be executed if the <code>target</code> does not 
		 * receive expected <code>eventName</code> before the <code>timeout</code> time is reached.
		 */
		public static function proceedOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;

			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.pendUntilComplete, timeout, null, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * This method is used when you want to fail if a given event occurs, within a given amount of time, during an asynchronous test. When the event fires, 
		 * the flex unit framework causes the test to fail. If the timout is reached before the failure occurs, then the framework will no longer watch for 
		 * this event. So, for example, if you want to verify that you do not receive a failure within 300ms, this would be a good method to use.
		 *  
		 * This method is generally used when the existance of the event, and not the even't data is sufficient to indicate failure. If you need to inspect
		 * the event's data before making a decision, then use <code>handleEvent</code> instead. 
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param timeoutHandler The function that will be executed if the <code>target</code> does not 
		 * receive expected <code>eventName</code> before the <code>timeout</code> time is reached.
		 */
		public static function failOnEvent( testCase:Object, target:IEventDispatcher, eventName:String, timeout:int=500, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;
			
			handler = asyncHandlingStatement.asyncHandler( asyncHandlingStatement.failOnComplete, timeout, null, asyncHandlingStatement.pendUntilComplete );
			target.addEventListener( eventName, handler, false, 0, true );  
		}
		
		/**
		 * Causes the failure of the existing block (Before, After or the Test itself dependent upon where this statement is located) when an event occurs. In
		 * practice, this method is used to handle an event dispatched from an object under test that, while not necessarily part of the test itself, would indicate
		 * a failure if dispatched. A valid example might be an service call. You may want to test that the data is correct and returns within a given period of time,
		 * however, if at any time during that test a Failure event is dispatched, you likely wish to end the test. 
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param target The target that will listen for the dispatched <code>eventName</code>.
		 * @param eventName The name of the event being listend for by the <code>target</code>.
		 * 
		 * Example:
		 * 		[Test(async)]
		 *      public function doTest():void {
		 *	      Async.registerFailureEvent( this, httpService, FaultEvent.FAULT );
		 *	      Async.handleEvent( this, httpService, ResultEvent.RESULT, handleResult, 2000 );
		 *        httpService.send();			
		 *      }
		 * 
		 * Without the registerFailureEvent, you would need to wait 2 full seconds for the timeout to occur before declaring this test a failure when a fault
		 * event occurs.
		 * 
		 */
		public static function registerFailureEvent( testCase:Object, target:IEventDispatcher, eventName:String ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;
			
			handler = asyncHandlingStatement.asyncErrorConditionHandler( asyncHandlingStatement.failOnComplete );
			target.addEventListener( eventName, handler );
			//Do not use a weak reference here or there is nothing to keep it in memory
		}

		/**
		 * Allow you to continue a test while waiting for a given asynchronous event to occur. Normally a test ends when you reach the method closure at the end
		 * of your test method. This event tells the FlexUnit framework to continue that test pending the dispatch of an event by the <code>target</code> of an
		 * event named <code>eventName</code>. If that event does not occur within the <code>timeOut</code> then the timeout handler (if specified) will be called, 
		 * else the test will be declared a failure. 
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
		 * @param timeoutHandler The function that will be executed if the <code>target</code> does not 
		 * receive expected <code>eventName</code> before the <code>timeout</code> time is reached.
		 */
		public static function handleEvent( testCase:Object, target:IEventDispatcher, eventName:String, eventHandler:Function, timeout:int=500, passThroughData:Object = null, timeoutHandler:Function = null ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			var handler:Function;
                   
			handler = asyncHandlingStatement.asyncHandler( eventHandler, timeout, passThroughData, timeoutHandler );
			target.addEventListener( eventName, handler, false, 0, true );  
		} 
		
		/**
		 * This method works similarly to the handleEvent, however, whereas the handleEvent does all of the work to handle a specific event,
		 * this method simply returns an eventHandler (function) which you use within your own addEventListener() methods. 
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
		 * This method works in a similar fashion to handleEvent, however, it is intended to work with AsyncTokens and Responders as opposed to events. 
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
		
		/**
		 * This method works in a similar fashion to handleEvent, however, it is intended to work with AsyncTokens and Responders as opposed to events. 
		 * 
		 * @param testCase The current asynchronous test case.
		 * @param resultHandler The function that will be executed if the <code>timeout</code> period has not been reached and we have a success.
		 * @param faultHandler The function that will be executed if the <code>timeout</code> period has not been reached and we have an error.
		 * @param timeout The length of time, in milliseconds, before the calling the <code>timeoutHandler</code>
		 * if the <code>eventName</code> event is not dispatched.
		 * @param passThroughData An Object that can be given information about the current test, this information will be 
		 * available to both the <code>eventHandler</code> and <code>timeoutHandler</code>.
		 * @param timeoutHandler The function that will be executed if the <code>timeout</code> period is reached.
		 */
		public static function asyncNativeResponder( testCase:Object, resultHandler : Function, faultHandler : Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ) : Responder {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( testCase );
			
			return asyncHandlingStatement.asyncNativeResponder( resultHandler, faultHandler, timeout, passThroughData, timeoutHandler );
		}
	}
}