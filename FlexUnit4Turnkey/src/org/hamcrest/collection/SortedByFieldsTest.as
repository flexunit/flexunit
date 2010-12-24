package org.hamcrest.collection
{
    import mx.collections.ArrayCollection;
    import mx.collections.SortField;
    
    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.Matcher;
    
    public class SortedByFieldsTest extends AbstractMatcherTestCase
    {
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
        
        [Test]
        public function shouldMatchArrayInSortedOrderFor1SortField():void 
        {
            assertMatches("should match array in sorted order for 1 SortField",
                sortedByFields([ new SortField("value") ]), 
                [
                { value: "Cats" },
				{ value: "bats" },
				{ value: "cats" },				
				{ value: "hats" }
                ]);
        }
        
        [Test]
        public function shouldMatchArrayInSortedOrderFor2SortFields():void
        {
            assertMatches("should match array in sorted order for 2 SortFields",
                sortedByFields([ new SortField("value1"), new SortField("value2") ]), 
                [
                { value1: "1", value2: "1" },
				{ value1: "1", value2: "2" },
				{ value1: "2", value2: "2" },				
				{ value1: "3", value2: "1" }
                ]);
        }
        
        [Test]
		public function doesNotMatchNull():void 
		{
			assertDoesNotMatch("should not match null", 
			    sortedByFields([new SortField('value')]), 
			    null);
		}
		
		[Test]
		public function hasAReadableDescription():void 
		{
			assertDescription("an Array sorted by [\"value1\",\"value2\"]", 
			    sortedByFields([new SortField('value1'), new SortField('value2')]));			
		}
    }
}