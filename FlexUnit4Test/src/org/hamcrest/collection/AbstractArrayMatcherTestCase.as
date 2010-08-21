package org.hamcrest.collection
{
    import mx.collections.ArrayCollection;
    
    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.Matcher;

    public class AbstractArrayMatcherTestCase extends AbstractMatcherTestCase
    {
        public function AbstractArrayMatcherTestCase()
        {
            super();
        }
        
        override public function assertMatches(message:String, matcher:Matcher, arg:Object):void 
        {
            super.assertMatches(message, matcher, arg);

            // To ensure that the matcher properly matches non-Array collecitons,
            // run the same test again, this time using an ArrayCollection.
            if (arg is Array) 
            {
                super.assertMatches(message + " (as ArrayCollection)", matcher, new ArrayCollection(arg as Array));
            }
        }
        
        override public function assertDoesNotMatch(message:String, matcher:Matcher, arg:Object):void
        {
            super.assertDoesNotMatch(message, matcher, arg);

            // To ensure that the matcher properly matches non-Array collecitons,
            // run the same test again, this time using an ArrayCollection.
            if (arg is Array) 
            {
                super.assertDoesNotMatch(message + " (as ArrayCollection)", matcher, new ArrayCollection(arg as Array));
            }
        }
    }
}
