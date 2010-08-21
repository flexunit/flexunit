package org.hamcrest.mxml.text
{
    import flash.events.Event;

    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <EmptyString />
     */
    public class EmptyStringTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:EmptyString;

        [Before]
        public function createMatcher():void
        {
            matcher = new EmptyString();
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription('an empty String', matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = "   ";

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = "not empty string";

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = "   ";

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = "not empty string";

            assertMismatchDescription("was \"not empty string\"", matcher);
        }
    }
}
