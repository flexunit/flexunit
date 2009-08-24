package org.hamcrest.core
{

    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.Matcher;
    import org.hamcrest.StringDescription;
    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;

    public class CombinableTest extends AbstractMatcherTestCase
    {

        private static const EITHER_3_OR_4:CombinableMatcher = either(equalTo(3)).or(equalTo(4)) as CombinableMatcher;
        private static const NOT_3_AND_NOT_4:CombinableMatcher = both(not(equalTo(3))).and(not(equalTo(4))) as CombinableMatcher;

        [Test]
        public function bothAcceptsAndRejects():void
        {
            assertThat(2, NOT_3_AND_NOT_4);
            assertThat(3, not(NOT_3_AND_NOT_4));
        }

        [Test]
        public function acceptsAndRejects():void
        {
            var tripleAnd:Matcher = NOT_3_AND_NOT_4.and(equalTo(2));
            assertThat(2, tripleAnd);
            assertThat(3, not(tripleAnd));
        }

        [Test]
        public function bothDescribesItself():void
        {
            assertDescription("(not <3> and not <4>)", NOT_3_AND_NOT_4);
            assertMismatch("was <3>", NOT_3_AND_NOT_4, 3);
        }

        [Test]
        public function eitherAcceptsAndRejects():void
        {
            assertThat(3, EITHER_3_OR_4);
            assertThat(6, not(EITHER_3_OR_4));
        }

        [Test]
        public function acceptsAndRejectsThreeOrs():void
        {
            var tripleOr:Matcher = EITHER_3_OR_4.or(greaterThan(10));
            assertThat(11, tripleOr);
            assertThat(9, not(tripleOr));
        }

        [Test]
        public function eitherDescribesItself():void
        {
            assertDescription("(<3> or <4>)", EITHER_3_OR_4);
            assertMismatch("was <6>", EITHER_3_OR_4, 6);
        }

        // TODO this is of dubious value given no generics? 
        [Test]
        public function picksUpTypeFromLeftHandSideOfExpression():void
        {
            assertThat("yellow", both(equalTo("yellow")).and(notNullValue()));
        }

        [Test]
        public function mixedAndsAndOrs():void
        {
            var matcher:Matcher = both(equalTo("good")).and(not(equalTo("bad"))).or(equalTo("ugly"));
            assertDescription('(("good" and not "bad") or "ugly")', matcher);
        }
    }
}
