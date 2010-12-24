package org.hamcrest.collection
{
    import mx.collections.ArrayCollection;
    
    import org.flexunit.Assert;
    import org.hamcrest.*;
    import org.hamcrest.core.not;
    import org.hamcrest.text.containsString;
    import org.hamcrest.text.re;

    public class EveryTest extends AbstractArrayMatcherTestCase
    {
        [Test]
        public function matchesWhereEveryElementMatches():void
        {
            assertMatches(
                "should match array where every item contains 'a'", 
                everyItem(containsString("a")), 
                [ "AaA", "BaB", "CaC" ]); 
        }
        
        [Test]
        public function doesNotMatchWhereAnyElementDoesNotMatch():void
        {
            assertDoesNotMatch(
                "should not match array where every item does not contain 'b'",
                everyItem(not(containsString('b'))),
                [ "ABA", "BbB", "CbC" ]);
        }

        [Test]
        public function isAlwaysTrueForEmptyLists():void
        {
            assertMatches(
                "should match empty array", 
                everyItem(containsString('a')), 
                []);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription(
                "every item is a string containing \"a\"",
                everyItem(containsString("a")));
        }
        
        [Test]
        public function describesMismatch():void 
        {
            assertMismatch(
                "an item was \"BbB\"", 
                everyItem(containsString("a")), 
                ["BbB"]);
        }
    }
}
