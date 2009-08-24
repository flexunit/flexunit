package org.hamcrest.date
{

    import org.hamcrest.AbstractMatcherTestCase;

    public class DateBetweenTest extends AbstractMatcherTestCase
    {

        [Test]
        public function betweenInclusive():void
        {
            assertMatches("inside range",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1)), new Date(2000, 1, 1));
            assertDoesNotMatch("outside range",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1)), new Date(2100, 1, 1));
        }

        [Test]
        public function betweenExclusive():void
        {
            assertMatches("inside range",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1), true), new Date(1990, 1, 1));
            assertDoesNotMatch("outside range",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1), true), new Date(2000, 1, 1));
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a date between <" + new Date(1900, 1, 1) + "> and <" + new Date(2000, 1, 1) + ">",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1)));
            assertDescription("a date between <" + new Date(1900, 1, 1) + "> and <" + new Date(2000, 1, 1) + "> exclusive",
                dateBetween(new Date(1900, 1, 1), new Date(2000, 1, 1), true));
        }
    }
}
