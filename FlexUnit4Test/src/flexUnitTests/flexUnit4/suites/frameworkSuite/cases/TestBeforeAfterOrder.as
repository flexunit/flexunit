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
	public class TestBeforeAfterOrder {
		protected static var setupOrderArray:Array = new Array();

		[Before]
		public function beginNoOrder():void {
			setupOrderArray.push( "beginNoOrder" );
		}

		[Before(order=1)]
		public function beginOne():void {
			setupOrderArray.push( "beginOne" );
		}

		[Before(order=70)]
		public function beginSeventy():void {
			setupOrderArray.push( "beginSeventy" );
		}

		[Before(order=2)]
		public function beginTwo():void {
			setupOrderArray.push( "beginTwo" );
		}

		[After]
		public function afterNoOrder() : void {
			setupOrderArray.push( "afterNoOrder" );
		}
		
		[After(order=1)]
		public function afterOne():void {
			setupOrderArray.push( "afterOne" );
		}

		[After(order=2)]
		public function afterTwo():void {
			setupOrderArray.push( "afterTwo" );
		}

		[After(order=8)]
		public function afterEight():void {
			setupOrderArray.push( "afterEight" );
		}

		[After(order=30)]
		public function afterThirty():void {
			setupOrderArray.push( "afterThirty" );
		}

		//This depends on the test order also working, so we should always run this test after the method order has been verified
		[Test(order=1)]
	    public function checkingBeforeOrder() : void {
	    	//4 begins
	    	if ( setupOrderArray.length == 4 ) {
	    		Assert.assertEquals( setupOrderArray[ 0 ], "beginNoOrder" );
	    		Assert.assertEquals( setupOrderArray[ 1 ], "beginOne" );
	    		Assert.assertEquals( setupOrderArray[ 2 ], "beginTwo" );
	    		Assert.assertEquals( setupOrderArray[ 3 ], "beginSeventy" );
	    	} else {
	    		Assert.fail("Incorrect number of begin calls");
	    	}
	    }

		[Test(order=2)]
	    public function checkingAfterOrder() : void {
	    	//4 begins
	    	//5 afters
	    	//4 more begins
	    	if ( setupOrderArray.length == 13 ) {
	    		Assert.assertEquals( setupOrderArray[ 4 ], "afterNoOrder" );
	    		Assert.assertEquals( setupOrderArray[ 5 ], "afterOne" );
	    		Assert.assertEquals( setupOrderArray[ 6 ], "afterTwo" );
	    		Assert.assertEquals( setupOrderArray[ 7 ], "afterEight" );
	    		Assert.assertEquals( setupOrderArray[ 8 ], "afterThirty" );
	    	} else {
	    		Assert.fail("Incorrect number of after calls");
	    	}
	    }

	}
}