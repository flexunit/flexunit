package org.hamcrest.mxml.object
{
    import flash.events.Event;

    import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

    /*
       <InstanceOf type="{ SomeClass }" />
     */
    public class InstanceOfTest extends AbstractMXMLMatcherTestCase
    {
        private var matcher:InstanceOf;

        [Before]
        public function createMatcher():void
        {
            matcher = new InstanceOf();
            matcher.type = Event;
        }

        [Test]
        public function hasDescription():void
        {
            assertDescription("an instance of flash.events::Event", matcher);
        }

        [Test]
        public function matchedIsTrueIfTargetMatches():void
        {
            matcher.target = new Event(Event.ADDED);

            assertMatched("matched if target matches", matcher);
        }

        [Test]
        public function matchedIsFalseIfTargetDoesNotMatch():void
        {
            matcher.target = null;

            assertNotMatched("not matched if target does not match", matcher);
        }

        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.target = new Event(Event.ADDED);

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.target = null;

            assertMismatchDescription("was null", matcher);
        }
    }
}
