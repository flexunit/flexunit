package org.hamcrest.object
{
    
    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.core.anything;
    
    public class HasPropertyWithValueTest extends AbstractMatcherTestCase
    {
        private var shouldMatch:Object;
        private var shouldNotMatch:Object;
        
        [Before]
        public function setup():void
        {
            shouldMatch = new PropertyTester("is expected");
            shouldNotMatch = new PropertyTester("not expected");
        }
        
        [Test]
        public function matchesObjectWithMatchedNamedProperty():void
        {
            assertMatches("with property",
                hasPropertyWithValue("property", equalTo("is expected")),
                shouldMatch);
            
            assertMismatch('property "property" was "not expected"',
                hasPropertyWithValue("property", equalTo("is expected")),
                shouldNotMatch);
            
            assertMismatch('no property "property" on null object',
                hasPropertyWithValue("property", equalTo("is expected")),
                null);
        }
        
        [Test]
        public function doesNotMatchObjectWithoutNamedProperty():void
        {
            assertMismatch('no property "nonExistantProperty"',
                hasPropertyWithValue("nonExistantProperty", anything()),
                shouldNotMatch);
        }
        
        [Ignore]
        [Test]
        public function doesNotMatchWriteOnlyProperty():void
        {
            assertMismatch('property "writeOnlyProperty" is not readable',
                hasPropertyWithValue("writeOnlyProperty", anything()),
                shouldNotMatch);
        }
        
        [Test]
        public function describesMissingPropertyMismatch():void
        {
            assertMismatch('no property "honk"', hasPropertyWithValue("honk", anything()), shouldNotMatch);
        }
        
        [Test]
        public function describesMissingPropertyMismatchForNull():void
        {
            assertMismatch('no property "honk" on null object', hasPropertyWithValue("honk", anything()), null);
        }
        
        [Test]
        public function evaluatesToTrueIfArgumentHasOwnProperty():void
        {
            assertMatches("has property",
                hasPropertyWithValue("value", equalTo("one")),
                { value: "one" });
            
            assertDoesNotMatch("does not have property",
                hasPropertyWithValue("value", equalTo(false)),
                { other: true });
        }
        
        [Test]
        public function hasAReadableDescription():void
        {
            assertDescription('has property "value" with <3>',
                hasPropertyWithValue("value", equalTo(3)));
        }
        
        [Test]
        public function wrapsValueInEqualToIfNotAMatcher():void
        {
            assertMatches("with property",
                hasPropertyWithValue("property", "is expected"),
                shouldMatch);
            
            assertMismatch('property "property" was "not expected"',
                hasPropertyWithValue("property", "is expected"),
                shouldNotMatch);
            
            assertMismatch('no property "property" on null object',
                hasPropertyWithValue("property", "is expected"),
                null);
        }
    }
}

internal class PropertyTester
{
    
    private var _property:String;
    
    public function PropertyTester(value:String)
    {
        _property = value;
    }
    
    public function get property():String
    {
        return _property;
    }
    
    public function set property(value:String):void
    {
        _property = value;
    }
    
    public function set writeOnlyProperty(value:Number):void
    {
        ;
    }
}