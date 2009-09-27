package org.hamcrest.core
{

    import flexunit.framework.*;

    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class AllOfTest extends AbstractMatcherTestCase
    {

        [Test]
        public function evaluatesToTheTheLogicalConjunctionOfTwoOtherMatchers():void
        {

            assertThat("good", allOf(equalTo("good"), equalTo("good")));

            assertThat("good", not(allOf(equalTo("bad"), equalTo("good"))));
            assertThat("good", not(allOf(equalTo("good"), equalTo("bad"))));
            assertThat("good", not(allOf(equalTo("bad"), equalTo("bad"))));
        }

        [Test]
        public function evaluatesToTheTheLogicalConjunctionOfManyOtherMatchers():void
        {

            assertThat("good", allOf(equalTo("good"), equalTo("good"), equalTo("good"), equalTo("good"),
                equalTo("good")));
            assertThat("good", not(allOf(equalTo("good"), equalTo("good"), equalTo("bad"), equalTo("good"),
                equalTo("good"))));
        }

        [Test]
        public function hasAReadableDescription():void
        {

            assertDescription("(\"good\" and \"bad\" and \"ugly\")",
                allOf(equalTo("good"), equalTo("bad"), equalTo("ugly")));
        }

        [Test]
        public function mismatchDescriptionDescribesFirstFailingMatch():void
        {

            assertMismatch("\"good\" was \"bad\"", allOf(equalTo("bad"), equalTo("good")), "bad");
        }
    }
}