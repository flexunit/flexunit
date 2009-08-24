package org.hamcrest.collection
{

    import org.hamcrest.*;
    import org.hamcrest.core.not;
    import org.hamcrest.text.containsString;

    import org.flexunit.Assert;

    public class EveryTest extends AbstractMatcherTestCase
    {

        [Test]
        public function isTrueWhenEveryValueMatches():void
        {

            assertThat([ "AaA", "BaB", "CaC" ], everyItem(containsString("a")));
            assertThat([ "ABA", "BbB", "CbC" ], not(everyItem(containsString("b"))));
        }

        [Test]
        public function isAlwaysTrueForEmptyLists():void
        {

            assertThat([], everyItem(containsString("a")));
        }

        [Test]
        public function describesItself():void
        {

            var every:EveryMatcher = new EveryMatcher(containsString("a"));
            assertEquals("every item is a string containing \"a\"", every.toString());

            var description:Description = new StringDescription();
            every.matchesSafely([ "BbB" ], description);
            assertEquals("an item was \"BbB\"", description.toString());
        }
    }
}