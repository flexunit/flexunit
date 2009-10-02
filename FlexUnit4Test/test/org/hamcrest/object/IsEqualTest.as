package org.hamcrest.object
{

    import org.hamcrest.*;
    import org.hamcrest.core.not;

    public class IsEqualTest extends AbstractMatcherTestCase
    {

        [Test]
        public function comparesObjectsUsingEqualsEquals():void
        {

            assertThat("hi", equalTo("hi"));
            assertThat("bye", not(equalTo("hi")));

            assertThat(1, equalTo(1));
            assertThat(1, not(equalTo(2)));
        }

        [Test]
        public function canCompareNullValues():void
        {

            assertThat(null, equalTo(null));

            assertThat(null, not(equalTo("hi")));
            assertThat("hi", not(equalTo(null)));
        }

        [Test]
        public function comparesTheElementsOfAnArray():void
        {

            var s1:Array = [ "a", "b" ];
            var s2:Array = [ "a", "b" ];
            var s3:Array = [ "c", "d" ];
            var s4:Array = [ "a", "b", "c", "d" ];

            assertThat(s1, equalTo(s1));
            assertThat(s2, equalTo(s1));
            assertThat(s3, not(equalTo(s1)));
            assertThat(s4, not(equalTo(s1)));
        }

        [Test]
        public function recursivelyTestsElementsOfArrays():void
        {

            var i1:Array = [[ 1, 2 ], [ 3, 4 ]];
            var i2:Array = [[ 1, 2 ], [ 3, 4 ]];
            var i3:Array = [[ 5, 6 ], [ 7, 8 ]];
            var i4:Array = [[ 1, 2, 3, 4 ], [ 3, 4 ]];

            assertThat(i1, equalTo(i1));
            assertThat(i2, equalTo(i1));
            assertThat(i3, not(equalTo(i1)));
            assertThat(i4, not(equalTo(i1)));
        }

        [Test]
        public function includesTheResultsOfCallingToStringOnItsArgumentsInTheDescription():void
        {
            var argumentDescription:String = "";
            var argument:Object = {
                    toString: function():String
                {
                    return argumentDescription;
                }
                };

            assertDescription("<" + argumentDescription + ">", equalTo(argument));
        }

        [Test]
        public function returnsAnObviousDescriptionIfCreatedWithANestedMatcherByMistake():void
        {
            var matcher:Matcher = equalTo("nestedMatcher");
            assertDescription("<" + matcher + ">", equalTo(matcher));
        }

        [Test]
        public function returnsGoodDesriptionIfCreatedWithNullReference():void
        {
            assertDescription("null", equalTo(null));
        }
    }
}