package org.hamcrest.number
{
	import org.hamcrest.AbstractMatcherTestCase;

	public class IsNumberTest extends AbstractMatcherTestCase
	{		
		[Test]
		public function shouldMatchNumber():void 
		{
			assertMatches("should match 0", isNumber(), 0);
			assertMatches("should match positive number", isNumber(), 1);
			assertMatches("should match negative number", isNumber(), -1);
			assertMatches("should match maximum number", isNumber(), Number.MAX_VALUE);
			assertMatches("should match minimum number", isNumber(), Number.MIN_VALUE);
		}
		
		[Test]
		public function shouldNotMatchNaN():void 
		{
			assertDoesNotMatch("should not match NaN", isNumber(), NaN);
		}
		
		[Test]
		public function shouldNotMatchInfinity():void 
		{
			assertDoesNotMatch("should not match positive infinity", isNumber(), Number.POSITIVE_INFINITY);
			assertDoesNotMatch("should not match negative infinity", isNumber(), Number.NEGATIVE_INFINITY);
		}
		
		[Test]
		public function shouldNotMatchNonNumber():void 
		{
			assertDoesNotMatch("should not match `true`", isNumber(), true);
			assertDoesNotMatch("should not match `false`", isNumber(), false);
			assertDoesNotMatch("should not match Object", isNumber(), {});
			assertDoesNotMatch("should not match Class", isNumber(), Number);
		}
		
		[Test]
		public function shouldHaveAReadableDescription():void 
		{
			assertDescription("a Number", isNumber());
		}
	}
}