package org.hamcrest.object
{
    import org.hamcrest.AbstractMatcherTestCase;

    public class HasPropertyChainTest extends AbstractMatcherTestCase
    {
        [Test]
        public function matchesObjectWithAllPropertyChainLinks():void
        {
            assertMatches(
                "matches object with all property chain links", 
                hasPropertyChain("one.two.three"), 
                { one: { two: { three: 4 } }});
        }
        
        [Test]
        public function matchesObjectWithAllPropertyChainLinksAndExpectedValue():void
        {
            assertMatches(
                "matches object with all property chain links and expected value", 
                hasPropertyChain("one.two.three", equalTo(4)), 
                { one: { two: { three: 4 } }});
        }
        
        [Test]
        public function matchesObjectWithAllPropertyChainLinksAndExpectedValueWithEqualToCoersion():void
        {
            assertMatches(
                "matches object with all property chain links and expected value", 
                hasPropertyChain("one.two.three", 4), 
                { one: { two: { three: 4 } }});
        }
        
        [Test]
        public function matchesObjectWithAllPropertyChainLinksFromArray():void
        {
            assertMatches(
                "matches object with all property chain links from Array", 
                hasPropertyChain(['one', 'two', 'three']), 
                { one: { two: { three: 4 } }});
        }
        
        [Test]
        public function doesNotMatchWhereExpectedValueDoesNotMatch():void 
        {
            assertDoesNotMatch(
                "does not match where expected value does not match",
                hasPropertyChain("one.two.three", equalTo(4)),
                { one: { two: { three: 5 }} });
        }
        
        [Test]
        public function doesNotMatchWherePropertyChainLinkIsMissing():void
        {
            assertDoesNotMatch(
                "does not match where expected value does not match",
                hasPropertyChain("one.two.three", equalTo(4)),
                { one: { two: {} } });
        }
        
        [Test]
        public function doesNotMatchWherePropertyChainLinkFromArrayIsMissing():void
        {
            assertDoesNotMatch(
                "does not match where expected value does not match",
                hasPropertyChain(['one', 'two', 'three'], equalTo(4)),
                { one: { two: {} } });
        }
        
        [Test]
        public function hasAReadableDescription():void 
        {
            assertDescription(
                "has property chain \"one.two.three\"", 
                hasPropertyChain("one.two.three"));
        }
        
        [Test]
        public function hasAReadableDescriptionWithExpectedValue():void 
        {
            assertDescription(
                "has property chain \"one.two.three\" with a value of <4>", 
                hasPropertyChain("one.two.three", equalTo(4)));
        }
        
        [Test]
        public function describesMismatch():void 
        {
            assertMismatch(
                "missing property \"three\"", 
                hasPropertyChain("one.two.three"), 
                { one: { two: {} }});
        }        
        
        [Test]
        public function describesMismatchWithUnexpectedValue():void 
        {
            assertMismatch(
                "was <5>", 
                hasPropertyChain("one.two.three", equalTo(4)), 
                { one: { two: { three: 5 } }});
        }
    }
}