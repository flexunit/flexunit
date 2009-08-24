package org.hamcrest.mxml.collection
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.object.EqualTo;

    /*
       <HasItem>
       <EqualTo value="{ 3 }"/>
       </HasItem>
     */
    public class HasItemTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:HasItem;

        [Before]
        public function createMatcher():void
        {
            matcher = new HasItem();

            var eq:EqualTo = new EqualTo();
            eq.value = 3;

            matcher.matcher = eq;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("an Array containing <3>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = [ 1, 2, 3 ];

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = [ 4, 5, 6 ];

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = [ 1, 2, 3 ];

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = [ 4, 5, 6 ];

            assertMismatchDescription("was [<4>,<5>,<6>]", matcher);
        }
    }
}