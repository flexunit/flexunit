package org.hamcrest.mxml.collection
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <ArrayWithSize size="{ 4 }" />
     */
    public class ArrayWithSizeTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:ArrayWithSize;

        [Before]
        public function createMatcher():void
        {
            matcher = new ArrayWithSize();
            matcher.size = 4;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("an Array with size <4>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = [ 1, 2, 3, 4 ];

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = [ 2, 3, 4 ];

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = [ 1, 2, 3, 4 ];

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = [ 2, 3, 4 ];

            assertMismatchDescription("was [<2>,<3>,<4>]", matcher);
        }
    }
}