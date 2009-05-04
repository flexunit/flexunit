package org.hamcrest.text {

    import org.hamcrest.*;
    import org.hamcrest.core.*;
    
    import org.flexunit.Assert;

    public class StringEndsWithTest extends AbstractMatcherTestCase {

        private static const EXCERPT:String = "EXCERPT";
        private var stringEndsWith:Matcher;

		[Before]
        public function setUp():void {
            stringEndsWith = endsWith(EXCERPT);
        }

		[Test]
        public function testEvaluatesToTrueIfArgumentContainsSpecifiedSubstring():void {
            Assert.assertFalse("should be false if excerpt at beginning",
                stringEndsWith.matches(EXCERPT + "END"));
            Assert.assertTrue("should be true if excerpt at end",
                stringEndsWith.matches("START" + EXCERPT));
            Assert.assertFalse("should be false if excerpt in middle",
                stringEndsWith.matches("START" + EXCERPT + "END"));
            Assert.assertTrue("should be true if excerpt is at end and repeated",
                stringEndsWith.matches(EXCERPT + EXCERPT));

            Assert.assertFalse("should be false if excerpt is not in string",
                stringEndsWith.matches("Something else"));
            Assert.assertFalse("should be false if part of excerpt is at end of string",
                stringEndsWith.matches(EXCERPT.substring(0, EXCERPT.length - 2)));
        }

    	[Test]
        public function testEvaluatesToTrueIfArgumentIsEqualToSubstring():void {
            Assert.assertTrue("should be true if excerpt is entire string",
                stringEndsWith.matches(EXCERPT));
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("a string ending with \"EXCERPT\"", stringEndsWith);
        }
    }
}
