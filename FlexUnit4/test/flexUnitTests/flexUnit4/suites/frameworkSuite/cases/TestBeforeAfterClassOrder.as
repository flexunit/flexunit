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
	import org.flexunit.Assert;

    /**
     * @private
     */
	public class TestBeforeAfterClassOrder {
		protected static var setupOrderArray:Array = new Array();

		[BeforeClass(order=1)]
		public static function beginOne():void {
			setupOrderArray.push( "beginOne" );
		}

		[BeforeClass(order=70)]
		public static function beginSeventy():void {
			setupOrderArray.push( "beginSeventy" );
		}

		[BeforeClass(order=2)]
		public static function beginTwo():void {
			setupOrderArray.push( "beginTwo" );
		}

		[AfterClass(order=1)]
		public static function afterOne():void {
			setupOrderArray.push( "afterOne" );
			if ( setupOrderArray.length != 4 ) {
				Assert.fail( "Incorrect order of AfterClass calls" );
			}
		}

		[AfterClass(order=2)]
		public static function afterTwo():void {
			setupOrderArray.push( "afterTwo" );
			if ( setupOrderArray.length != 5 ) {
				Assert.fail( "Incorrect order of AfterClass calls" );
			}
		}

		[AfterClass(order=8)]
		public static function afterEight():void {
			setupOrderArray.push( "afterEight" );
			if ( setupOrderArray.length != 6 ) {
				Assert.fail( "Incorrect order of AfterClass calls" );
			}
		}

		[AfterClass(order=30)]
		public static function afterThirty():void {
			setupOrderArray.push( "afterThirty" );
			if ( setupOrderArray.length != 7 ) {
				Assert.fail( "Incorrect order of AfterClass calls" );
			}
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