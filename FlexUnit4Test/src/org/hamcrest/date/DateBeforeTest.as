package org.hamcrest.date
{

    import org.hamcrest.AbstractMatcherTestCase;

    public class DateBeforeTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesDateValuesUsingDateBefore():void
        {
            assertMatches("before", dateBefore(new Date(2000, 1, 1)), new Date(1999, 1, 1));
            assertDoesNotMatch("not before", dateBefore(new Date(2000, 1, 1)), new Date(2011, 1, 1));
        }

        [Test]
        public function comparesDateValuesUsingDateBeforeOrEqualTo():void
        {
            assertMatches("before", dateBeforeOrEqual(new Date(2000, 1, 1)), new Date(2000, 1, 1));
            assertDoesNotMatch("not before", dateBeforeOrEqual(new Date(2000, 1, 1)), new Date(2011, 1, 1));
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a date before <" + new Date(2000, 1, 1) + ">",
                dateBefore(new Date(2000, 1, 1)));
            assertDescription("a date before or equal to <" + new Date(2000, 1, 1) + ">",
                dateBeforeOrEqual(new Date(2000, 1, 1)));
        }
    }
}
