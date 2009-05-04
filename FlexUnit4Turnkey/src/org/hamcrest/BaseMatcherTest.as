package org.hamcrest {
	import org.flexunit.Assert;
	

    public class BaseMatcherTest {

		[Test]
        public function testDescribesItselfWithToStringMethod():void {

            var matcher:BaseMatcher = new BaseMatcherForTesting();
            Assert.assertEquals("SOME DESCRIPTION", matcher.toString());
        }
    }
}

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

internal class BaseMatcherForTesting extends BaseMatcher {

    override public function describeTo(description:Description):void {
        description.appendText("SOME DESCRIPTION");
    }
}
