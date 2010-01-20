package org.hamcrest.mxml.object
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <NotNull />
     */
    public class NotNullTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:NotNull;

        [Before]
        public function createMatcher():void
        {
            matcher = new NotNull();
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("not null", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 9;

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
            matcher.target = 9;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = null;

            assertMismatchDescription("was null", matcher);
        }
    }
}