package org.hamcrest.core
{
	import org.hamcrest.*;
	
	public class EvaluateTest extends AbstractMatcherTestCase
	{	
		[Test]
		public function matchedIsTrueIfTrueExpression():void
		{
			assertMatches( "should match", evaluate( true ), "test" );
		}

		[Test]
		public function matchedIsFalseIfFalseExpression():void
		{
			assertDoesNotMatch( "should not match", evaluate( false ), "test" );
		}
	}
}
