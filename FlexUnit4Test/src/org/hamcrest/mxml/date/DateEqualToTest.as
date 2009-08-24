package org.hamcrest.mxml.date
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <DateEqualTo date="{ new Date(1980, 0, 1) }" />
     */
    public class DateEqualToTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:DateEqualTo;

        [Before]
        public function createMatcher():void
        {
            matcher = new DateEqualTo();
            matcher.date = new Date(1980, 0, 1);
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a date equal to <" + (new Date(1980, 0, 1)) + ">", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = new Date(1980, 0, 1);

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
            matcher.target = new Date(1980, 0, 1);

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = new Date(2009, 5, 8);

            assertMismatchDescription("<" + (new Date(2009, 5, 8)) + "> is not the same as <" + (new Date(1980, 0, 1)) +
                ">",
                matcher);
        }
    }
}