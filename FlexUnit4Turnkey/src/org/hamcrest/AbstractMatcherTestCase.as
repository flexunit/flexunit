package org.hamcrest
{

    import org.flexunit.Assert;

    public class AbstractMatcherTestCase extends Assert
    {

        public function assertMatches(message:String, matcher:Matcher, arg:Object):void
        {
            assertTrue(message, matcher.matches(arg));
        }

        public function assertDoesNotMatch(message:String, matcher:Matcher, arg:Object):void
        {
            assertFalse(message, matcher.matches(arg));
        }

        public function assertDescription(expected:String, matcher:Matcher):void
        {
            var description:Description = new StringDescription();
            description.appendDescriptionOf(matcher);
            assertEquals("Expected description", expected, description.toString());
        }

        public function assertMismatch(expected:String, matcher:Matcher, arg:Object):void
        {
            assertFalse("Precondition: Matcher should not match item.", matcher.matches(arg));

            var description:Description = new StringDescription();            
            description.appendMismatchOf(matcher, arg);
            assertEquals("Expected mismatch description", expected, description.toString());
        }
    }
}
