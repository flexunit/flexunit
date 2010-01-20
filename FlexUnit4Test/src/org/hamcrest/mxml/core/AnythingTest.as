package org.hamcrest.mxml.core
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <Anything />
     */
    public class AnythingTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:Anything;

        [Before]
        public function createMatcher():void
        {
            matcher = new Anything();
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("ANYTHING", matcher);
        }

        [Test]
        public function matchedIsTrue():void
        {
            matcher.target = 4;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = 4;

            assertMatchedMismatchDescription(matcher);
        }
    }
}