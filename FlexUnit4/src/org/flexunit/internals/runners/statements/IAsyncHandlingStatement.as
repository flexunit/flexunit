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
package org.flexunit.internals.runners.statements
{
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.net.Responder;
	
	import mx.rpc.IResponder;
	
	import org.fluint.sequence.SequenceRunner;
	
	/**
	 * An <code>IAsyncHandlingStatement</code> is an interface for statements that handle asynchronous functionality
	 * for tests.  If a statement is going to be handlining asynchronous tests, it needs to implement this interface.
	 */
	public interface IAsyncHandlingStatement
	{
		/**
		 * Returns a Boolean value indicating whether the test method is current executing.
		 */
		function get bodyExecuting():Boolean;
		
		/**
		 * Creates an <code>AsyncHandler</code> that pend and either call the <code>eventHandler</code> or the
		 * <code>timeoutHandler</code>, passing the <code>passThroughData</code>, depending on whether the
		 * <code>timeout</code> period has been reached.
		 * 
		 * @param eventHandler The Function that will be executed if the handler is called before 
		 * the <code>timeout</code> has expired.
		 * @param timeout The length of time, in milliseconds, before the <code>timeoutHandler</code> will be executed.
		 * @param passThroughData An Object that can be given information about the current test; this information will 
		 * be available for both the <code>eventHandler</code> and the <code>timeoutHandler</code>.
		 * @param timeoutHandler The Function that will be executed if the <code>timeout</code> time is reached prior to
		 * the expected event being dispatched.
		 * 
		 * @return an event handler Function that will determine whether the <code>timeout</code> has been reached.
		 */
		function asyncHandler( eventHandler:Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Function; 
		function asyncErrorConditionHandler( eventHandler:Function ):Function;
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		/**
		 * Creates an <code>IAsyncTestResponder</code> that pend and either call the <code>eventHandler</code> or the
		 * <code>timeoutHandler</code>, passing the <code>passThroughData</code>, depending on whether the
		 * <code>timeout</code> period has been reached.
		 * 
		 * @param responder The responder that will be executed if the <code>IResponder</code> is called before 
		 * the <code>timeout</code> has expired.
		 * @param timeout The length of time, in milliseconds, before the <code>timeoutHandler</code> will be executed.
		 * @param passThroughData An Object that can be given information about the current test; this information will 
		 * be available for both the <code>eventHandler</code> and the <code>timeoutHandler</code>.
		 * @param timeoutHandler The Function that will be executed if the <code>timeout</code> time is reached prior to
		 * the expected event being dispatched.
		 * 
		 * @return an <code>IResponder</code> that will determine whether the <code>timeout</code> has been reached.
		 */
		CONFIG::useFlexClasses
		function asyncResponder( responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder;
		
		/**
		 * Creates an <code>IAsyncNativeTestResponder</code> that pend and either call the <code>eventHandler</code> or the
		 * <code>timeoutHandler</code>, passing the <code>passThroughData</code>, depending on whether the
		 * <code>timeout</code> period has been reached.
		 * 
		 * @param resultHandler The result function that will be executed if the <code>Responder</code> is called before 
		 * the <code>timeout</code> has expired.
		 * @param faultHandler The fault function that will be executed if the <code>Responder</code> is called before 
		 * the <code>timeout</code> has expired.
		 * @param timeout The length of time, in milliseconds, before the <code>timeoutHandler</code> will be executed.
		 * @param passThroughData An Object that can be given information about the current test; this information will 
		 * be available for both the <code>eventHandler</code> and the <code>timeoutHandler</code>.
		 * @param timeoutHandler The Function that will be executed if the <code>timeout</code> time is reached prior to
		 * the expected event being dispatched.
		 * 
		 * @return a <code>Responder</code> that will determine whether the <code>timeout</code> has been reached.
		 */
		function asyncNativeResponder( resultHandler : Function, faultHandler : Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Responder;
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		CONFIG::useFlexClasses
		function handleBindableNextSequence( event:Event, sequenceRunner:SequenceRunner ):void;
		
		/**
		 * A handler method that is called in order to fail for a given asynchronous event once an it
		 * has been dispatched.
		 * 
		 * @param event The event that was received.
		 * @param passThroughData An Object that contains information to pass to the handler.
		 */
		function failOnComplete( event:Event, passThroughData:Object ):void;
		/**
		 * A handler method that is called in order to wait once an asynchronous event has been dispatched.
		 * 
		 * @param event The event that was received.
		 * @param passThroughData An Object that contains information to pass to the handler.
		 */
		function pendUntilComplete( event:Event, passThroughData:Object=null ):void;
		
		/**
		 * Handles the next steps in a <code>SequenceRunner</code>.
		 * 
		 * @param event The event boradcast by the last step in the sequence.
		 * @param sequenceRunner The runner responsible for running the steps in the sequence.
		 */
		function handleNextSequence( event:Event, sequenceRunner:SequenceRunner ):void;
	}
}