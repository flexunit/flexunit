package org.hamcrest.mxml.collection
{
    import org.flexunit.assertThat;
    import org.hamcrest.mxml.collection.Array;
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.object.EqualTo;

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

            matcher.matchers = [ eq(1), eq(2), eq(3) ];
        }
        
        public function eq(value:Number):EqualTo
        {
            var m:EqualTo = new EqualTo();
            m.value = value;
            return m;
        }

        [Test]
        public function hasDescriptionWithNoMatchers():void
        {
            matcher.matchers = [];
            
            assertDescription("[]", matcher);
        }

        [Test]
        public function hasDescriptionWithMatchers():void
        {
            assertDescription("[<1>, <2>, <3>]", matcher);
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
            matcher.target = [ 2, 3, 4 ];

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
            matcher.target = [ 2, 3, 4 ];

            assertMismatchDescription("was [<2>,<3>,<4>]", matcher);
        }
    }
}