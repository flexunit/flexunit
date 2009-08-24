package org.hamcrest.core
{

    import org.hamcrest.*;

    public class IsAnythingTest extends AbstractMatcherTestCase
    {

        [Test]
        public function alwaysEvaluatesToTrue():void
        {

            assertThat(null, anything());
            assertThat(new Object(), anything());
            assertThat("hi", anything());
        }

        [Test]
        public function hasUsefulDefaultDescription():void
        {

            assertDescription("ANYTHING", anything());
        }

        [Test]
        public function canOverrideDescription():void
        {

            var description:String = "description";
            assertDescription(description, anything(description));
        }
    }
}
