package org.hamcrest.mxml.collection
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <EmptyArray />
     */
    public class EmptyArrayTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:EmptyArray;

        [Before]
        public function createMatcher():void
        {
            matcher = new EmptyArray();
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("an empty Array", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = [];

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
            matcher.target = [];

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