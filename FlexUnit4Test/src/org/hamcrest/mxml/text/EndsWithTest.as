package org.hamcrest.mxml.text
{
    import flash.events.Event;

    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <StartsWith string="The quick" />
     */
    public class EndsWithTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:EndsWith;

        [Before]
        public function createMatcher():void
        {
            matcher = new EndsWith();
            matcher.string = "lazy dog";
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription('a string ending with "lazy dog"', matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = "The quick brown fox jumps over the lazy dog"

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
            matcher.target = "The quick brown fox jumps over the lazy dog";

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
