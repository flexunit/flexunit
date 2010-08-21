package org.hamcrest.mxml.number
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <LessThan value="{ 3 }" />
     */
    public class LessThanTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:LessThan;

        [Before]
        public function createMatcher():void
        {
            matcher = new LessThan();
            matcher.value = 3;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a value less than <3>", matcher);
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

            assertMismatchDescription("<4> was not less than <3>", matcher);
        }
    }
}