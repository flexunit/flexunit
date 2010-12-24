package org.hamcrest.number
{

    import org.hamcrest.AbstractMatcherTestCase;

    public class LessThanTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesValuesUsingLessThan():void
        {
            assertMatches("less than", lessThan(10), 9);
            assertDoesNotMatch("not less than", lessThan(10), 11);
        }

        [Test]
        public function comparesValuesUsingLessThanOrEqualTo():void
        {
            assertMatches("less than", lessThanOrEqualTo(10), 10);
            assertDoesNotMatch("not less than", lessThanOrEqualTo(10), 11);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a value less than <3>", lessThan(3));
            assertDescription("a value less than or equal to <3>", lessThanOrEqualTo(3));
        }

        [Test]
        public function hasMismatchDescription():void
        {
            assertMismatch("<3> was not less than <3>", lessThan(3), 3);
        }

        [Test]
        public function hasMismatchDescriptionIfNotEqualTo():void
        {
            assertMismatch("<4> was not less than or equal to <3>", lessThanOrEqualTo(3), 4);
        }
    }
}
