package org.hamcrest.date
{

    import org.hamcrest.AbstractMatcherTestCase;

    public class DateAfterTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesDatesUsingDateAfter():void
        {
            assertMatches("after", dateAfter(new Date(2000, 1, 1)), new Date(2002, 1, 1));
            assertDoesNotMatch("not after", dateAfter(new Date(2000, 1, 1)), new Date(2000, 1, 1));
        }

        [Test]
        public function comparesDatesUsingDateAfterOrEqualTo():void
        {
            assertMatches("after", dateAfterOrEqual(new Date(2000, 1, 1)), new Date(2000, 1, 1));
            assertDoesNotMatch("not after", dateAfterOrEqual(new Date(2000, 1, 1)), new Date(1999, 1, 1));
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a date after <" + new Date(1980, 1, 1) + ">",
                dateAfter(new Date(1980, 1, 1)));
            assertDescription("a date after or equal to <" + new Date(1980, 1, 1) + ">",
                dateAfterOrEqual(new Date(1980, 1, 1)));
        }
    }
}
