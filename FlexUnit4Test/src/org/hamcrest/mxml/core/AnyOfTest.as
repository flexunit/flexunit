package org.hamcrest.mxml.core
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <AnyOf>
       <CloseTo value="{ 7 }" delta="{ 0.5 }"/>
       <CloseTo value="{ 13 }" delta="{ 0.3 }"/>
       </AnyOf>
     */
    public class AnyOfTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:AnyOf;

        [Before]
        public function createMatcher():void
        {
            matcher = new AnyOf();

            var b1:Between = new Between();
            b1.min = 2;
            b1.max = 8;

            var b2:Between = new Between();
            b2.min = 4;
            b2.max = 6;

            matcher.matchers = [ b1, b2 ];
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("(a Number between <2> and <8> or a Number between <4> and <6>)", matcher);
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
            matcher.target = 9;

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = 4;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = 9;

            assertMismatchDescription("was <9>", matcher);
        }
    }
}