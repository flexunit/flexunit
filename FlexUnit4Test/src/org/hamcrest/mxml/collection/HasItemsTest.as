package org.hamcrest.mxml.collection
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.object.EqualTo;

    /*
       <HasItems>
       <EqualTo value="{ 3 }"/>
       <EqualTo value="{ 4 }"/>
       </HasItems>
     */
    public class HasItemsTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:HasItems;

        [Before]
        public function createMatcher():void
        {
            matcher = new HasItems();

            var eq1:EqualTo = new EqualTo();
            eq1.value = 1;

            var eq3:EqualTo = new EqualTo();
            eq3.value = 3;

            matcher.matchers = [ eq1, eq3 ];
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("(an Array containing <1> and an Array containing <3>)", matcher);
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

            assertMismatchDescription("an Array containing <1> was [<4>,<5>,<6>]", matcher);
        }
    }
}