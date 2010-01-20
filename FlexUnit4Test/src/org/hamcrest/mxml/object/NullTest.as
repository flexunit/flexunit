package org.hamcrest.mxml.object
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <Null />
     */
    public class NullTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:Null;

        [Before]
        public function createMatcher():void
        {
            matcher = new Null();
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("null", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = null;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = "anything";

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = null;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = "anything";

            assertMismatchDescription('was "anything"', matcher);
        }
    }
}