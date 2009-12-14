package org.hamcrest.collection
{
	import org.hamcrest.AbstractMatcherTestCase;
	
	public class InArrayTest extends AbstractMatcherTestCase
	{		
		[Test]
		public function matchesAnItemInArray():void 
		{
			assertMatches(
				"should match 'a' for array that contains 'a'", 
				inArray(['a', 'b', 'c']), 'a');
				
			assertMatches(
				"should match 'a' for array that contains 'a'", 
				inArray('a', 'b', 'c'), 'a');				
		}
		
		[Test]
		public function doesNotMatchIfNotInArray():void 
		{
			assertDoesNotMatch(
				"should not match 'b' for array that does not contain 'b'", 
				inArray(['b', 'c']), 'a');

			assertDoesNotMatch(
				"should not match 'b' for array that does not contain 'b'", 
				inArray('b', 'c'), 'a');
		}
				
		[Test]
		public function hasAReadableDescription():void
		{
			assertDescription('contained in ["a", "b", "c"]', inArray(['a', 'b', 'c']));
			assertDescription('contained in ["a", "b", "c"]', inArray('a', 'b', 'c'));
		}
		
		[Test]
		public function describesMismatch():void 
		{
			assertMismatch(
				'"a" was not contained in ["b", "c"]', 
				inArray('b', 'c'), 'a');
		}
	}
}