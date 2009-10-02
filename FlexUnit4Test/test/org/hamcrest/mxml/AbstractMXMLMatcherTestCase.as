package org.hamcrest.mxml
{
    import org.flexunit.Assert;

    public class AbstractMXMLMatcherTestCase extends Assert
    {
        public function assertMatched(message:String, matcher:MXMLMatcher):void
        {
            assertTrue(message, matcher.matched);
        }

        public function assertNotMatched(message:String, matcher:MXMLMatcher):void
        {
            assertFalse(message, matcher.matched);
        }

        public function assertDescription(expected:String, matcher:MXMLMatcher):void
        {
            assertEquals("Expected description", expected, matcher.description);
        }

        public function assertMatchedMismatchDescription(matcher:MXMLMatcher):void
        {
            assertTrue("Precondition: Matcher should be matched", matcher.matched);
            assertEquals("Expected mismatch description to be an empty string", "", matcher.mismatchDescription);
        }

        public function assertMismatchDescription(expected:String, matcher:MXMLMatcher):void
        {
            assertFalse("Precondition: Matcher should not be matched", matcher.matched);
            assertEquals("Expected mismatch description", expected, matcher.mismatchDescription);
        }
    }
}