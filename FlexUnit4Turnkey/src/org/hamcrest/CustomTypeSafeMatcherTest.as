package org.hamcrest
{

    public class CustomTypeSafeMatcherTest extends AbstractMatcherTestCase
    {

        private static const STATIC_DESCRIPTION:String = "I match non empty Strings";

        [Test]
        public function usesStaticDescription():void
        {

            var matcher:Matcher = new CustomTypeSafeMatcher(STATIC_DESCRIPTION, String, function(item:String):Boolean
                {
                    return false;
                })

            assertDescription(STATIC_DESCRIPTION, matcher);
        }
    }
}
