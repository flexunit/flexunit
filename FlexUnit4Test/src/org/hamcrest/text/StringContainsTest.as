package org.hamcrest.text
{
    import org.hamcrest.*;
    import org.hamcrest.core.*;

    import org.flexunit.Assert;

    public class StringContainsTest extends AbstractMatcherTestCase
    {
        private static const EXCERPT:String = "EXCERPT";

        private var stringContains:Matcher;
        private var stringContainsIgnoreCase:Matcher;

        [Before]
        public function setUp():void
        {
            stringContains = containsString(EXCERPT);
            stringContainsIgnoreCase = containsString(EXCERPT, true);
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
        public function evaluatesToTrueIfArgumentContainsSpecifiedSubstringIgnoringCase():void 
        {
            assertMatches("should be true if excerpt at beginning",
                stringContainsIgnoreCase, 
                EXCERPT.toLowerCase() + "END");

            assertMatches("should be true if excerpt at end",
                stringContainsIgnoreCase, 
                "START" + EXCERPT.toLowerCase());

            assertMatches("should be true if excerpt in middle",
                stringContainsIgnoreCase, 
                "START" + EXCERPT.toLowerCase() + "END");

            assertMatches("should be true if excerpt is repeated",
                stringContainsIgnoreCase, 
                EXCERPT.toLowerCase() + EXCERPT);

            assertDoesNotMatch("should not be true if excerpt is not in string",
                stringContainsIgnoreCase, 
                "Something else");

            assertDoesNotMatch("should not be true if part of excerpt is in string",
                stringContainsIgnoreCase, 
                EXCERPT.toLowerCase().substring(1));
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
