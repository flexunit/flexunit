package org.hamcrest.core {

    import flexunit.framework.*;

    import org.hamcrest.*;
    import org.hamcrest.object.equalTo;

    public class AnyOfTest extends AbstractMatcherTestCase {

		[Test]
        public function testEvaluatesToTheTheLogicalDisjunctionOfTwoOtherMatchers():void {

            assertThat("good", anyOf(equalTo("bad"), equalTo("good")));
            assertThat("good", anyOf(equalTo("good"), equalTo("good")));
            assertThat("good", anyOf(equalTo("good"), equalTo("bad")));

            assertThat("good", not(anyOf(equalTo("bad"), equalTo("bad"))));
        }

		[Test]
        public function testEvaluatesToTheTheLogicalDisjunctionOfManyOtherMatchers():void {

            assertThat("good", anyOf(equalTo("bad"), equalTo("good"), equalTo("bad"), equalTo("bad"), equalTo("bad")));
            assertThat("good", not(anyOf(equalTo("bad"), equalTo("bad"), equalTo("bad"), equalTo("bad"), equalTo("bad"))));
        }

		[Test]
        public function testHasAReadableDescription():void {
            assertDescription("(\"good\" or \"bad\" or \"ugly\")",
                anyOf(equalTo("good"), equalTo("bad"), equalTo("ugly")));
        }
    }
}