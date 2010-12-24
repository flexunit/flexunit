package org.hamcrest.mxml.object
{
  import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

  public class IsTrueTest extends AbstractMXMLMatcherTestCase
  {
    private var matcher:IsTrue;
    
    [Before]
    public function createMatcher():void 
    {
      matcher = new IsTrue();
    }
    
    [Test]
    public function hasDescription():void 
    {
      assertDescription("is true", matcher);
    }
    
    [Test]
    public function matchedIsTrueIfTargetMatches():void 
    {
      matcher.target = true;
      
      assertMatched("should match true", matcher);
    }
    
    [Test]
    public function matchedIsFalseIfTargetDoesNotMatch():void 
    {
      matcher.target = false;
      
      assertNotMatched("should not match false", matcher);
    }
    
    [Test]
    public function mismatchDescriptionIsNullIfTargetMatched():void 
    {
      matcher.target = true;
      
      assertMatchedMismatchDescription(matcher);
    }
    
    [Test]
    public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void 
    {
      matcher.target = false;
      
      assertMismatchDescription("was <false>", matcher);
    }
  }
}