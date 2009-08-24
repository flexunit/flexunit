package org.hamcrest.mxml.text
{
    import flash.events.Event;

    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <ContainsString string="lazy dog" />
     */
    public class ContainsStringTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:ContainsString;

        [Before]
        public function createMatcher():void
        {
            matcher = new ContainsString();
            matcher.string = "fox jump";
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription('a string containing "fox jump"', matcher);
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
