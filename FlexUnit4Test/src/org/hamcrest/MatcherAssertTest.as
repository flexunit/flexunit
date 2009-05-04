package org.hamcrest {

    import org.hamcrest.object.equalTo;
    import org.hamcrest.text.startsWith;

	import org.flexunit.Assert;

    public class MatcherAssertTest  {

		[Test]
        public function testIncludesDescriptionOfTestedValueInErrorMessage():void {

            var expected:String = "expected";
            var actual:String = "actual";
            var expectedMessage:String = "identifier\nExpected: \"expected\"\n     but: was \"actual\"";

            try {
                assertThat("identifier", actual, equalTo(expected));
                Assert.fail("should have failed");
            }
            catch (error:AssertionError) {
                trace("testIncludesDescriptionOfTestedValueInErrorMessage");
                trace(">", error.message);
                Assert.assertTrue(startsWith(expectedMessage).matches(error.message));
            }
        }

		[Test]
        public function testDescriptionCanBeElided():void {

            var expected:String = "expected";
            var actual:String = "actual";
            var expectedMessage:String = "Expected: \"expected\"\n     but: was \"actual\"";

            try {
                assertThat(actual, equalTo(expected));
                Assert.fail("should have failed");
            }
            catch (error:AssertionError) {
                trace("testDescriptionCanBeElided")
                trace(">", error.message);
                trace(startsWith(expectedMessage).matches(error.message));

                Assert.assertTrue(startsWith(expectedMessage).matches(error.message));
            }
        }

		[Test]
        public function testCanTestBooleanDirectly():void {

            assertThat("success reason message", true);

            try {
                assertThat("failing reason message", false);
                Assert.fail("should have failed");
            }
            catch (error:AssertionError) {
                Assert.assertEquals("failing reason message", error.message);
            }
        }

		[Ignore("Not ready for primetime")]
		[Test]
        public function tetIncludedsMismatchDescription():void {

            var matcher:Matcher = new MatcherForTestingAssertThat();
            var expectedMessage:String = "\nExpected: something cool\n     but: was: not cool"

            try {
                assertThat("value", matcher);
                Assert.fail("should have failed");
            }
            catch (error:AssertionError) {
                Assert.assertEquals(expectedMessage, error.message);
            }
        }
    }
}

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

internal class MatcherForTestingAssertThat extends BaseMatcher {

    override public function matches(item:Object):Boolean {
        return false;
    }

    override public function describeTo(description:Description):void {
        description.appendText("something cool");
    }

    override public function describeMismatch(item:Object, mismatchDescription:Description):void {
        mismatchDescription.appendText("not cool");
    }
}

