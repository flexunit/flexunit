/*
   Copyright (c) 2008. Adobe Systems Incorporated.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

     * Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
     * Neither the name of Adobe Systems Incorporated nor the names of its
       contributors may be used to endorse or promote products derived from this
       software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
*/

package flexUnitTests.flexUnit1.framework
{
   import flexunit.framework.*;
   
   public class TestAssert extends TestCase
   {      
      public function TestAssert( name : String = null )
      {
         super( name );
      }
      
      override public function setUp() : void
      {
        Assert.resetAssertionsMade();
      }
      
      //---------------------------------------------------------------------------
      
      public function testMatch() : void
      {
        Assert.assertMatch(
             /fr.*gt/,
             "feeefrbgbgbggt" );
      
        Assert.assertMatch(
             /.*@adobe\.com/,
             "xagnetti@adobe.com" );
      
        Assert.assertMatch(
             /.*@adobe.?com/,
             "xagnetti@adobevcom" );
        
        try
        {
           Assert.assertMatch(
             /.*@adobe\.com/,
             "xagnetti@adobevcom" );             
        }
        catch ( e : AssertionFailedError ) 
        {
           assertAssertionsHaveBeenMade( 4 );
       
           return;
        }
        fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testNoMatch() : void
      {
        Assert.assertNoMatch(
             /fr.*gtj/,
             "feeefrbgbgbggt" );
      
        Assert.assertNoMatch(
             /.*@adobe\.com/,
             "xagnetti@free.com" );
      
        Assert.assertNoMatch(
             /.*@adobe.?com/,
             "xagnetti@adobe.co" );
        
        try
        {
           Assert.assertNoMatch(
             /.*@adobe\.com/,
             "xagnetti@adobe.com" );
        }
        catch ( e : AssertionFailedError ) 
        {
           assertAssertionsHaveBeenMade( 4 );
           return;
        }
        fail();
      }       
      
      //---------------------------------------------------------------------------
      
      public function testContained() : void
      {
        Assert.assertContained(
             "rbgbg",
             "feeefrbgbgbggt" );
      
        Assert.assertContained(
             "adobe.com",
             "xagnetti@adobe.com" );
      
        Assert.assertContained(
             "xagnetti",
             "xagnetti@adobe.co" );
        
        try
        {
           Assert.assertContained(
             "adobe",
             "free.fr" );
        }
        catch ( e : AssertionFailedError ) 
        {
           assertAssertionsHaveBeenMade( 4 );
      
           return;
        }
        fail();
      }       
      
      //---------------------------------------------------------------------------
      
      public function testNotContained() : void
      {
        Assert.assertNotContained(
             "abc",
             "feeefrbgbgbggt" );
      
        Assert.assertNotContained(
             "adobe.com",
             "xagnetti@free.com" );
      
        Assert.assertNotContained(
             "kglossy",
             "xagnetti@adobe.co" );
        
        try
        {
           Assert.assertNotContained(
             "free",
             "free.fr" );
        }
        catch ( e : AssertionFailedError ) 
        {
           assertAssertionsHaveBeenMade( 4 );
           return;
        }
        fail();
      }       
      
      //---------------------------------------------------------------------------
      
      public function testFail() : void
      {
         try 
         {
             fail();
         } 
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 0 );
             return;
         }
         throw new AssertionFailedError( "fail uncaught" );
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertEquals() : void
      {
         var  o : Object = new Object();
         Assert.assertEquals( o, o );
         Assert.assertEquals( "5", 5 );
         try 
         {
             Assert.assertEquals( new Object(), new Object() );
         } 
         catch ( e : AssertionFailedError )  
         {
             assertAssertionsHaveBeenMade( 3 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertObjectEquals() : void
      {
         var o1 : Object = new Object();
         o1.firstname = "Yaniv";
         o1.lastname = "De Ridder";
         
         var o2 : Object = new Object();
         o2.firstname = "Yaniv";
         o2.lastname = "De Ridder";
         
         Assert.assertObjectEquals( o1, o2 );

         try 
         {
            o2.firstname = "";
            
            Assert.assertObjectEquals( o1, o2 );
         } 
         catch ( e : AssertionFailedError )  
         {
             assertAssertionsHaveBeenMade( 2 );
      
             return;
         }
         
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertEqualsNull() : void 
      {
         Assert.assertEquals( null, null );
         
         assertAssertionsHaveBeenMade( 1 );
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertEqualsNaN() : void 
      {
         Assert.assertEquals( NaN, NaN );
         try
         {
            Assert.assertEquals( NaN, new Object() );
         }
         catch ( e : AssertionFailedError )  
         {
             try
             {
                Assert.assertEquals( NaN, null );
             }
             catch ( e : AssertionFailedError )
             {
                assertAssertionsHaveBeenMade( 3 );
                return;
             }
         }
         fail();         
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNullNotEqualsString() : void 
      {
         try 
         {
             Assert.assertEquals( null, "foo" );
             fail();
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );
         }
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertStringNotEqualsNull() : void 
      {
         try 
         {
             Assert.assertEquals( "foo", null );
             fail();
         }
         catch ( e : AssertionFailedError ) 
         {
             Assert.assertEquals( "expected:<foo> but was:<null>", e.message );
      
             assertAssertionsHaveBeenMade( 2 );
         }
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNullNotEqualsNull() : void 
      {
         try 
         {
             Assert.assertEquals( null, new Object() );
         }
         catch ( e : AssertionFailedError ) 
         {
             Assert.assertEquals( 
                   "expected:<null> but was:<[object Object]>", 
                   e.message );
      
             assertAssertionsHaveBeenMade( 2 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNull() : void 
      {
         try 
         {
             Assert.assertNull( new Object() );
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNotNull() : void 
      {
         try 
         {
             Assert.assertNotNull( null );
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertTrue() : void
      {
         try 
         {
             Assert.assertTrue( false );
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertFalse() : void
      {
         try 
         {
             Assert.assertFalse( true );
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertStictlyEquals() : void 
      {
         var  o : Object = new Object();
         
         Assert.assertStrictlyEquals( o, o );
         try 
         {
             Assert.assertStrictlyEquals( "5", 5 );
         } 
         catch ( e : AssertionFailedError )  
         {
             assertAssertionsHaveBeenMade( 2 );
      
             return;
         }
         fail();
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertStrictlyEqualsNull() : void 
      {
         Assert.assertStrictlyEquals( null, null );
      
         assertAssertionsHaveBeenMade( 1 );
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNullNotStrictlyEqualsString() : void 
      {
         try 
         {
             Assert.assertStrictlyEquals( null, "foo" );
             fail();
         }
         catch ( e : AssertionFailedError ) 
         {
             assertAssertionsHaveBeenMade( 1 );              
         }
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertStringNotStrictlyEqualsNull() : void 
      {
         try 
         {
             Assert.assertStrictlyEquals( "foo", null );
             fail();
         }
         catch ( e : AssertionFailedError ) 
         {
             Assert.assertEquals( "expected:<foo> but was:<null>", e.message );
      
             assertAssertionsHaveBeenMade( 2 );
         }
      }
      
      //---------------------------------------------------------------------------
      
      public function testAssertNullNotStrictlyEqualsNull() : void 
      {
         try 
         {
             Assert.assertStrictlyEquals( null, new Object() );
         }
         catch ( e : AssertionFailedError ) 
         {
             Assert.assertEquals( 
                   "expected:<null> but was:<[object Object]>",
                   e.message );
      
             assertAssertionsHaveBeenMade( 2 );
                   
             return;
         }
         fail();
      }
      
      public function testAssertionsMade() : void
      {
         Assert.resetEveryAsserionsFields();
         
         assertEquals(
            "",
            0,
            Assert.assetionsMade );

         assertEquals(
            "",
            0,
            Assert.maxAssertionsMade );

         assertEquals(
            "",
            2,
            Assert.totalAssertionsMade );
         
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         
         assertEquals(
            "",
            7,
            Assert.assetionsMade );

         assertEquals(
            "",
            0,
            Assert.maxAssertionsMade );

         assertEquals(
            "",
            9,
            Assert.totalAssertionsMade );
         
         Assert.resetAssertionsMade();
         
         assertEquals(
            "",
            0,
            Assert.assetionsMade );

         assertEquals(
            "",
            10,
            Assert.maxAssertionsMade );

         assertEquals(
            "",
            12,
            Assert.totalAssertionsMade );
         
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         Assert.oneAssertionHasBeenMade();
         
         assertEquals(
            "",
            11,
            Assert.assetionsMade );

         assertEquals(
            "",
            10,
            Assert.maxAssertionsMade );

         assertEquals(
            "",
            23,
            Assert.totalAssertionsMade );
         
         Assert.resetAssertionsMade();
         
         assertEquals(
            "",
            0,
            Assert.assetionsMade );

         assertEquals(
            "",
            14,
            Assert.maxAssertionsMade );

         assertEquals(
            "",
            26,
            Assert.totalAssertionsMade );
      }
      
      private function assertAssertionsHaveBeenMade( assetionsMade : Number ) : void
      {
        Assert.assertEquals(
          "Assert.assetionsMade is not correct",
          assetionsMade,
          Assert.assetionsMade )
      }
   }
}
