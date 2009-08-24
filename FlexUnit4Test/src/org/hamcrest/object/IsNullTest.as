package org.hamcrest.object
{

    import org.hamcrest.*;
    import org.hamcrest.core.not;

    public class IsNullTest extends AbstractMatcherTestCase
    {

        [Test]
        public function evaluatesToTrueIfArgumentIsNull():void
        {

            assertThat(null, nullValue());
            assertThat("not null", not(nullValue()));

            assertThat("not null", notNullValue());
            assertThat(null, not(notNullValue()));
        }
    }
}
