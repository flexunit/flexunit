package org.hamcrest.mxml.object
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <EqualTo value="3" target="{ someBindableValue }" />
     */
    public class EqualToTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:EqualTo;

        [Before]
        public function createMatcher():void
        {
            matcher = new EqualTo();
            matcher.value = 3;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("<3>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 3;

            assertMatched("", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = 4;

            assertNotMatched("", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = 3;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = 4;

            assertMismatchDescription("was <4>", matcher);
        }
    }
}
