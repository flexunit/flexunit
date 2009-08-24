package org.flexunit.demo {

   import org.flexunit.Assert;
   
   public class SampleTest {
      [Test]
      public function testSampleFailure() : void {
         Assert.fail("FAIL! - This is a sample test that will fail.");
      }

      [Test]
      public function testSampleError() : void {
         throw new Error("ERROR! - This is an error");
      }
      
      [Ignore]
      [Test]
      public function testSampleIgnore() : void {
         
      }
   }
}