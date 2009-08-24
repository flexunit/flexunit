package org.hamcrest.mxml.object
{
    import flash.events.Event;
    
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    
    /*
       <HasProperty property="" />
       <HasProperty property="" value="" />
     */
    public class HasPropertyWithValueTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:HasProperty;
        
        [Before]
        public function createMatcher():void
        {
            matcher = new HasProperty();
            matcher.property = "type";
            matcher.value = "added";
        }
        
        [Test]
        public function hasDescription():void
        {
            assertDescription('has property "type" with "added"', matcher);
        }
        
        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = new Event(Event.ADDED);
            
            assertMatched("matched if target matches", matcher);
        }
        
        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = null;
            
            assertNotMatched("not matched if target does not match", matcher);
        }
        
        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = new Event(Event.ADDED);
            
            assertMatchedMismatchDescription(matcher);
        }
        
        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = null;
            
            assertMismatchDescription('no property "type" on null object', matcher);
        }
    }
}
