package org.hamcrest.filter
{
	import org.flexunit.Assert;

	import org.hamcrest.core.not;
	import org.hamcrest.text.containsString;
	import org.hamcrest.text.emptyString;
	
	public class FilterFunctionTest extends Assert
	{
		private var filterFunction:FilterFunction;
		
		[Before]
		public function setup():void
		{
			filterFunction = new FilterFunction();
		}

		[Test]
		public function returnsTrueIfNoMatcher():void
		{
			filterFunction.matcher = null;
			
			assertTrue( filterFunction.filter( "test" ) );
		}
	
		[Test]
		public function returnsTrueIfValueMatchesMatcher():void
		{
			filterFunction.matcher = not( emptyString() );
			
			assertTrue( filterFunction.filter( "a non-empty string" ) );
		}
		
		[Test]
		public function returnsFalseIfValueDoesNotMatchMatcher():void
		{
			filterFunction.matcher = not( containsString("expected") );
			
			assertFalse( filterFunction.filter( "unexpected" ) );
		}
	}
}