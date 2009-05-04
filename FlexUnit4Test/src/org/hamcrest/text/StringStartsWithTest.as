package org.hamcrest.text {

    import org.hamcrest.*;
    import org.hamcrest.core.*;
    
    import org.flexunit.Assert;

    public class StringStartsWithTest extends AbstractMatcherTestCase {

        private static const EXCERPT:String = "EXCERPT";
        private var stringStartsWith:Matcher;

		[Before]
        public function setUp():void {
            stringStartsWith = startsWith(EXCERPT);
        }

		[Test]
        public function testEvaluatesToTrueIfArgumentContainsSpecifiedSubstring():void {
            Assert.assertTrue("should be true if excerpt at beginning",
                stringStartsWith.matches(EXCERPT + "END"));
            Assert.assertFalse("should be false if excerpt at end",
                stringStartsWith.matches("START" + EXCERPT));
            Assert.assertFalse("should be false if excerpt in middle",
                stringStartsWith.matches("START" + EXCERPT + "END"));
            Assert.assertTrue("should be true if excerpt is at beginning and repeated",
                stringStartsWith.matches(EXCERPT + EXCERPT));

            Assert.assertFalse("should be false if excerpt is not in string",
                stringStartsWith.matches("Something else"));
            Assert.assertFalse("should be false if part of excerpt is at start of string",
                stringStartsWith.matches(EXCERPT.substring(1)));
        }

		[Test]
        public function testEvaluatesToTrueIfArgumentIsEqualToSubstring():void {
            Assert.assertTrue("should be true if excerpt is entire string",
                stringStartsWith.matches(EXCERPT));
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("a string starting with \"EXCERPT\"", stringStartsWith);
        }
    }
}
