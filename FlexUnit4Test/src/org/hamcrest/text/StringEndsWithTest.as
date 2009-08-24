package org.hamcrest.text
{

    import org.hamcrest.*;
    import org.hamcrest.core.*;

    import org.flexunit.Assert;

    public class StringEndsWithTest extends AbstractMatcherTestCase
    {

        private static const EXCERPT:String = "EXCERPT";

        private var stringEndsWith:Matcher;

        [Before]
        public function setUp():void
        {
            stringEndsWith = endsWith(EXCERPT);
        }

        [Test]
        public function evaluatesToTrueIfArgumentContainsSpecifiedSubstring():void
        {
            assertDoesNotMatch("should be false if excerpt at beginning",
                stringEndsWith, EXCERPT + "END");

            assertMatches("should be true if excerpt at end",
                stringEndsWith, "START" + EXCERPT);

            assertDoesNotMatch("should be false if excerpt in middle",
                stringEndsWith, "START" + EXCERPT + "END");

            assertMatches("should be true if excerpt is at end and repeated",
                stringEndsWith, EXCERPT + EXCERPT);

            assertDoesNotMatch("should be false if excerpt is not in string",
                stringEndsWith, "Something else");

            assertDoesNotMatch("should be false if part of excerpt is at end of string",
                stringEndsWith, EXCERPT.substring(0, EXCERPT.length - 2));
        }

        [Test]
        public function evaluatesToTrueIfArgumentIsEqualToSubstring():void
        {
            assertMatches("should be true if excerpt is entire string",
                stringEndsWith, EXCERPT);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a string ending with \"EXCERPT\"", stringEndsWith);
        }
    }
}
