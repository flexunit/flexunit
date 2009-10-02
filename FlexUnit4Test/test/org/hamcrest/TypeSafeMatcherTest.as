package org.hamcrest
{

    public class TypeSafeMatcherTest extends AbstractMatcherTestCase
    {

        [Test]
        public function classMatchesSafelyIfTypesMatch():void
        {

            var called:Boolean = false;

            var matcher:TypeSafeMatcher = new TypeSafeMatcherForTesting(String, function(item:Object):Boolean
                {
                    called = true;
                    return true;
                });

            matcher.matches("hello");

            assertThat("TypeSafeMatcher.matchesSafely was not called", called);
        }
    }
}

import org.hamcrest.TypeSafeMatcher;

internal class TypeSafeMatcherForTesting extends TypeSafeMatcher
{

    private var _fn:Function;

    public function TypeSafeMatcherForTesting(type:Class, fn:Function)
    {
        super(type);
        _fn = fn;
    }

    override public function matchesSafely(item:Object):Boolean
    {
        return _fn(item);
    }
}
