package org.hamcrest.collection
{
    import org.hamcrest.object.equalTo;

    public class IsArrayTest extends AbstractArrayMatcherTestCase
    {
        [Test]
        public function matchesAnArrayThatMatchesAllTheElementMatchers():void
        {
            assertMatches("should match array with matching elements",
                array(equalTo("a"), equalTo("b"), equalTo("c")), [ "a", "b", "c" ]);
        }

        [Test]
        public function doesNotMatchAnArrayWhenElementDoNotMatch():void
        {
            assertDoesNotMatch("should not match array with different elements",
                array(equalTo("a"), equalTo("b")), [ "b", "c" ]);
        }

        [Test]
        public function doesNotMatchAnArrayOfDifferentSize():void
        {
            assertDoesNotMatch("should not match larger array",
                array(equalTo("a"), equalTo("b")), [ "a", "b", "c" ]);
            assertDoesNotMatch("should not match smaller array",
                array(equalTo("a"), equalTo("b")), [ "a" ]);
        }

        [Test]
        public function doesNotMatchNull():void
        {
            assertDoesNotMatch("should not match null",
                array(equalTo("a")), null);
        }

        [Test]
        public function convertsLiteralValuesToEqualToMatcher():void
        {
            assertMatches("should convert items and match array with matching elements",
                array("a", "b", "c"), [ "a", "b", "c" ]);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("[\"a\", \"b\"]", array(equalTo("a"), equalTo("b")));
        }
        
        [Test]
        public function describesMismatches():void 
        {
            assertMismatch(
                "was [\"a\",\"b\",\"d\"]",
                array("a", "b", "c"), 
                ['a', 'b', 'd']);
        }
    }
}
