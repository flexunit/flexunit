package org.hamcrest.mxml.core
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <DescribedAs message="a value between %0 rocks and %1 hard places" values="{[ 2, 8 ]}">
       <Between min="{ 2 }" max="{ 8 }" />
       </DescribedAs>
     */
    public class DescribedAsTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:DescribedAs;

        [Before]
        public function createMatcher():void
        {
            var b1:Between = new Between();
            b1.min = 2;
            b1.max = 8;

            matcher = new DescribedAs();
            matcher.matcher = b1;
            matcher.message = "a value between %0 rocks and %1 hard places";
            matcher.values = [ 2, 8 ];

        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("a value between <2> rocks and <8> hard places", matcher);
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