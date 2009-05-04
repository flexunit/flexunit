/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/ 
package flexUnitTests.flexUnit4.suites.frameworkSuite.cases {
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.mx_internal;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.AssertionError;
	import org.flexunit.async.Async;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.async.TestResponder;
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	
    /**
     * @private
     */
	public class TestAsynchronous {
		protected var timer:Timer;
		protected static var SHORT_TIME:int = 100;
		protected static var LONG_TIME:int = 250;

		[Before]
		public function setUp():void {
			timer = new Timer( LONG_TIME, 1 );
		}
		
		[After]
		public function tearDown():void {
			if ( timer ) {
				timer.stop();
			}
			
			timer = null;
		}

		[Test(async)]
	    public function testInTimePass() : void {
	    	//We fire in SHORT_TIME mills, but are willing to wait LONG_TIME
	    	timer.delay = SHORT_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this, handleAsyncShouldPass, LONG_TIME, null, handleAsyncShouldNotFail ), false, 0, true ); 
	    	timer.start();
	    }

		[Test(async,expected="flexunit.framework.AssertionFailedError")]
	    public function testInTimeFail() : void {
	    	//We fire in SHORT_TIME mills, but are willing to wait LONG_TIME
	    	timer.delay = SHORT_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  handleAsyncShouldPassCallFail, LONG_TIME, null, handleAsyncShouldNotFail ), false, 0, true ); 
	    	timer.start();
	    }

		[Test(async,expected="TypeError")]
	    public function testInTimeError() : void {
	    	//We fire in SHORT_TIME mills, but are willing to wait LONG_TIME
	    	timer.delay = SHORT_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  handleAsyncShouldPassCauseError, LONG_TIME, null, handleAsyncShouldNotFail ), false, 0, true ); 
	    	timer.start();
	    }
	    
		[Test(async)]
	    public function testTooLatePass() : void {
	    	//We fire in LONG_TIME mills, but are willing to wait SHORT_TIME
	    	timer.delay = LONG_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  handleAsyncShouldNotPass, SHORT_TIME, null, handleAsyncShouldFail ), false, 0, true ); 
	    	timer.start();
	    }

		[Test(async,expected="flexunit.framework.AssertionFailedError")]
	    public function testTooLateFail() : void {
	    	//We fire in LONG_TIME mills, but are willing to wait SHORT_TIME
	    	timer.delay = LONG_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  handleAsyncShouldPass, SHORT_TIME, null, handleAsyncShouldFailCallFail ), false, 0, true ); 
	    	timer.start();
	    }

		[Test(async,expected="TypeError")]
	    public function testTooLateError() : void {
	    	//We fire in LONG_TIME mills, but are willing to wait SHORT_TIME
	    	timer.delay = LONG_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  handleAsyncShouldNotPass, SHORT_TIME, null, handleAsyncShouldFailCauseError ), false, 0, true ); 
	    	timer.start();
	    }
	    
		[Test(async)]
	    public function testNotReallyAsynchronousPass() : void {
	    	//This tests one of the edges that flex unit did not handle well. What if we receive our async event *before*
	    	//this method finishes executing
	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  handleAsyncShouldPassImmediate, SHORT_TIME, null, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    }

		[Test(async,expected="flexunit.framework.AssertionFailedError")]
	    public function testNotReallyAsynchronousFail() : void {
	    	//This tests one of the edges that flex unit did not handle well. What if we receive our async event *before*
	    	//this method finishes executing
	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  handleAsyncShouldPassImmediateCallFail, SHORT_TIME, null, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    }

//Come back to me if ( !asyncHandlingStatement.bodyExecuting ) {

/*  	    public function testNotReallyAsynchronousFailAfterAsync() : void {
	    	//This tests one of the edges that flex unit did not handle well. What if we receive our async event *before*
	    	//this method finishes executing, but then something else in the method execution causes a failure
	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  handleAsyncShouldPassImmediate, SHORT_TIME, null, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    	
	    	//A failure now should still know to mark this method as failed, despite the async completing, verify this
	        try 
	        {
	            Assert.fail();
	        } 
	        catch ( e : AssertionFailedError ) 
	        {
		    	if ( registeredMethod != testNotReallyAsynchronousFailAfterAsync ) {
			    	fail( 'Proceeded to next test method after async before completing method body' );
		    	}
	            return;
	        }
	        throw new AssertionFailedError("Async Fail Uncaught");
	    } */
 
 	    public function testMethodBodyExecuting() : void {
	    	//This is a simple flag which makes a lot of difference. If the methodBodyExecuting flag is set to true, we are still in
	    	//the method body of the test execution and should not consider a test complete. It is important for cases where
	    	//the async may fire before the method body execution if complete
	    	
 			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( this );

	    	if ( !asyncHandlingStatement.bodyExecuting ) {
		    	Assert.fail( 'Method body is executing, but methodBodyExecuting is false' );
	    	}
	    }

		[Test(async)]
	    public function testMethodBodyExecutingPending() : void {
	    	//Ensure the method body executing flag is true if the async event happens before the method body execution is complete
	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  checkMethodBodyExecutingFlagTrue, SHORT_TIME, null, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    }

		[Test(async)]
	    public function testMethodBodyExecutingComplete() : void {
	    	//Ensure the method body executing flag is false if the async event happens after the method body execution is complete
	    	timer.delay = SHORT_TIME;
	    	timer.addEventListener(TimerEvent.TIMER_COMPLETE, Async.asyncHandler( this,  checkMethodBodyExecutingFlagFalse, LONG_TIME, null, handleAsyncShouldNotFail ), false, 0, true ); 
	    	timer.start();
	    }

		[Test(async)]
	    public function testPassThroughDataOnSuccess() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.randomValue = 5;
	    	passThroughData.timer = timer;

	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  checkPassThroughDataOnSuccess, SHORT_TIME, passThroughData, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    }

		[Test(async)]
	    public function testPassThroughDataOnFailure() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.randomValue = 5;
	    	passThroughData.timer = timer;

	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  handleAsyncShouldNotPass, SHORT_TIME, passThroughData, checkPassThroughDataOnTimeout ), false, 0, true );

			//Never dispatch the event. Allow the timeout to occur
			//eventDispatcher.dispatchEvent( new Event('immediate') ); 
	    }

		[Test(async)]
	    public function testEventDataCorrect() : void {
	    	var eventDispatcher:EventDispatcher = new EventDispatcher();
	    	eventDispatcher.addEventListener('immediate', Async.asyncHandler( this,  checkEventData, SHORT_TIME, null, handleAsyncShouldNotFail ), false, 0, true );
	    	eventDispatcher.dispatchEvent( new DataEvent('immediate', false, false, '0123456789' ) ); 
	    }

		[Ignore]
		[Test(async)]
	    public function testMultipleAsyncAllSucceed() : void {
	    	//Run both of these two previous async tests at the same time. FlexUnit had major issues with 'reentrance' and single AsyncHelpers
			testInTimePass();
			testNotReallyAsynchronousPass();
	    }

		[Ignore]
		[Test(async)]
	    public function testMultipleAsyncSuccessAndTimeout() : void {
	    	testTooLateFail();
			testNotReallyAsynchronousPass();
	    }

		[Test(async)]
	    public function testMultipleAsyncFirstReturnsBeforeSecondSuccess() : void {
			testNotReallyAsynchronousPass();
			testInTimePass();
	    }

		[Test(async,expected="flexunit.framework.AssertionFailedError")]
	    public function testMultipleAsyncFirstReturnsBeforeSecondTimeout() : void {
			testNotReallyAsynchronousPass();
			testTooLateFail();
	    }

		[Test(async)]
	    public function testAyncResponderResultWithTestResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new TestResponder( handleIntendedResult, handleUnintendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var result:ResultEvent = new ResultEvent( ResultEvent.RESULT, false, false, {myName:someVO.myName}, token, null );			
			token.mx_internal::applyResult( result );
				    
		}

		[Test(async)]
	    public function testAyncResponderFaultWithTestResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new TestResponder( handleUnintendedResult, handleIntendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var fault:FaultEvent = new FaultEvent( FaultEvent.FAULT );	
			token.mx_internal::applyFault( fault );
				    
		}

		[Test(async)]
	    public function testAyncResponderResultWithIResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new Responder( handleIntendedResultNoPassThrough, handleUnintendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var result:ResultEvent = new ResultEvent( ResultEvent.RESULT, false, false, {myName:someVO.myName}, token, null );			
			token.mx_internal::applyResult( result );
				    
		}

		[Test(async)]
	    public function testAyncResponderFaultWithIResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new Responder( handleUnintendedResult, handleIntendedFaultNoPassThrough ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var fault:FaultEvent = new FaultEvent( FaultEvent.FAULT );	
			token.mx_internal::applyFault( fault );
				    
		}

		/** Helper methods for the tests above beyond this point
		 * 
		 * 
		 * 
		 * **/
		protected function checkEventData( event:DataEvent, passThroughData:Object ):void {
			Assert.assertEquals( event.data, '0123456789' );  
		}

		protected function checkPassThroughDataOnSuccess( event:Event, passThroughData:Object ):void {
			Assert.assertEquals( passThroughData.randomValue, 5 );
			Assert.assertStrictlyEquals( passThroughData.timer, timer );
		}

		protected function checkPassThroughDataOnTimeout( passThroughData:Object ):void {
			Assert.assertEquals( passThroughData.randomValue, 5 );
			Assert.assertStrictlyEquals( passThroughData.timer, timer );
		}

 		protected function checkMethodBodyExecutingFlagTrue( event:Event, passThroughData:Object ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( this );
			
			if ( !asyncHandlingStatement ) {
				Assert.fail( 'Cannot locate current async handler for this test' );
			}

 	    	if ( !asyncHandlingStatement.bodyExecuting ) {
		    	Assert.fail( 'Method body is executing, but methodBodyExecuting is false' );
	    	}
		}

		protected function checkMethodBodyExecutingFlagFalse( event:Event, passThroughData:Object ):void {
			var asyncHandlingStatement:IAsyncHandlingStatement = AsyncLocator.getCallableForTest( this );
			
			if ( !asyncHandlingStatement ) {
				Assert.fail( 'Cannot locate current async handler for this test' );
			}

 	    	if ( asyncHandlingStatement.bodyExecuting ) {
		    	Assert.fail( 'Method body is not executing, but methodBodyExecuting is true' );
	    	}
		} 

	    protected function handleAsyncShouldPassImmediate( event:Event, passThroughData:Object ):void {
	    }

	    protected function handleAsyncShouldPassImmediateCallFail( event:Event, passThroughData:Object ):void {
            Assert.fail();
	    }

	    protected function handleAsyncShouldPass( event:Event, passThroughData:Object ):void {
	    }

	    protected function handleAsyncShouldNotPass( event:Event, passThroughData:Object ):void {
	    	Assert.fail('Timer event received after Timeout Occured');
	    }

	    protected function handleAsyncShouldPassCallFail( event:Event, passThroughData:Object ):void {
            Assert.fail();
	    }

	    protected function handleAsyncShouldPassCauseError( event:Event, passThroughData:Object ):void {
        	//do not instantiate
        	var blah:Date;
        	//Cause an error
        	blah.date = blah.day + 5;
	    }

		//----------------------------------

	    protected function handleAsyncShouldFail( passThroughData:Object ):void {
	    }

	    protected function handleAsyncShouldNotFail( passThroughData:Object ):void {
	    	Assert.fail('Timeout Reached Incorrectly');
	    }

	    protected function handleAsyncShouldFailCallFail( passThroughData:Object ):void {
            Assert.fail();
	    }

	    protected function handleAsyncShouldFailCauseError( passThroughData:Object ):void {
        	//do not instantiate
        	var blah:Date;
        	//Cause an error
        	blah.date = blah.day + 5;
	    }

		protected function handleIntendedResultNoPassThrough( data:Object ):void {			
		}

		protected function handleIntendedResult( data:Object, passThroughData:Object ):void {
			Assert.assertEquals( data.result.myName, passThroughData.myName );
		}

		protected function handleUnintendedResult( info:Object, passThroughData:Object ):void {
			Assert.fail("Responder threw a result when fault was expected");
		}
		
		protected function handleIntendedFaultNoPassThrough( info:Object ):void {			
		}

		protected function handleIntendedFault( info:Object, passThroughData:Object ):void {			
		}

		protected function handleUnintendedFault( info:Object, passThroughData:Object ):void {
			Assert.fail("Responder threw a fault when result was expected");
		}
	}

}