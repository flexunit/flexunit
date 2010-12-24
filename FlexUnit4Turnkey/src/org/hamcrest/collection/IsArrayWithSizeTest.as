package org.hamcrest.collection
{
    import org.hamcrest.AbstractMatcherTestCase;

    public class IsArrayWithSizeTest extends AbstractArrayMatcherTestCase
    {
        [Test]
        public function matchesWhenSizeIsCorrect():void
        {
            assertMatches("correct size", arrayWithSize(3), [ 1, 2, 3 ]);
            assertDoesNotMatch("incorrect size", arrayWithSize(2), [ 1, 2, 3 ]);
        }

        [Test]
        public function providesConvenientShortcutForArrayWithSizeEqualTo():void
        {
            assertMatches("correct size", arrayWithSize(3), [ 1, 2, 3 ]);
            assertDoesNotMatch("incorrect size", arrayWithSize(2), [ 1, 2, 3 ]);
        }

        [Test]
        public function emptyArrays():void
        {
            assertMatches("correct size", emptyArray(), []);
            assertDoesNotMatch("incorrect size", emptyArray(), [ 1 ]);
        }

        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription("an Array with size <3>", arrayWithSize(3));
            assertDescription("an empty Array", emptyArray());
        }
        
        [Test]
        public function describesMismatch():void 
        {
            assertMismatch(
                "size was <4>", 
                arrayWithSize(3),
                [1, 2, 3, 4]);
        }
    }
}
