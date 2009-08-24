package org.hamcrest.text
{
    import org.hamcrest.AbstractMatcherTestCase;
    
    public class EmptyStringTest extends AbstractMatcherTestCase
    {
        
        [Test]
        public function matchesAZeroLengthString():void
        {
            assertMatches("zero length string", emptyString(), "");
        }
        
        [Test]
        public function matchesAWhitespaceOnlyString():void
        {
            assertMatches("whitespace only string (spaces)", emptyString(), "   ");
            assertMatches("whitespace only string (tabs)", emptyString(), "\t\t");
            assertMatches("whitespace only string (carriage return)", emptyString(), "\r\r");
            assertMatches("whitespace only string (line feed)", emptyString(), "\n\n");
            assertMatches("whitespace only string (mixed)", emptyString(), "\r\t\n ");
        }
        
        [Test]
        public function doesNotMatchAnStringWithCharacters():void
        {
            assertDoesNotMatch("non-zero length, no whitespace", emptyString(), "hello");
            assertDoesNotMatch("with leading whitespace", emptyString(), "   leading");
            assertDoesNotMatch("with trailing whitespace", emptyString(), "trailing  ");
            assertDoesNotMatch("internal whitespace", emptyString(), "internal \t whitespace");
        }
        
        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("an empty String", emptyString());
        }
    
    }
}