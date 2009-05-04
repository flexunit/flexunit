package org.hamcrest.core {

    import org.hamcrest.*;

    public class IsAnythingTest extends AbstractMatcherTestCase {

		[Test]
        public function testAlwaysEvaluatesToTrue():void {

            assertThat(null, anything());
            assertThat(new Object(), anything());
            assertThat("hi", anything());
        }

		[Test]
        public function testHasUsefulDefaultDescription():void {

            assertDescription("ANYTHING", anything());
        }

		[Test]
        public function testCanOverrideDescription():void {

            var description:String = "description";
            assertDescription(description, anything(description));
        }
    }
}
