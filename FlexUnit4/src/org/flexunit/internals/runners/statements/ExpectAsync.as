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
package org.flexunit.internals.runners.statements {
	import flash.events.Event;
	import flash.net.Responder;
	import flash.utils.Dictionary;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.IResponder;
	
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.flexunit.async.AsyncHandler;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.async.AsyncNativeTestResponder;
	import org.flexunit.async.AsyncTestResponder;
	import org.flexunit.async.IAsyncTestResponder;
	import org.flexunit.async.ITestResponder;
	import org.flexunit.events.AsyncEvent;
	import org.flexunit.events.AsyncResponseEvent;
	import org.flexunit.internals.flexunit_internal;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.runners.model.TestClass;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;
	import org.fluint.sequence.SequenceBindingWaiter;
	import org.fluint.sequence.SequenceRunner;
	
	use namespace flexunit_internal;
	
	/**
	 * The <code>ExpectAsync</code> is a decorator that is responsible for determing 
	 * whether a specific test method is expecting an asynchronous response.  As this 
	 * infrastructure carries overhead, we only create it when the user specifics a 
	 * given test is asynchronous.  The class implements <code>IAsyncHandlingStatement</code> 
	 * and works with the <code>Async</code> class.<br/>
	 * 
	 * In order to expect an asynchronous response, a test method must include metadata indicating 
	 * it is expecting asynchronous functionality.<br/>
	 * 
	 * <pre><code>
	 * [Test(async)]
	 * public function asyncTest():void {
	 * 	//Test with asynchronous functionality
	 * }
	 * </code></pre>
	 * 
	 * @see org.flexunit.async.Async
	 */
	public class ExpectAsync extends AsyncStatementBase implements IAsyncStatement, IAsyncHandlingStatement {
		/**
		 * @private
		 */
		private var objectUnderTest:Object;
		/**
		 * @private
		 */
		private var statement:IAsyncStatement;
		/**
		 * @private
		 */
		private var returnMessageSent:Boolean = false;
		
		/**
		 * @private
		 */
		private var testComplete:Boolean;
		/**
		 * @private
		 */
		private var pendingAsyncCalls:Array;
		/**
		 * @private
		 */
		private var asyncFailureConditions:Dictionary;
		
		/**
		 * @private
		 */
		private var methodBodyExecuting:Boolean = false;
		
		/**
		 * Returns a Boolean value indicating whether the test method is current executing.
		 */
		public function get bodyExecuting():Boolean {
			return methodBodyExecuting;
		}
		
		/**
		 * Returns a Boolean value indicating whether there are still any pending asynchronous calls.
		 */
		public function get hasPendingAsync():Boolean {
			return ( pendingAsyncCalls.length > 0 );
		}
		
		/**
		 * Attempts to call the provided <code>method</code> with the provided <code>rest</code> parameters.
		 * 
		 * @param method The Function to call with the provided <code>rest</code> parameters.
		 * @param rest The parameters supplied to the <code>method</code>.
		 */
		protected function protect( method:Function, ... rest ):void {
			try {
				if ( rest && rest.length>0 ) {
					method.apply( this, rest );
				} else {
					method();
				}
				
				if ( hasPendingAsync ) { 
					startAsyncTimers(); 
				} 
			
			} 
			catch (error:Error) {
				sendComplete( error );
			}
			
		}
		
		/**
		 * Removes asynchronous event listeners from the provided <code>asyncHandler</code>.
		 * 
		 * @param asyncHandler The <code>AsyncHandler</code> from which to remove the event listeners.
		 */
		private function removeAsyncEventListeners( asyncHandler:AsyncHandler ):void {
			asyncHandler.removeEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false );
			asyncHandler.removeEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false );
		}
		
		/**
		 * Removes asynchronous error event listeners from the provided <code>asyncHandler</code>.
		 * 
		 * @param asyncHandler The <code>AsyncHandler</code> from which to remove the error event listeners.
		 */
		private function removeAsyncErrorEventListeners( asyncHandler:AsyncHandler ):void {
			asyncHandler.removeEventListener( AsyncHandler.EVENT_FIRED, handleAsyncErrorFired, false );
			asyncHandler.removeEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false );
		}
		
		/**
		 * 
		 * 
		 * 
		 * @internal TODO:: This needs to be cleaned up and revised... just a prototype
		 * @param eventHandler
		 * @param timeout
		 * @param passThroughData
		 * @param timeoutHandler
		 * 
		 * @throws Error Test Completed, but additional async event added
		 * 
		 * @return 
		 * 
		 */
		public function asyncErrorConditionHandler( eventHandler:Function ):Function {
			if ( testComplete ) {
				sendComplete( new Error("Test Completed, but additional async event added") );
			}

			var asyncHandler:AsyncHandler = new AsyncHandler( this, eventHandler )
			asyncHandler.addEventListener( AsyncHandler.EVENT_FIRED, handleAsyncErrorFired, false, 0, true );
			//asyncHandler.addEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false, 0, true );

			asyncFailureConditions[ asyncHandler ] = true; 

			return asyncHandler.handleEvent;
		}
		
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
		public function asyncHandler( eventHandler:Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Function { 
			if ( testComplete ) {
				sendComplete( new Error("Test Completed, but additional async event added") );
			}

			var asyncHandler:AsyncHandler = new AsyncHandler( this, eventHandler, timeout, passThroughData, timeoutHandler )
			asyncHandler.addEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false, 0, true );
			asyncHandler.addEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false, 0, true );

			pendingAsyncCalls.push( asyncHandler );

			return asyncHandler.handleEvent;
		}
		
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
		public function asyncResponder( responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder { 

			var asyncResponder:IAsyncTestResponder;

			if ( !( ( responder is IResponder ) || ( responder is ITestResponder ) ) ) {
				throw new Error( "Object provided to responder parameter of asyncResponder is not a IResponder or ITestResponder" );
			}

			/**If the user passes use an IAsyncTestResponder of their own, then we do not need to wrap it in our own AsyncTestResponder class
			 * This allows the use of a different type of responder than our standard, however, it is the responsibility of the IAsyncTestResponder
			 * we are passed to dispatch the requisite AsyncResponseEvent events in response to a result or fault.
			 * 
			 * In your own code, you can therefore do something like:
			 * 
			 * asyncResponder( IResponder, timeout );
			 * 
			 * OR
			 * 
			 * asyncResponder( mySpecialResponder implements IAsyncTestResponder, timeout );
			 * 
			 * */
			if ( responder is IAsyncTestResponder ) {
				asyncResponder = responder;
			} else {
				asyncResponder = new AsyncTestResponder( responder );
			}

			var asyncHandler:AsyncHandler = new AsyncHandler( this, handleAsyncTestResponderEvent, timeout, passThroughData, timeoutHandler )
			asyncHandler.addEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false, 0, true );
			asyncHandler.addEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false, 0, true );

			pendingAsyncCalls.push( asyncHandler );

			asyncResponder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, asyncHandler.handleEvent, false, 0, true ); 

			return asyncResponder;
		}
		
		/**
		 * Removes all asynchronous event listeners for each pending asynchronous call.
		 */
		private function removeAllAsyncEventListeners():void {
			for ( var i:int=0; i<pendingAsyncCalls.length; i++ ) {
				removeAsyncEventListeners( pendingAsyncCalls[ i ] as AsyncHandler );
			}
			
			pendingAsyncCalls = new Array();
			
			for ( var handler:* in asyncFailureConditions ) {
				removeAsyncErrorEventListeners( handler as AsyncHandler );
			} 
			
			asyncFailureConditions = new Dictionary( true );
		}
		
		/**
		 * Called when the asynchronous timeout has been reached for a given test.  This method attempts to
		 * call a timeout handler that has been associated with the asychronous test.  If no handler has
		 * been specified, an error will be generated and the <code>ExpectAsync</code> statement finishes.
		 * 
		 * @param event The event associated with the asynchronous timeout.
		 */
		private function handleAsyncTimeOut( event:Event ):void {
			var asyncHandler:AsyncHandler = event.target as AsyncHandler; 
			var failure:Boolean = false;
			
			removeAsyncEventListeners( asyncHandler );
			
			//Run the timeout handler if one exists; otherwise, send an error
			if ( asyncHandler.timeoutHandler != null ) {
				protect( asyncHandler.timeoutHandler, asyncHandler.passThroughData ); 
			} else {
				failure = true;				
				sendComplete( new AssertionError( "Timeout Occurred before expected event" ) );
				//protect( Assert.fail, "Timeout Occurred before expected event" );
			}

			//Remove all future pending items
			removeAllAsyncEventListeners();			
			/**
			var methodResult:TestMethodResult = testMonitor.getTestMethodResult( registeredMethod );
			if ( methodResult && ( !methodResult.traceInformation ) ) {
				methodResult.executed = true;
				methodResult.testDuration = getTimer()-tickCountOnStart;
				methodResult.traceInformation = "Test completed via Async TimeOut in " + methodResult.testDuration + "ms";
			}
			**/
			//Our timeout has failed, declare this specific test complete and move along
			sendComplete();
		}

		/**
		 * Handles the AsyncResponseEvent that is thrown by the asyncResponder.
		 * It sends data to the original responder based on if it is a result or fault status.
		 * 
		 * If the original responder is of type ITestResponder, then the passThroughData is passed to it.
		 * 
		 * @param event
		 * @param passThroughData
		 * 
		 */
		protected function handleAsyncTestResponderEvent( event:AsyncResponseEvent, passThroughData:Object=null ):void {
			var originalResponder:* = event.originalResponder;
			var isTestResponder:Boolean = false;
			
			if ( originalResponder is ITestResponder ) {
				isTestResponder = true;
			}
			
			if ( event.status == 'result' ) {
				if ( isTestResponder ) {
					originalResponder.result( event.data, passThroughData );
				} else {
					originalResponder.result( event.data );					
				}
			} else {
				if ( isTestResponder ) {
					originalResponder.fault( event.data, passThroughData );
				} else {
					originalResponder.fault( event.data );					
				}
			}
		}
		
		private function handleAsyncErrorFired( event:AsyncEvent ):void {			
			var message:String = "Failing due to Async Event ";
			if ( event && event.originalEvent ) {
				message += String( event.originalEvent );
			}

			sendComplete( new AssertionError( message ) );
		}
		
		/**
		 * Called when the asynchronous event has been fired prior to the timeout being reached.  This method attempts to
		 * call event handler that has been associated with the asychronous test.  If no handler has
		 * been specified, an error will be generated and the <code>ExpectAsync</code> statement finishes.
		 * 
		 * @param event The <code>AsyncEvent</code> event that has been dispatched.
		 */
		private function handleAsyncEventFired( event:AsyncEvent ):void {
			//Receiving this event is a good things... IF it is the first one we are waiting for
			//If it is not the first one on the stack though, we still need to fail.
			var asyncHandler:AsyncHandler = event.target as AsyncHandler;
			var firstPendingAsync:AsyncHandler;
			var failure:Boolean = false;
			
			removeAsyncEventListeners( asyncHandler );
			
			//Determine if any async calls remain
			if ( hasPendingAsync ) {
				//Get the first async call
				firstPendingAsync = pendingAsyncCalls.shift() as AsyncHandler;
				
				//Determine if this was the expected async handler
				if ( firstPendingAsync === asyncHandler ) {
					if ( asyncHandler.eventHandler != null  ) {
						//this actually needs to be the event object from the previous event
						protect( asyncHandler.eventHandler, event.originalEvent, firstPendingAsync.passThroughData );  
					}
				} else {
					//The first one on the stack is not the one we received. 
					//We received this one out of order, which is a failure condition
					failure = true;
					sendComplete( new AssertionError( "Asynchronous Event Received out of Order" ) );
					//protect( Assert.fail, "Asynchronous Event Received out of Order" ); 
				}
			} else {
				//We received an event, but we were not waiting for one, failure
				//protect( Assert.fail, "Unexpected Asynchronous Event Occurred" );
				failure = true; 
				sendComplete( new AssertionError( "Unexpected Asynchronous Event Occurred" ) );				
			}
			
			if ( !hasPendingAsync && !methodBodyExecuting && !failure ) {
				//We have no more pending async, *AND* the method body of the function that originated this message
				//has also finished, then let the test runner know
				/**
				var methodResult:TestMethodResult = testMonitor.getTestMethodResult( registeredMethod );
				if ( methodResult && ( !methodResult.traceInformation )  ) {
					methodResult.executed = true;
					methodResult.testDuration = getTimer()-tickCountOnStart;
					methodResult.traceInformation = "Test completed via Async Event in " + methodResult.testDuration + "ms";
				}
				**/
				sendComplete();			
			}
			
		}
		
		/**
		 * Handles the next steps in a <code>SequenceRunner</code>.
		 * 
		 * @param event The event boradcast by the last step in the sequence.
		 * @param sequenceRunner The runner responsible for running the steps in the sequence.
		 */
	    public function handleNextSequence( event:Event, sequenceRunner:SequenceRunner ):void {
			if ( event && event.target ) {
				//Remove the listener for this particular item
		    	event.currentTarget.removeEventListener(event.type, handleNextSequence );
			}

			sequenceRunner.continueSequence( event );
			
			startAsyncTimers();
	    }
		
		/**
		 * Creates an <code>IAsyncTestResponder</code> that pend and either call the <code>eventHandler</code> or the
		 * <code>timeoutHandler</code>, passing the <code>passThroughData</code>, depending on whether the
		 * <code>timeout</code> period has been reached.
		 * 
		 * @param resultHandler The result <code>Function</code> that will be executed if the <code>Responder</code> is called on its result before 
		 * the <code>timeout</code> has expired.
		 * @param faultHandler The fault <code>Function</code> that will be executed if the <code>Responder</code> is called on its fault before 
		 * the <code>timeout</code> has expired.
		 * @param timeout The length of time, in milliseconds, before the <code>timeoutHandler</code> will be executed.
		 * @param passThroughData An Object that can be given information about the current test; this information will 
		 * be available for both the <code>eventHandler</code> and the <code>timeoutHandler</code>.
		 * @param timeoutHandler The Function that will be executed if the <code>timeout</code> time is reached prior to
		 * the expected event being dispatched.
		 * 
		 * @return an <code>IResponder</code> that will determine whether the <code>timeout</code> has been reached.
		 */
		public function asyncNativeResponder( resultHandler : Function, faultHandler : Function, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):Responder { 
			
			var asyncResponder:AsyncNativeTestResponder;
			
			asyncResponder = new AsyncNativeTestResponder( resultHandler, faultHandler );
			
			var asyncHandler:AsyncHandler = new AsyncHandler( this, handleAsyncNativeTestResponderEvent, timeout, passThroughData, timeoutHandler )
			asyncHandler.addEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false, 0, true );
			asyncHandler.addEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false, 0, true );
			
			pendingAsyncCalls.push( asyncHandler );
			
			asyncResponder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, asyncHandler.handleEvent, false, 0, true ); 
			
			return asyncResponder;
		}
		
		/**
		 * Handles the AsyncResponseEvent that is thrown by the asyncResponder.
		 * It sends data to the original responder based on if it is a result or fault status.
		 * 
		 * @param event
		 * @param passThroughData
		 * 
		 */
		protected function handleAsyncNativeTestResponderEvent( event:AsyncResponseEvent, passThroughData:Object=null ):void {
			var methodHandler:Function = event.methodHandler;
			methodHandler.call(this, event.data);
		}
		
		/**
		 * 
		 * @param event
		 * @param sequenceRunner
		 * 
		 */
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		CONFIG::useFlexClasses
	    public function handleBindableNextSequence( event:Event, sequenceRunner:SequenceRunner ):void {
	    	if ( sequenceRunner.getPendingStep() is SequenceBindingWaiter ) {

				var sequenceBinding:SequenceBindingWaiter = sequenceRunner.getPendingStep() as SequenceBindingWaiter;

		        if (event is PropertyChangeEvent) {
		            var propName:Object = PropertyChangeEvent(event).property
		
		            if (propName != sequenceBinding.propertyName) {
		                Assert.fail( "Incorrect Property Change Event Received" );
		            }
		        } 
		        
		        if ( event && event.target ) {
					//Remove the listener for this particular item
					sequenceBinding.changeWatcher.unwatch();
			    	
			    	//event.currentTarget.removeEventListener(event.type, handleBindableNextSequence );
	
					sequenceRunner.continueSequence( event );
					
					startAsyncTimers();
				} 
	    	} else {
				Assert.fail( "Event Received out of Order" ); 
	    	}
	    }
		
		/**
		 * Starts the timers for each pending asynchronous call.
		 */
		private function startAsyncTimers():void {
			for ( var i:int=0; i<pendingAsyncCalls.length; i++ ) {
				( pendingAsyncCalls[ i ] as AsyncHandler ).startTimer();
			}
		}
		
		/**
		 * If the test has not yet been marked as complete, mark the <code>ExpectAsync</code> statement as having finished
		 * and notify the parent token.
		 * 
		 * @param error The potential error to send to the parent token.
		 */
		override protected function sendComplete( error:Error = null ):void {
			//If the test has not completed, do not notify the parentToken that this statement has finished executing
			if ( !testComplete ) {
				methodBodyExecuting = false;
				testComplete = true;
				AsyncLocator.cleanUpCallableForTest( objectUnderTest );
				removeAllAsyncEventListeners();
				parentToken.sendResult( error );
			}
		}
		
		/**
		 * Retrieves the object used for registering this <code>ExpectAsync</code> which
		 * implements <code>IAsyncHandlingStatement</code> 
		 * 
		 * @param obj The object used to obtain the registration object.
		 */
		private function getObjectForRegistration( obj:Object ):Object {
			var registrationObj:Object;

			if ( obj is TestClass ) {
				registrationObj = ( obj as TestClass ).asClass;
			} else {
				registrationObj = obj;
			}
			
			return registrationObj;
		}
		
		/**
		 * Registers the <code>ExpectAsync</code> statment for the current object being tested and evaluates the object that 
		 * implements the <code>IAsyncStatement</code> that was provided to the <code>ExpectAsync</code> class.
		 * 
		 * @param parentToken The token to be notified when the potential asynchronous call have finished.
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
 			this.parentToken = parentToken;
			
			//Register this statement with the current object that is being tested
 			AsyncLocator.registerStatementForTest( this, getObjectForRegistration( objectUnderTest ) );

			methodBodyExecuting = true;
 			statement.evaluate( myToken );
 			methodBodyExecuting = false;
		}
		
		/**
		 * A handler method that is called in order to wait once an asynchronous event has been dispatched.
		 * 
		 * @param event The event that was received.
		 * @param passThroughData An Object that contains information to pass to the handler.
		 */
		public function pendUntilComplete( event:Event, passThroughData:Object=null ):void {
		}
		
		/**
		 * A handler method that is called in order to fail for a given asynchronous event once an it
		 * has been dispatched.
		 * 
		 * @param event The event that was received.
		 * @param passThroughData An Object that contains information to pass to the handler.
		 */
		public function failOnComplete( event:Event, passThroughData:Object ):void {
			var message:String = "Unexpected event received ";
			if ( event ) {
				message += String( event );
			}
			
			sendComplete( new AssertionError( message ) );
		}
		
		/**
		 * Determines if there are any more pending asynchronous calls; if there are, keep running the calls if there are 
		 * no errors.  If all calls have finished or an error was encountered in the <code>result</code>, report the error
		 * to the parent token and stop tracking the asynchronous events.
		 * 
		 * @param result The <code>ChildResult</code> to check to see if there is an error.
		 */
		public function handleNextExecuteComplete( result:ChildResult ):void {
			
			if ( pendingAsyncCalls.length == 0 ) {
				//we are all done, no more pending asyncs, we can go on and live a good life for the few moments before we are gced				
				sendComplete( result.error );
				//parentToken.sendResult( result.error );
			} else {
				if ( result && result.error ) {
					//If we already have an error, we need to report it now, not coninue
					sendComplete( result.error );
				} else {
					startAsyncTimers();
				}
			}
		}
		
		/**
		 * Determine if the <code>method</code> is asynchronous for a test method that is of the expected 
		 * metadata <code>type</code>.
		 * 
		 * @param method The <code>FrameworkMethod</code> that is potentially asynchronous.
		 * @param type The expected metadata type of the test method (ex: "Test", "Before", "After").
		 * 
		 * @return a Boolean value indicating whether the provided <code>method</code> is asynchronous.
		 */
		public static function hasAsync( method:FrameworkMethod, type:String="Test" ):Boolean {
			var async:String = method.getSpecificMetaDataArgValue( type, "async" );
			var asyncBool:Boolean = ( async == "true" ); 
			 
			return asyncBool;			
		}
		
		/**
		 * Constructor.
		 * 
		 * @param objectUnderTest The current object that is being tested.
		 * @param statement The current <code>IAsyncStatement</code> that will be decorated with the
		 * the <code>ExpectAsync</code> class.
		 */
		public function ExpectAsync( objectUnderTest:Object, statement:IAsyncStatement ) {
			this.objectUnderTest = objectUnderTest;
			this.statement = statement;
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
			
			pendingAsyncCalls = new Array();
			asyncFailureConditions = new Dictionary( true );
		}
	}
}