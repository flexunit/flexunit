package org.hamcrest.mxml.number
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <CloseTo value="{ 3 }" delta="{ 2 }" />
     */
    public class CloseToTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:CloseTo;

        [Before]
        public function createMatcher():void
        {
            matcher = new CloseTo();
            matcher.value = 3;
            matcher.delta = 2;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a Number within <2> of <3>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 4;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = 8;

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
            matcher.target = 8;

            assertMismatchDescription("<8> differed by <3>", matcher);
        }
    }
}