package org.hamcrest.mxml.collection
{
    import org.flexunit.assertThat;
    import org.hamcrest.mxml.collection.Array;
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.object.equalTo;

    /*
       <Array>
       <EqualTo value="{ 1 }"/>
       <EqualTo value="{ 2 }"/>
       <EqualTo value="{ 3 }"/>
       </Array>
     */
    public class ArrayTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:org.hamcrest.mxml.collection.Array;

        [Before]
        public function createMatcher():void
        {
            matcher = new org.hamcrest.mxml.collection.Array();
        }

        [Test]
        public function hasDescriptionWithNoMatchers():void
        {
            assertDescription("[]", matcher);
        }

        [Test]
        public function hasDescriptionWithMatchers():void
        {
            matcher.matchers = [
                equalTo(1),
                equalTo(2),
                equalTo(3)
                ];

            assertDescription("[<1>, <2>, <3>]", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.matchers = [
                equalTo(1),
                equalTo(2),
                equalTo(3)
                ];
            matcher.target = [ 1, 2, 3 ];

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.matchers = [
                equalTo(1),
                equalTo(2),
                equalTo(3)
                ];
            matcher.target = [ 2, 3, 4 ];

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.matchers = [
                equalTo(1),
                equalTo(2),
                equalTo(3)
                ];
            matcher.target = [ 1, 2, 3 ];

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.matchers = [
                equalTo(1),
                equalTo(2),
                equalTo(3)
                ];
            matcher.target = [ 2, 3, 4 ];

            assertMismatchDescription("was [<2>,<3>,<4>]", matcher);
        }
    }
}