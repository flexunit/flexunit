package org.hamcrest.number {

    import org.hamcrest.AbstractMatcherTestCase;

    public class LessThanTest extends AbstractMatcherTestCase {

		[Test]
        public function testLessThan():void {
            assertMatches("less than", lessThan(10), 9);
            assertDoesNotMatch("not less than", lessThan(10), 11);
        }

		[Test]
        public function testLessThanOrEqualTo():void {
            assertMatches("less than", lessThanOrEqualTo(10), 10);
            assertDoesNotMatch("not less than", lessThanOrEqualTo(10), 11);
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("a value less than <3>", lessThan(3));
            assertDescription("a value less than or equal to <3>", lessThanOrEqualTo(3));
        }
    }
}
