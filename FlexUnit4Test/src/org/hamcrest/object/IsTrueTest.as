package org.hamcrest.object
{
  import org.hamcrest.MatcherAssertTest;

  public class IsTrueTest extends MatcherAssertTest
  {
    [Test]
    public function matchesTrueValue():void 
    {
      assertMatches("should match true", isTrue(), true);
    }
    
    [Test]
    public function matchesTruthyValue():void 
    {
      assertMatches("should match true", isTruthy(), true);
      assertMatches("should match object", isTruthy(), {});
      assertMatches("should match non-zero-length string", isTruthy(), " ");
    }
    
    [Test]
    public function doesNotMatchFalseyValue():void 
    {
      assertDoesNotMatch("should not match false", isTrue(), false);
      assertDoesNotMatch("should not match null", isTrue(), null);
      assertDoesNotMatch("should not match 0", isTrue(), 0);
      assertDoesNotMatch("should not match NaN", isTrue(), NaN);
      assertDoesNotMatch("should not match false", isTruthy(), false);
      assertDoesNotMatch("should not match null", isTruthy(), null);
      assertDoesNotMatch("should not match 0", isTruthy(), 0);
      assertDoesNotMatch("should not match NaN", isTruthy(), NaN);
    }
    
    [Test]
    public function hasAReadableDescription():void 
    {
      assertDescription("is true", isTrue());
      assertDescription("is true", isTruthy());
    }
  }
}