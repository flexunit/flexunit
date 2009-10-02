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
	public class TestMethodOrder {
		protected static var testOneComplete:Boolean = false;
		protected static var testTwoComplete:Boolean = false;
		protected static var testThreeComplete:Boolean = false;
		protected static var testFourComplete:Boolean = false;
		protected static var testNinetyComplete:Boolean = false;

		[Test(order=1)]
	    public function testOrderOne() : void {
	    	testOneComplete = true;
	    	
	    	Assert.assertFalse( testTwoComplete );
	    	Assert.assertFalse( testThreeComplete );
	    	Assert.assertFalse( testFourComplete );
	    	Assert.assertFalse( testNinetyComplete );
	    }

		[Test(order=2)]
	    public function testOrderTwo() : void {
	    	testTwoComplete = true;

	    	Assert.assertTrue( testOneComplete );
	    	Assert.assertFalse( testThreeComplete );
	    	Assert.assertFalse( testFourComplete );
	    	Assert.assertFalse( testNinetyComplete );

	    }

		[Test(order=4)]
	    public function testOrderFour() : void {
	    	testFourComplete = true;

	    	Assert.assertTrue( testOneComplete );
	    	Assert.assertTrue( testTwoComplete );
	    	Assert.assertTrue( testThreeComplete );
	    	Assert.assertFalse( testNinetyComplete );

	    }

		[Test(order=90)]
	    public function testOrderNinety() : void {
	    	testNinetyComplete = true;

	    	Assert.assertTrue( testOneComplete );
	    	Assert.assertTrue( testTwoComplete );
	    	Assert.assertTrue( testThreeComplete );
	    	Assert.assertTrue( testFourComplete );

	    }

		[Test(order=3)]
	    public function testOrderThree() : void {
	    	testThreeComplete = true;

	    	Assert.assertTrue( testOneComplete );
	    	Assert.assertTrue( testTwoComplete );
	    	Assert.assertFalse( testFourComplete );
	    	Assert.assertFalse( testNinetyComplete );

	    }
	}
}