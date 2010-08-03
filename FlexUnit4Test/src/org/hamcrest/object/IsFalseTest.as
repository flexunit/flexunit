package org.hamcrest.object
{
  import org.hamcrest.MatcherAssertTest;

  public class IsFalseTest extends MatcherAssertTest
  {
    [Test]
    public function matchesFalseValue():void 
    {
      assertMatches("should match false", isFalse(), false);
    }

    [Test]
    public function matchesFalseyValue():void 
    {
      assertMatches("should match false", isFalsey(), false);
      assertMatches("should match null", isFalsey(), null);
      assertMatches("should match 0", isFalsey(), 0);
      assertMatches("should match NaN", isFalsey(), NaN);
    }
    
    [Test]
    public function doesNotMatchTruthyValue():void 
    {
      assertDoesNotMatch("should not match true", isFalse(), true);
      assertDoesNotMatch("should not match object", isFalse(), {});
      assertDoesNotMatch("should not match non-zero-length string", isFalse(), " ");
      assertDoesNotMatch("should not match true", isFalsey(), true);
      assertDoesNotMatch("should not match object", isFalsey(), {});
      assertDoesNotMatch("should not match non-zero-length string", isFalsey(), " ");
    }
    
    [Test]
    public function hasAReadableDescription():void 
    {
      assertDescription("is false", isFalse());
      assertDescription("is false", isFalsey());
    }
  }
}