package org.hamcrest.collection
{

    import flexunit.framework.*;
    
    import mx.collections.ArrayCollection;
    
    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.Matcher;
    import org.hamcrest.object.equalTo;

    public class IsArrayContainingTest extends AbstractMatcherTestCase
    {

        override public function assertMatches(message:String, matcher:Matcher, arg:Object):void 
        {
            super.assertMatches(message, matcher, arg);

            // To ensure that the matcher properly matches non-Array collecitons,
            // run the same test again, this time using an ArrayCollection.
            if (arg is Array) 
            {
                super.assertMatches(message + " (as ArrayCollection)", matcher, new ArrayCollection(arg as Array));
            }
        }

        [Test]
        public function matchesACollectionThatContainsAnElementMatchingTheGivenMatcher():void
        {
            var itemMatcher:Matcher = hasItems(equalTo("a"));
            assertMatches("should match list that contains 'a'", itemMatcher, [ "a", "b", "c" ]);
        }

        [Test]
        public function doesNotMatchCollectionThatDoesntContainAnElementMatchingTheGivenMatcher():void
        {
            var matcher1:Matcher = hasItem(equalTo("a"));
            assertDoesNotMatch("should not match list that doesn't contain 'a'", matcher1, [ "b", "c" ]);

            var matcher2:Matcher = hasItem(equalTo("a"));
            assertDoesNotMatch("should not match the empty list", matcher2, []);
        }

        [Test]
        public function doesNotMatchNull():void
        {
            assertDoesNotMatch("should not match null", hasItem(equalTo("a")), null);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("an Array containing \"a\"", hasItem(equalTo("a")));
        }

        [Test]
        public function matchesAllItemsInCollection():void
        {
            var matcher1:Matcher = hasItems(equalTo("a"), equalTo("b"), equalTo("c"));
            assertMatches("should match list containing all items",
                matcher1,
                [ "a", "b", "c" ]);

            var matcher2:Matcher = hasItems("a", "b", "c");
            assertMatches("should match list containing all items (without matchers)",
                matcher2,
                [ "a", "b", "c" ]);

            var matcher3:Matcher = hasItems(equalTo("a"), equalTo("b"), equalTo("c"));
            assertMatches("should match list containing all items in any order",
                matcher3,
                [ "c", "b", "a" ]);

            var matcher4:Matcher = hasItems(equalTo("a"), equalTo("b"), equalTo("c"));
            assertMatches("should match list containing all items plus others",
                matcher4,
                [ "e", "c", "b", "a", "d" ]);

            var matcher5:Matcher = hasItems(equalTo("a"), equalTo("b"), equalTo("c"));
            assertDoesNotMatch("should not match list unless it contains all items",
                matcher5,
                [ "e", "c", "b", "d" ]); // 'a' is missing
        }
    }
}
