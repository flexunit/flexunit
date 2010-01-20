package org.hamcrest.mxml.date
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <DateBetween min="{ new Date(1980, 0, 1) }" max="{ new Date(1990, 0, 1) }" />
     */
    public class DateBetweenTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:DateBetween;

        [Before]
        public function createMatcher():void
        {
            matcher = new DateBetween();
            matcher.min = new Date(1980, 0, 1);
            matcher.max = new Date(1990, 0, 1);
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a date between <" + (new Date(1980, 0, 1)) + "> and <" + (new Date(1990, 0, 1)) + ">", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = new Date(1989, 11, 29);

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = new Date(1991, 5, 8);

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = new Date(1989, 11, 29);

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = new Date(1991, 5, 8);

            assertMismatchDescription("was <" + (new Date(1991, 5, 8)) + ">", matcher);
        }
    }
}