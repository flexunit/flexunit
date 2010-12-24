package org.hamcrest.number
{

    import org.hamcrest.AbstractMatcherTestCase;

    public class GreaterThanTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesValuesUsingGreaterThan():void
        {
            assertMatches("greater than", greaterThan(10), 11);
            assertDoesNotMatch("not greater than", greaterThan(10), 10);
        }

        [Test]
        public function comparesValuesUsingGreaterThanOrEqualTo():void
        {
            assertMatches("greater than", greaterThanOrEqualTo(10), 10);
            assertDoesNotMatch("not greater than", greaterThanOrEqualTo(10), 9);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a value greater than <3>", greaterThan(3));
            assertDescription("a value greater than or equal to <3>", greaterThanOrEqualTo(3));
        }

        [Test]
        public function hasMismatchDescription():void
        {
            assertMismatch("<3> was not greater than <3>", greaterThan(3), 3);
        }

        [Test]
        public function hasMismatchDescriptionIfNotEqualTo():void
        {
            assertMismatch("<2> was not greater than or equal to <3>", greaterThanOrEqualTo(3), 2);
        }
    }
}
