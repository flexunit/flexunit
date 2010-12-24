package org.hamcrest.number
{
	import org.hamcrest.AbstractMatcherTestCase;

	public class IsNotANumberTest extends AbstractMatcherTestCase
	{
		[Test]
		public function shouldMatchNaN():void 
		{
			assertMatches("should match NaN", isNotANumber(), NaN); 
		}
		
		[Test]
		public function shouldNotMatchNumber():void 
		{
			assertDoesNotMatch("should not match 0", isNotANumber(), 0);
			assertDoesNotMatch("should not match positive number", isNotANumber(), 1);
			assertDoesNotMatch("should not match negative number", isNotANumber(), -1);
			assertDoesNotMatch("should not match positive infinity", isNotANumber(), Number.POSITIVE_INFINITY);
			assertDoesNotMatch("should not match negative infinity", isNotANumber(), Number.NEGATIVE_INFINITY);
		}
		
		[Test]
		public function shouldHaveAReadableDescription():void 
		{
			assertDescription("NaN", isNotANumber()); 
		}
	}
}