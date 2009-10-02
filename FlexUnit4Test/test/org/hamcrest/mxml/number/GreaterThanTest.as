package org.hamcrest.mxml.number
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <GreaterThan value="{ 3 }" />
     */
    public class GreaterThanTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:GreaterThan;

        [Before]
        public function createMatcher():void
        {
            matcher = new GreaterThan();
            matcher.value = 3;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a value greater than <3>", matcher);
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
            matcher.target = 2;

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = 4;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = 2;

            assertMismatchDescription("<2> was less than <3>", matcher);
        }
    }
}