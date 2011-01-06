package org.hamcrest.mxml.collection
{
	import org.hamcrest.collection.InArrayMatcher;
	import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

	public class InArrayTest extends AbstractMXMLMatcherTestCase
	{
	  private var matcher:InArray;
	  
	  [Before]
	  public function createMatcher():void 
	  {
	    matcher = new InArray();
	    matcher.elements = [ 1, 2, 3 ];
	  }
	  
		[Test]
		public function hasDescription():void 
		{
		  assertDescription("contained in [<1>, <2>, <3>]", matcher);
		} 
		
		[Test]
		public function matchedIsTrueIfTargetMatches():void 
		{
		   matcher.target = 2;
		   assertMatched("matched if target matches", matcher);
		}
		
		[Test]
		public function matchedIsFalseIfTargetDoesNotMatch():void 
		{
		  matcher.target = 4;
		  assertNotMatched("not matched if target does not match", matcher);
		}
		
    [Test]
    public function mismatchDescriptionIsNullIfTargetMatches():void
    {
      matcher.target = 2;
      assertMatchedMismatchDescription(matcher);
    }

    [Test]
    public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
    {
      matcher.target = 4;  
      assertMismatchDescription("<4> was not contained in [<1>, <2>, <3>]", matcher);
    }
	}
}