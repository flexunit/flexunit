package org.hamcrest.mxml.collection
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <EveryItem>
       <Between min="{ 100 }" max="{ 1000 }"/>
       </EveryItem>
     */
    public class EveryItemTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:EveryItem;

        [Before]
        public function createMatcher():void
        {
            matcher = new EveryItem();

            var between:Between = new Between();
            between.min = 100;
            between.max = 1000;

            matcher.matcher = between;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("every item is a Number between <100> and <1000>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = [ 100, 101, 999 ];

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = [ 100, 101, 1001 ];

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = [ 100, 101, 999 ];

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = [ 100, 101, 1001 ];

            assertMismatchDescription("an item was <1001>", matcher);
        }
    }
}