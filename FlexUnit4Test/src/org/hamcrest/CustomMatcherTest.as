package org.hamcrest
{

    public class CustomMatcherTest extends AbstractMatcherTestCase
    {

        [Test]
        public function usesStaticDescription():void
        {

            var matcher:Matcher = new CustomMatcher("I match Strings", function(item:Object):Boolean
                {
                    return (item is String);
                });

            assertDescription("I match Strings", matcher);
        }
    }
}
