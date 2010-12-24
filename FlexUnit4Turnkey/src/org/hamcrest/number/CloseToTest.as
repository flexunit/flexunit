package org.hamcrest.number
{
    import org.flexunit.assertThat;
    import org.hamcrest.AbstractMatcherTestCase;

    public class CloseToTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesValuesWithinThreshold():void
        {
            assertMatches("close enough", closeTo(1, 0.5), 1.5);
            assertDoesNotMatch("too far", closeTo(1, 0.5), 1.6);
        }
        
        [Test]
        public function compareValuesWithSmallThreshold():void 
        {
            assertMatches("close enough", closeTo(2, 0.1), 1.9);
            assertMatches("close enough 2", closeTo(2, 0.01), 1.99);
            assertMatches("close enough 3", closeTo(2, 0.001), 1.999);
            assertMatches("close enough 4", closeTo(2, 0.0001), 1.9999);
            assertMatches("close enough 5", closeTo(2, 0.00001), 1.99999);
            assertMatches("close enough 6", closeTo(2, 0.000001), 1.999999);
            assertMatches("close enough 7", closeTo(2, 0.0000001), 1.9999999);
            assertMatches("close enough 9", closeTo(2, 0.00000001), 1.99999999);
            assertMatches("close enough 9", closeTo(2, 0.000000001), 1.999999999);
            assertMatches("close enough 10", closeTo(2, 0.0000000001), 1.9999999999);
            assertMatches("close enough 11", closeTo(2, 0.00000000001), 1.99999999999);
            
            assertDoesNotMatch("too far 2", closeTo(2, 0.01), 1.98);
            assertDoesNotMatch("too far 3", closeTo(2, 0.001), 1.998);
            assertDoesNotMatch("too far 4", closeTo(2, 0.0001), 1.9998);
            assertDoesNotMatch("too far 5", closeTo(2, 0.00001), 1.99998);
            assertDoesNotMatch("too far 6", closeTo(2, 0.000001), 1.999998);
            assertDoesNotMatch("too far 7", closeTo(2, 0.0000001), 1.9999998);
            assertDoesNotMatch("too far 8", closeTo(2, 0.00000001), 1.99999998);
            assertDoesNotMatch("too far 9", closeTo(2, 0.000000001), 1.999999998);
            assertDoesNotMatch("too far 10", closeTo(2, 0.0000000001), 1.9999999998);
            assertDoesNotMatch("too far 11", closeTo(2, 0.00000000001), 1.99999999998);
            
            // after 12 decimal places it is anyones game.
            // you should probably use a different tool if you need to match with that precision. 
            // assertDoesNotMatch("too far 12", closeTo(2, 0.000000000001), 1.999999999998);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a Number within <0.1> of <3>", closeTo(3, 0.1));
        }
        
        [Test]
        public function describesMismatch():void 
        {
            assertMismatch(
                "<1.94> differed by <0.01>",
                closeTo(2, 0.05), 
                1.94);
        }
    }
}
