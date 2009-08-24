package org.hamcrest.mxml.number
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <GreaterThanOrEqualTo value="{ 3 }" />
     */
    public class GreaterThanOrEqualToTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:GreaterThanOrEqualTo;

        [Before]
        public function createMatcher():void
        {
            matcher = new GreaterThanOrEqualTo();
            matcher.value = 3;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a value greater than or equal to <3>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 3;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = 2;

            assertNotMatched("not matched if target does not match", matcher);
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
            matcher.target = 2;

            assertMismatchDescription("was <2>", matcher);
        }
    }
}