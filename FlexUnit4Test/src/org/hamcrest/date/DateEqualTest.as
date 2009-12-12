package org.hamcrest.date
{
    import org.hamcrest.AbstractMatcherTestCase;

    public class DateEqualTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesDatesUsingDateEqual():void
        {
            assertMatches("equal", dateEqual(new Date(2002, 1, 1)), new Date(2002, 1, 1));
            assertDoesNotMatch("not equal", dateEqual(new Date(2002, 1, 1)), new Date(2000, 1, 1));
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("a date equal to <" + new Date(1980, 1, 1) + ">",
                dateEqual(new Date(1980, 1, 1)));
        }
    }
}
