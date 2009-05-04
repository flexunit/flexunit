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
package org.flexunit.internals.runners.statements {
	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.IResponder;
	
	import org.flexunit.Assert;
	import org.flexunit.async.AsyncHandler;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.async.AsyncTestResponder;
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

	public class ExpectAsync extends AsyncStatementBase implements IAsyncStatement, IAsyncHandlingStatement {
		private var objectUnderTest:Object;
		private var statement:IAsyncStatement;
		private var returnMessageSent:Boolean = false;
		
		private var testComplete:Boolean;
		private var pendingAsyncCalls:Array;

		private var methodBodyExecuting:Boolean = false;
		
		public function get bodyExecuting():Boolean {
			return methodBodyExecuting;
		}

		public function get hasPendingAsync():Boolean {
			return ( pendingAsyncCalls.length > 0 );
		}

		private function protect( method:Function, ... rest ):void {
			try {
				if ( rest && rest.length>0 ) {
					method.apply( this, rest );
				} else {
					method();
				}
			} catch (error:Error) {
				sendComplete( error );
			}
		}

		private function removeAsyncEventListeners( asyncHandler:AsyncHandler ):void {
			asyncHandler.removeEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false );
			asyncHandler.removeEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false );
		}
		
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

		public function asyncResponder( responder:*, timeout:int, passThroughData:Object = null, timeoutHandler:Function = null ):IResponder { 

			if ( !( ( responder is IResponder ) || ( responder is ITestResponder ) ) ) {
				throw new Error( "Object provided to responder parameter of asyncResponder is not a IResponder or ITestResponder" );
			}

			var asyncResponder:AsyncTestResponder = new AsyncTestResponder( responder );

			var asyncHandler:AsyncHandler = new AsyncHandler( this, handleAsyncTestResponderEvent, timeout, passThroughData, timeoutHandler )
			asyncHandler.addEventListener( AsyncHandler.EVENT_FIRED, handleAsyncEventFired, false, 0, true );
			asyncHandler.addEventListener( AsyncHandler.TIMER_EXPIRED, handleAsyncTimeOut, false, 0, true );

			pendingAsyncCalls.push( asyncHandler );

			asyncResponder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, asyncHandler.handleEvent, false, 0, true ); 

			return asyncResponder;
		}

		private function removeAllAsyncEventListeners():void {
			for ( var i:int=0; i<pendingAsyncCalls.length; i++ ) {
				removeAsyncEventListeners( pendingAsyncCalls[ i ] as AsyncHandler );
			}
		}

		private function handleAsyncTimeOut( event:Event ):void {
			var asyncHandler:AsyncHandler = event.target as AsyncHandler; 
			var failure:Boolean = false;
			
			removeAsyncEventListeners( asyncHandler );

			if ( asyncHandler.timeoutHandler != null ) {
				protect( asyncHandler.timeoutHandler, asyncHandler.passThroughData ); 
			} else {
				failure = true;
				sendComplete( new Error( "Timeout Occurred before expected event" ) );
				//protect( Assert.fail, "Timeout Occurred before expected event" );
			}

			//Remove all future pending items
			removeAllAsyncEventListeners();
			pendingAsyncCalls = new Array();
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

		private function handleAsyncEventFired( event:AsyncEvent ):void {
			//Receiving this event is a good things... IF it is the first one we are waiting for
			//If it is not the first one on the stack though, we still need to fail.
			var asyncHandler:AsyncHandler = event.target as AsyncHandler;
			var firstPendingAsync:AsyncHandler;
			var failure:Boolean = false;
			
			removeAsyncEventListeners( asyncHandler );
			
			if ( hasPendingAsync ) {
				firstPendingAsync = pendingAsyncCalls.shift() as AsyncHandler;
				
				if ( firstPendingAsync === asyncHandler ) {
					if ( asyncHandler.eventHandler != null  ) {
						//this actually needs to be the event object from the previous event
						protect( asyncHandler.eventHandler, event.originalEvent, firstPendingAsync.passThroughData );  
					}
				} else {
					//The first one on the stack is not the one we received. 
					//We received this one out of order, which is a failure condition
					failure = true;
					sendComplete( new Error( "Asynchronous Event Received out of Order" ) );
					//protect( Assert.fail, "Asynchronous Event Received out of Order" ); 
				}
			} else {
				//We received an event, but we were not waiting for one, failure
				//protect( Assert.fail, "Unexpected Asynchronous Event Occurred" );
				failure = true; 
				sendComplete( new Error( "Unexpected Asynchronous Event Occurred" ) );				
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

	    public function handleNextSequence( event:Event, sequenceRunner:SequenceRunner ):void {
			if ( event && event.target ) {
				//Remove the listener for this particular item
		    	event.currentTarget.removeEventListener(event.type, handleNextSequence );
			}

			sequenceRunner.continueSequence( event );
			
			startAsyncTimers();
	    }

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










		private function startAsyncTimers():void {
			for ( var i:int=0; i<pendingAsyncCalls.length; i++ ) {
				( pendingAsyncCalls[ i ] as AsyncHandler ).startTimer();
			}
		}

		override protected function sendComplete( error:Error = null ):void {
			if ( !testComplete ) {
				methodBodyExecuting = false;
				testComplete = true;
				AsyncLocator.cleanUpCallableForTest( objectUnderTest );
				removeAllAsyncEventListeners();
				pendingAsyncCalls = new Array();
				parentToken.sendResult( error );			
			}
		}
		
		private function getObjectForRegistration( obj:Object ):Object {
			var registrationObj:Object;

			if ( obj is TestClass ) {
				registrationObj = ( obj as TestClass ).asClass;
			} else {
				registrationObj = obj;
			}
			
			return registrationObj;
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
 			this.parentToken = parentToken;
 			AsyncLocator.registerStatementForTest( this, getObjectForRegistration( objectUnderTest ) );

			methodBodyExecuting = true;
 			statement.evaluate( myToken );
 			methodBodyExecuting = false;
		}

		public function pendUntilComplete( event:Event, passThroughData:Object=null ):void {
		}

		public function failOnComplete( event:Event, passThroughData:Object ):void {
			sendComplete( new Error( "Unexpected event received" ) );
		}

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

		public static function hasAsync( method:FrameworkMethod, type:String="Test" ):Boolean {
			var async:String = method.getSpecificMetaDataArg( type, "async" );
			var asyncBool:Boolean = ( async == "true" ); 
			 
			return asyncBool;			
		}

		public function ExpectAsync( objectUnderTest:Object, statement:IAsyncStatement ) {
			this.objectUnderTest = objectUnderTest;
			this.statement = statement;
			
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleNextExecuteComplete );
			
			pendingAsyncCalls = new Array();
		}
	}
}