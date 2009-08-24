package org.hamcrest.core
{

    import flash.errors.IllegalOperationError;

    import org.hamcrest.*;

    public class ThrowsTest extends AbstractMatcherTestCase
    {

        [Test]
        public function rethrowsUnexpectedError():void
        {

            var fn:Function = function():void
            {
                throw new IllegalOperationError("crumpets face inwards");
            };

            assertDoesNotMatch("", throws(ArgumentError), fn);
        }

        [Test]
        public function matchesIfFunctionThrowsExpectedError():void
        {

            var fn:Function = function():void
            {
                throw new ArgumentError("no waffles given");
            };

            assertMatches("", throws(ArgumentError), fn);
            assertMatches("", throws(Error), fn);
        }

        [Test]
        public function doesNotMatchesIfFunctionDoesNotThrowAnyError():void
        {

            var fn:Function = function():void
            {
                ; // dont throw an error
            };

            assertDoesNotMatch("", throws(ArgumentError), fn);
        }

        [Test]
        public function acceptsInstanceMethod():void
        {

            var complainer:Complainer = new Complainer();
            assertThat(complainer.complain, throws(Complaint))
        }
    }
}

internal class Complaint extends Error
{
    public function Complaint()
    {
        super("Complaint");
    }
}

internal class Complainer
{
    public function complain():void
    {
        throw new Complaint();
    }
}
