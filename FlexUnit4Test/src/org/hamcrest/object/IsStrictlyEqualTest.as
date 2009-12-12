package org.hamcrest.object
{
    
    import org.hamcrest.*;
    import org.hamcrest.core.not;
    
    public class IsStrictlyEqualTest extends AbstractMatcherTestCase
    {
        
        [Test]
        public function matchesStrictly():void
        {
            var o1:Object = {};
            var o2:Object = {};
            
            assertMatches("should match with ===", strictlyEqualTo(o1), o1);
            assertDoesNotMatch("should match with ===", strictlyEqualTo(o1), o2);
        }
    }
}