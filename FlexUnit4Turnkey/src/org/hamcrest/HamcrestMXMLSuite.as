package org.hamcrest
{
    import org.hamcrest.mxml.collection.ArrayTest;
    import org.hamcrest.mxml.collection.ArrayWithSizeTest;
    import org.hamcrest.mxml.collection.EmptyArrayTest;
    import org.hamcrest.mxml.collection.EveryItemTest;
    import org.hamcrest.mxml.collection.HasItemTest;
    import org.hamcrest.mxml.collection.HasItemsTest;
    import org.hamcrest.mxml.core.AllOfTest;
    import org.hamcrest.mxml.core.AnyOfTest;
    import org.hamcrest.mxml.core.AnythingTest;
    import org.hamcrest.mxml.core.DescribedAsTest;
    import org.hamcrest.mxml.core.NotTest;
    import org.hamcrest.mxml.date.DateAfterTest;
    import org.hamcrest.mxml.date.DateBeforeTest;
    import org.hamcrest.mxml.date.DateBetweenTest;
    import org.hamcrest.mxml.date.DateEqualToTest;
    import org.hamcrest.mxml.number.BetweenTest;
    import org.hamcrest.mxml.number.CloseToTest;
    import org.hamcrest.mxml.number.GreaterThanOrEqualToTest;
    import org.hamcrest.mxml.number.GreaterThanTest;
    import org.hamcrest.mxml.number.LessThanOrEqualToTest;
    import org.hamcrest.mxml.number.LessThanTest;
    import org.hamcrest.mxml.object.EqualToTest;
    import org.hamcrest.mxml.object.HasPropertyTest;
    import org.hamcrest.mxml.object.HasPropertyWithValueTest;
    import org.hamcrest.mxml.object.InstanceOfTest;
    import org.hamcrest.mxml.object.NotNullTest;
    import org.hamcrest.mxml.object.NullTest;
    import org.hamcrest.mxml.object.SameInstanceTest;
    import org.hamcrest.mxml.text.ContainsStringTest;
    import org.hamcrest.mxml.text.EndsWithTest;
    import org.hamcrest.mxml.text.StartsWithTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class HamcrestMXMLSuite
    {
        // collection
        public var array:ArrayTest;
        public var arrayWithSize:ArrayWithSizeTest;
        public var emptyArray:EmptyArrayTest;
        public var everyItem:EveryItemTest;
        public var hasItem:HasItemTest;
        public var hasItems:HasItemsTest;

        // core 
        public var allOf:AllOfTest;
        public var anyOf:AnyOfTest;
        public var anything:AnythingTest;
        public var describedAs:DescribedAsTest;
        public var not:NotTest;

        // date
        public var dateAfter:DateAfterTest;
        public var dateBefore:DateBeforeTest;
        public var dateBetween:DateBetweenTest;
        public var dateEqualTo:DateEqualToTest;

        // number
        public var between:BetweenTest;
        public var closeTo:CloseToTest;
        public var gt:GreaterThanTest;
        public var gte:GreaterThanOrEqualToTest;
        public var lt:LessThanTest;
        public var lte:LessThanOrEqualToTest;

        // object
        public var equalTo:EqualToTest;
        public var hasPropety:HasPropertyTest;
        public var hasPropetyWithValue:HasPropertyWithValueTest;
//        public var hasProperties:HasPropertiesTest;
        public var instanceOf:InstanceOfTest;
        public var notNull:NotNullTest;
        public var nullTest:NullTest;
        public var sameInstance:SameInstanceTest;

        // text
        public var containsString:ContainsStringTest;
        public var endsWith:EndsWithTest;
//        public var matchesPattern:MatchesPatternTest;
        public var startsWith:StartsWithTest;

    }
}
