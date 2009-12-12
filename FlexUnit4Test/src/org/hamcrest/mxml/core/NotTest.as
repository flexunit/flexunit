package org.hamcrest.mxml.core
{
    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;
    import org.hamcrest.mxml.number.Between;

    /*
       <Not>
       <Between min="{ 2 }" max="{ 8 }" />
       </Not>
     */
    public class NotTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:Not;

        [Before]
        public function createMatcher():void
        {
            var b1:Between = new Between();
            b1.min = 2;
            b1.max = 8;

            matcher = new Not();
            matcher.matcher = b1;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("not a Number between <2> and <8>", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = 9;

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
            matcher.target = 9;

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