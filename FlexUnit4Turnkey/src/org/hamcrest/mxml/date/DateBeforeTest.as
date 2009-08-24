package org.hamcrest.mxml.date
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <DateBefore date="{ new Date(1980, 0, 1) }" />
     */
    public class DateBeforeTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:DateBefore;

        [Before]
        public function createMatcher():void
        {
            matcher = new DateBefore();
            matcher.date = new Date(1980, 0, 1);
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a date before <" + (new Date(1980, 0, 1)) + ">", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = new Date(1979, 11, 29);

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = new Date(2009, 5, 8);

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = new Date(1979, 11, 29);

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = new Date(2009, 5, 8);

            assertMismatchDescription("<" + (new Date(2009, 5, 8)) + "> is not before <" + (new Date(1980, 0, 1)) + ">",
                matcher);
        }
    }
}