package org.hamcrest.mxml.collection
{
	import org.hamcrest.mxml.AbstractMXMLMatcherTestCase;

	public class InArrayTest extends AbstractMXMLMatcherTestCase
	{
		/*
			<InArray>
		       <EqualTo value="{ 1 }"/>
		       <EqualTo value="{ 2 }"/>
		       <EqualTo value="{ 3 }"/>
			</InArray> 
		 */
		
		private var matcher:InArray;
		
		
		[Before]
		public function createMatcher():void 
		{
			matcher = new InArray();
		}
		
		[Test]
		public function hasDescriptionWithNoElements():void 
		{
			assertDescription("contained in []", matcher);
		}
		
		[Test]
		public function hasDescriptionWithElements():void 
		{
			matcher.elements = ['a', 'b', 'c'];
			
			assertDescription('contained in ["a", "b", "c"]', matcher);			
		}
		
		[Test]
		public function matchedIsTrueIfTargetMatches():void 
		{
			matcher.elements = ["a", "b", "c"];
			matcher.target = "a"
			
			assertMatched("matched if target matches", matcher);
		}
		
		[Test]
		public function matchedIsFalseIfTargetDoesNotMatch():void 
		{
			matcher.elements = ["b", "c"];
			matcher.target = "a"
			
			assertNotMatched("not matched if target does not match", matcher);			
		}
		
        [Test]
        public function mismatchDescriptionIsNullIfTargetMatches():void
        {
            matcher.elements = ['a', 'b', 'c'];
            matcher.target = 'a';

            assertMatchedMismatchDescription(matcher);
        }

        [Test]
        public function mismatchDescriptionIsSetIfTargetDoesNotMatch():void
        {
            matcher.elements = ['b', 'c'];
            matcher.target = 'a';

            assertMismatchDescription('"a" was not contained in ["b", "c"]', matcher);
        }
	}
}