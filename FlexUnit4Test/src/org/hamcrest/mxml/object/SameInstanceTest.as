package org.hamcrest.mxml.object
{
    import flash.events.Event;

    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <SameInstance type="{ SomeClass }" />
     */
    public class SameInstanceTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:SameInstance;
        private var instance:Event;

        [Before]
        public function createMatcher():void
        {
            instance = new Event(Event.ADDED);

            matcher = new SameInstance();
            matcher.value = instance;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("same instance <" + instance.toString() + ">", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = instance;

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = new Event(Event.ADDED);

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = instance;

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = new Event(Event.ADDED);

            assertMismatchDescription("was <" + matcher.target.toString() + ">", matcher);
        }
    }
}
