package org.hamcrest.core
{
	import org.hamcrest.AbstractMatcherTestCase;
	
	public class GivenTest extends AbstractMatcherTestCase
	{
		[Test]
		public function matchedIsTrueIfTrueExpressionAndValueMatcherMatches():void
		{
			assertMatches( "should match", given( true, anything() ), "anything" );
			assertMatches( "should match", given( true, anything(), false ), "anything" );
		}

		[Test]
		public function matchedIsFalseIfTrueExpressionAndValueMatcherDoesNotMatch():void
		{
			assertDoesNotMatch( "should not match", given( true, not( anything() ) ), "anything" );
			assertDoesNotMatch( "should not match", given( true, not( anything() ), false ), "anything" );
		}
		
		[Test]
		public function matchedIsFalseIfFalseExpression():void
		{
			assertDoesNotMatch( "should not match", given( false, anything() ), "anything" );
			assertDoesNotMatch( "should not match", given( false, anything(), false ), "anything" );
			assertDoesNotMatch( "should not match", given( false, not( anything() ) ), "anything" );
			assertDoesNotMatch( "should not match", given( false, not( anything() ), false ), "anything" );
		}
		
		[Test]
		public function matchedIsTrueIfFalseExpressionAndOptionalOtherwiseSpecifiedAsTrue():void
		{
			assertMatches( "should match", given( false, not( anything() ), true ), "anything" );
			assertMatches( "should match", given( false, not( anything() ), true ), "anything" );
		}
	}
}