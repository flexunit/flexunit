package org.hamcrest.core
{

    import org.hamcrest.*;
    import org.hamcrest.object.equalTo;

    public class IsNotTest extends AbstractMatcherTestCase
    {

        [Test]
        public function evaluatesToTheLogicalNegationOfAnotherMatcher():void
        {

            assertMatches("should match", not(equalTo("A")), "B");
            assertDoesNotMatch("should not match", not(equalTo("B")), "B");
        }

        [Test]
        public function providesConvenientShortcutForNotEqualTo():void
        {

            assertMatches("should match", not("A"), "B");
            assertMatches("should match", not("B"), "A");
            assertDoesNotMatch("should not match", not("A"), "A");
            assertDoesNotMatch("should not match", not("B"), "B");
            assertDescription("not \"A\"", not("A"));
        }
    }
}
