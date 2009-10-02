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
package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

    /**
     * @private
     */
	public class TestBeforeAfterClassOrderAsync {
		private static const TIMER_LENGTH:int = 10;
		private static const TIME_OUT:int = 15;

		private static var timer:Timer = new Timer( TIMER_LENGTH, 1 );
		protected static var setupOrderArray:Array = new Array();

		[BeforeClass(async,order=1)]
		public static function beginOne():void {
			setupOrderArray.push( "beginOne" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[BeforeClass(async,order=70)]
		public static function beginSeventy():void {
			setupOrderArray.push( "beginSeventy" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[BeforeClass(async,order=2)]
		public static function beginTwo():void {
			setupOrderArray.push( "beginTwo" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[AfterClass(async,order=1)]
		public static function afterOne():void {
			setupOrderArray.push( "afterOne" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[AfterClass(async,order=2)]
		public static function afterTwo():void {
			setupOrderArray.push( "afterTwo" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[AfterClass(async,order=8)]
		public static function afterEight():void {
			setupOrderArray.push( "afterEight" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		[AfterClass(async,order=30)]
		public static function afterThirty():void {
			setupOrderArray.push( "afterThirty" );
			timer.reset();
			Async.proceedOnEvent( TestBeforeAfterClassOrderAsync, timer, TimerEvent.TIMER_COMPLETE, TIME_OUT );
			timer.start();
		}

		//This depends on the test order also working, so we should always run this test after the method order has been verified
		[Test(order=1)]
	    public function checkingBeforeOrder() : void {
	    	//3 begins
	    	if ( setupOrderArray.length == 3 ) {
	    		Assert.assertEquals( setupOrderArray[ 0 ], "beginOne" );
	    		Assert.assertEquals( setupOrderArray[ 1 ], "beginTwo" );
	    		Assert.assertEquals( setupOrderArray[ 2 ], "beginSeventy" );
	    	} else {
	    		Assert.fail("Incorrect number of begin calls");
	    	}
	    }

		[Test(order=2)]
	    public function checkingAfterOrder() : void {
	    	//3 begins
	    	//0 afters at this point
	    	//unlike the other tests for before and after, with BeforeClass and AfterClass, we need to ensure they did *not* run again before this method
	    	checkingBeforeOrder();
	    }
	}
}