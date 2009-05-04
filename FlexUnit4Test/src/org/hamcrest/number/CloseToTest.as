package org.hamcrest.number {

    import org.hamcrest.AbstractMatcherTestCase;

    public class CloseToTest extends AbstractMatcherTestCase {

		[Test]
        public function testCloseTo():void {
            assertMatches("close enough", closeTo(1, 0.5), 1.5);
            assertDoesNotMatch("too far", closeTo(1, 0.5), 1.6);
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("a numeric value within <0.1> of <3>", closeTo(3, 0.1));
        }
    }
}
