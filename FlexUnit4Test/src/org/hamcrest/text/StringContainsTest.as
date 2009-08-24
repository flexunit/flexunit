package org.hamcrest.text
{

    import org.hamcrest.*;
    import org.hamcrest.core.*;

    import org.flexunit.Assert;

    public class StringContainsTest extends AbstractMatcherTestCase
    {

        private static const EXCERPT:String = "EXCERPT";

        private var stringContains:Matcher;

        [Before]
        public function setUp():void
        {
            stringContains = containsString(EXCERPT);
        }

        [Test]
        public function evaluatesToTrueIfArgumentContainsSpecifiedSubstring():void
        {
            assertMatches("should be true if excerpt at beginning",
                stringContains, EXCERPT + "END");

            assertMatches("should be true if excerpt at end",
                stringContains, "START" + EXCERPT);

            assertMatches("should be true if excerpt in middle",
                stringContains, "START" + EXCERPT + "END");

            assertMatches("should be true if excerpt is repeated",
                stringContains, EXCERPT + EXCERPT);

            assertDoesNotMatch("should not be true if excerpt is not in string",
                stringContains, "Something else");

            assertDoesNotMatch("should not be true if part of excerpt is in string",
                stringContains, EXCERPT.substring(1));
        }

        [Test]
        public function evaluatesToTrueIfArgumentIsEqualToSubstring():void
        {
            assertMatches("should be true if excerpt is entire string", stringContains, EXCERPT);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a string containing \"EXCERPT\"", stringContains);
        }
    }
}
