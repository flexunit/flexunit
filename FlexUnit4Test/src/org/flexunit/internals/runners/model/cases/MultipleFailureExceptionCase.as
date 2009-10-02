package org.flexunit.internals.runners.model.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.model.MultipleFailureException;

	public class MultipleFailureExceptionCase
	{
		//TODO: Ensure that the tests and test case have been implemented correctly
		
		[Test(description="Ensure that the failures array is correctly retrieved")]
		public function getFailuresTest():void {
			var errors:Array = new Array(new Error(), new Error());
			var multipleFailureException:MultipleFailureException = new MultipleFailureException(errors);
			
			Assert.assertEquals( errors, multipleFailureException.failures );
		}
		
		[Test(description="Ensure that an error is correctly added to the failure array with an already existing array")]
		public function addFailureWithArrayTest():void {
			var errors:Array = new Array(new Error(), new Error());
			var newError:Error = new Error();
			var multipleFailureException:MultipleFailureException = new MultipleFailureException(errors);
			
			Assert.assertEquals( 2, multipleFailureException.failures.length );
			
			multipleFailureException.addFailure(newError);
			
			Assert.assertEquals( 3, multipleFailureException.failures.length );
			Assert.assertEquals( newError, multipleFailureException.failures[2] as Error );
		}
		
		[Test(description="Ensure that an error is correctly added to a new array when the failures array is null")]
		public function addFailureWithNoArrayTest():void {
			var newError:Error = new Error();
			var multipleFailureException:MultipleFailureException = new MultipleFailureException(null);
			
			Assert.assertNull( multipleFailureException.failures );
			
			multipleFailureException.addFailure(newError);
			
			Assert.assertNotNull( multipleFailureException.failures );
			Assert.assertEquals( 1,  multipleFailureException.failures.length );
			Assert.assertEquals( newError, multipleFailureException.failures[0] as Error );
		}
	}
}