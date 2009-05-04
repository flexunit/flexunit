package org.hamcrest.object {

    import org.hamcrest.AbstractMatcherTestCase;

    public class HasPropertyWithValueTest extends AbstractMatcherTestCase {

		[Test]
        public function testMatchesInfolessObjectWithMatchedNamedProperty():void {

        }

		[Test]
        public function testMatchesBeanWithInfoWithMatchedNamedProperty():void {

        }

		[Test]
        public function testDoesNotMatchWriteOnlyProperty():void {

        }

		[Test]
        public function testDescribeTo():void {

        }

		[Test]
        public function testMatchesPropertyAndValue():void {

        }

		[Test]
        public function testDoesNotWriteMismatchIfPropertyMatches():void {

        }

		[Test]
        public function testDescribesMissingPropertyMismatch():void {

        }

        //        public function testEvaluatesToTrueIfArgumentHasOwnProperty():void {
        //
        //            assertMatches("has property",
        //                hasPropertyWithValue("value", equalTo("one")),
        //                { value: "one" });
        //
        //            assertDoesNotMatch("does not have property",
        //                hasPropertyWithValue("value", equalTo(false)),
        //                { other: true });
        //        }
        //
        //        public function testHasAReadableDescription():void {
        //
        //            assertDescription('an object with property "value" and a value matching <3>',
        //                hasPropertyWithValue("value", equalTo(3)));
        //        }

    }
}
