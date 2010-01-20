package org.hamcrest
{

    public class BaseMatcherTest extends AbstractMatcherTestCase
    {

        [Test]
        public function describesItselfWithToStringMethod():void
        {

            var matcher:BaseMatcher = new BaseMatcherForTesting();
            assertEquals("SOME DESCRIPTION", matcher.toString());
        }
    }
}

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

internal class BaseMatcherForTesting extends BaseMatcher
{

    override public function describeTo(description:Description):void
    {
        description.appendText("SOME DESCRIPTION");
    }
}
