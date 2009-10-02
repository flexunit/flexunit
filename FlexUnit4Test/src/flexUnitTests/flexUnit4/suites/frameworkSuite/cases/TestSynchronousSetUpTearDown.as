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
	public class TestSynchronousSetUpTearDown {
		protected var simpleValue:Number;
		protected var complexObject:Object;
		protected var unitializedBySetup:Object;

		[Before]
		public function setUp():void {
			simpleValue = 5;
			complexObject = new Object();
			complexObject.key = 99;
		}

		[After]		
		public function tearDown():void {
			simpleValue = -1;
			complexObject = null;
			unitializedBySetup = null;
		}
		
		/**
		 * These tests are a little different, we don't ever know the sequence
		 * that are tests will run, so each is going to do a little extra checking
		 * to ensure teardown did actually run 
		 */
		[Test]
	    public function testSetupCreatedComplexObj() : void {
	    	testTearDownDidNotAllowPersist();
	    	Assert.assertNotNull( complexObject );
	    	testInitializeValueForTearDown();
	    }

		[Test]
	    public function testSetupCreatedSimpleVal() : void {
	    	testTearDownDidNotAllowPersist();
	    	Assert.assertEquals( simpleValue, 5 );
	    	testInitializeValueForTearDown();
	    }

		[Test]
	    public function testInitializeValueForTearDown() : void {
	    	unitializedBySetup = new Object();
	    }

		[Test]
	    public function testTearDownDidNotAllowPersist() : void {
	    	Assert.assertNull( unitializedBySetup );
	    }
	}
}