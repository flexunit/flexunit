package org.hamcrest.object
{
    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.core.anything;
    
    public class HasPropertiesTest extends AbstractMatcherTestCase
    {
        private var shouldMatch:Object;
        private var shouldNotMatch:Object;
        
        [Before]
        public function setup():void
        {
            shouldMatch = new PropertyTester("is expected", "also expected");
            shouldNotMatch = new PropertyTester("not expected", "also expected");
        }
        
        [Test]
        public function matchesObjectWithAllNamedProperties():void
        {
            assertMatches("with all properties",
                hasProperties({
                    property1: equalTo("is expected"),
                    property2: equalTo("also expected")
                }),
                shouldMatch);
            
            assertMismatch('property "property1" was "not expected"', hasProperties({
                    property1: equalTo("is expected"),
                    property2: equalTo("also expected")
                }),
                shouldNotMatch);
        }
        
        [Test]
        public function doesNotMatchObjectWithoutNamedProperties():void
        {
            assertMismatch('No property "nonExistantProperty"',
                hasProperties({
                    nonExistantProperty: anything()
                }),
                shouldNotMatch);
        }
        
        [Test]
        public function doesNotMatchWriteOnlyProperty():void
        {
            assertMismatch('property "writeOnlyProperty" is not readable',
                hasProperties({
                    writeOnlyProperty: anything()
                }),
                shouldNotMatch);
        }
        
        [Test]
        public function describeTo():void
        {
            assertDescription('(has property "property1" with <true> and has property "property2" with <true>)',
                hasProperties({
                    property1: equalTo(true),
                    property2: equalTo(true)
                }));
        }
        
        [Test]
        public function describesMissingPropertyMismatch():void
        {
            assertMismatch('No property "honk"',
                hasProperties({
                    honk: anything()
                }),
                shouldNotMatch);
        }
    
    }
}

internal class PropertyTester
{
    
    private var _property1:String;
    private var _property2:String;
    
    public function PropertyTester(value1:String, value2:String)
    {
        _property1 = value1;
        _property2 = value2;
    }
    
    public function get property1():String
    {
        return _property1;
    }
    
    public function set property1(value:String):void
    {
        _property1 = value;
    }
    
    public function get property2():String
    {
        return _property2;
    }
    
    public function set property2(value:String):void
    {
        _property2 = value;
    }
    
    public function set writeOnlyProperty(value:Number):void
    {
        ;
    }
}