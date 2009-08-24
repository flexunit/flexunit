package org.hamcrest.mxml.number
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <Between min="{ 3 }" max="{ 7 }" />
     */
    public class BetweenTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:Between;

        [Before]
        public function createMatcher():void
        {
            matcher = new Between();
            matcher.min = 3;
            matcher.max = 7;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a Number between <3> and <7>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 4;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = 8;

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = 3;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = 8;

            assertMismatchDescription("was <8>", matcher);
        }
    }
}