package org.flexunit.experimental.theories.internals.cases
{
	import org.flexunit.Assert;
	import org.flexunit.experimental.theories.internals.ParameterizedAssertionError;

	public class ParameterizedAssertionErrorCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly.
		//It is currently impossible to test the stringValueOf function.
		
		[Test(description="Ensure that the ParameterizedAssertionError constructor is correctly assigning parameter values")]
		public function constructorTest():void {
			var targetException:Error = new Error();
			var methodName:String = "methodName";
			var params:Array = new Array("valueOne", "valueTwo");
			
			var parameterizedAssertionError:ParameterizedAssertionError = new ParameterizedAssertionError(targetException, methodName, "valueOne", "valueTwo");
			
			var message:String = methodName + " " + params.join( ", " );
			Assert.assertEquals( message, parameterizedAssertionError.message);
			Assert.assertEquals( targetException, parameterizedAssertionError.targetException );
		}
		
		[Test(description="Ensure that the join function is correctly joining the delimiter to the other parameters")]
		public function joinTest():void {
			var delimiter:String = ", ";
			var params:Array = new Array("valueOne", "valueTwo", "valueThree");
			
			var message:String = params.join( delimiter );
			Assert.assertEquals( message, ParameterizedAssertionError.join(delimiter, "valueOne", "valueTwo", "valueThree") );
		}
	}
}