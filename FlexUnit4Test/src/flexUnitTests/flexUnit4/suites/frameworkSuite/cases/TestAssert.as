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
	import flexunit.framework.AssertionFailedError;
	
	import mx.collections.errors.ItemPendingError;
	
	import org.flexunit.Assert;

    /**
     * @private
     */
	public class TestAssert
	{
		[Test(expected="mx.collections.errors.ItemPendingError")]
	    public function fails2():void
	    {
            throw new ItemPendingError( null );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testFail():void
	    {
            Assert.fail();
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testFailAssertEquals():void
	    {
            Assert.assertEquals( new Object(), new Object() );
	    }
	
	//------------------------------------------------------------------------------
	    public function testAssertEquals():void
	    {
	        var  o : Object = new Object();
	        Assert.assertEquals( o, o );
	        Assert.assertEquals( "5", 5 );
	    }
	
	//------------------------------------------------------------------------------
	
	    public function testAssertEqualsNull():void 
	    {
	        Assert.assertEquals( null, null );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertNullNotEqualsString():void 
	    {
	        Assert.assertEquals( null, "foo" );
	    }
	
	//------------------------------------------------------------------------------

		[Test(expected="flexunit.framework.AssertionFailedError")]	
	    public function testAssertStringNotEqualsNull():void 
	    {
            Assert.assertEquals( "foo", null );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertNullNotEqualsNull():void 
	    {
			Assert.assertEquals( null, new Object() );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test]
	    public function testAssertNull():void 
	    {
			Assert.assertNull( null );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertNullFail():void 
	    {
			Assert.assertNull( new Object() );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test]
	    public function testAssertNotNull():void 
	    {
	    	Assert.assertNotNull( new Object() );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertNotNullFail():void 
	    {
	    	Assert.assertNotNull( null );
	    }
	
	//------------------------------------------------------------------------------

		[Test]	
	    public function testAssertTrue():void
	    {
            Assert.assertTrue( true );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]	
	    public function testAssertTrueFail():void
	    {
            Assert.assertTrue( false );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test]
	    public function testAssertFalse():void
	    {
            Assert.assertFalse( false );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertFalseFail():void
	    {
            Assert.assertFalse( true );
	    }
	
	//------------------------------------------------------------------------------
	
	    public function testAssertStictlyEquals():void 
	    {
	        var  o : Object = new Object();
	        Assert.assertStrictlyEquals( o, o );
	    }

		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertStictlyEqualsFail():void 
	    {
            Assert.assertStrictlyEquals( "5", 5 );
	    }	    
	//------------------------------------------------------------------------------
	
	    public function testAssertStrictlyEqualsNull():void 
	    {
	        Assert.assertStrictlyEquals( null, null );
	    }
	    
	//------------------------------------------------------------------------------
	
		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertNullNotStrictlyEqualsString():void 
	    {
            Assert.assertStrictlyEquals( null, "foo" );
	    }
	
	//------------------------------------------------------------------------------
	
		[Test(expected="flexunit.framework.AssertionFailedError")]
	    public function testAssertStringNotStrictlyEqualsNull():void 
	    {
            Assert.assertStrictlyEquals( "foo", null );
	    }
	
	//------------------------------------------------------------------------------

		[Test(expected="flexunit.framework.AssertionFailedError")]	
	    public function testAssertNullNotStrictlyEqualsNull():void 
	    {
			Assert.assertStrictlyEquals( null, new Object() );
	    }
	}
}