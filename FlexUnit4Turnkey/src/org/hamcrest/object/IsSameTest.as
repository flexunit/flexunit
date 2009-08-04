package org.hamcrest.object
{

    import org.hamcrest.*;
    import org.hamcrest.core.not;

    public class IsSameTest extends AbstractMatcherTestCase
    {

        [Test]
        public function evaluatesToTrueIfArgumentIsReferenceToASpecificObject():void
        {
            var o1:Object = {};
            var o2:Object = {};

            assertThat(o1, sameInstance(o1));
            assertThat(o2, not(sameInstance(o1)));
        }

        [Test]
        public function returnsReadableDescriptionFromToString():void
        {
            assertDescription("same instance \"ARG\"", sameInstance("ARG"));
        }

        [Test]
        public function returnsReadableDescriptionFromToStringWhenInitializedithNull():void
        {
            assertDescription("same instance null", sameInstance(null));
        }
    }
}
