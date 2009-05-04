package org.hamcrest.text {

    import org.hamcrest.*;
    import org.hamcrest.core.*;
    
    import org.flexunit.Assert;

    public class StringContainsTest extends AbstractMatcherTestCase {

        private static const EXCERPT:String = "EXCERPT";
        private var stringContains:Matcher;

		[Before]
        public function setUp():void {
            stringContains = containsString(EXCERPT);
        }

		[Test]
        public function testEvaluatesToTrueIfArgumentContainsSpecifiedSubstring():void {
            Assert.assertTrue("should be true if excerpt at beginning",
                stringContains.matches(EXCERPT + "END"));
            Assert.assertTrue("should be true if excerpt at end",
                stringContains.matches("START" + EXCERPT));
            Assert.assertTrue("should be true if excerpt in middle",
                stringContains.matches("START" + EXCERPT + "END"));
            Assert.assertTrue("should be true if excerpt is repeated",
                stringContains.matches(EXCERPT + EXCERPT));

            Assert.assertFalse("should not be true if excerpt is not in string",
                stringContains.matches("Something else"));
            Assert.assertFalse("should not be true if part of excerpt is in string",
                stringContains.matches(EXCERPT.substring(1)));
        }

		[Test]
        public function testEvaluatesToTrueIfArgumentIsEqualToSubstring():void {
            Assert.assertTrue("should be true if excerpt is entire string",
                stringContains.matches(EXCERPT));
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("a string containing \"EXCERPT\"", stringContains);
        }
    }
}
