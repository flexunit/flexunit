package org.hamcrest.mxml.object
{
  import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

  public class IsFalseTest extends AbstractMXMLMatcherTestCase
  {
    private var matcher:IsFalse;
    
    [Before]
    public function createMatcher():void 
    {
      matcher = new IsFalse();
    }
    
    [Test]
    public function hasDescription():void 
    {
      assertDescription("is false", matcher);
    }
    
    [Test]
    public function matchedIsFalseIfTargetMatches():void 
    {
      matcher.target = false;
      
      assertMatched("should match false", matcher);
    }
    
    [Test]
    public function matchedIsFalseIfTargetDoesNotMatch():void 
    {
      matcher.target = true;
      
      assertNotMatched("should not match true", matcher);
    }
    
    [Test]
    public function mismatchDescriptionIsNullIfTargetMatched():void 
    {
      matcher.target = false;
      
      assertMatchedMismatchDescription(matcher);
    }
    
    [Test]
    public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void 
    {
      matcher.target = true;
      
      assertMismatchDescription("was <true>", matcher);
    }
  }
}