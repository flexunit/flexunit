package tests.org.flexunit.assert.assumption
{
	import flexunit.framework.Assert;
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assume;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.hamcrest.object.nullValue;
	
	public class AssumeCase
	{
		[Test(description="Ensure assumeTrue succeeds when a 'true' argument is passed")] 
		public function shouldPassAsTrue():void {
			try {
				Assume.assumeTrue(true);
			} catch(e:AssumptionViolatedException) {
				throw new AssertionFailedError("Assumption Violated");
			}
		}
		
		[Test(expected="org.flexunit.internals.AssumptionViolatedException",
			description="Ensure assumeTrue fails when a 'false' argument is passed")]
		public function shouldFailAsFalse():void { 		
			Assume.assumeTrue(false);
		}
		
		[Test(description="Ensure assumneNotNull succeeds when no arguments are passed")] 
		public function shouldPassAsNoObjectsPassed():void { 
			try {
				Assume.assumeNotNull();
			} catch(e:AssumptionViolatedException) {
				throw new AssertionFailedError("Assumption Violated");
			}
		}
		
		[Test(description="Ensure assumneNotNull succeeds when a signle non-null argument is passed")] 
		public function shouldPassAsSingleObjectNotNull():void { 
			try {
				Assume.assumeNotNull(new Object());
			} catch(e:AssumptionViolatedException) {
				throw new AssertionFailedError("Assumption Violated");
			}
		}
		
		[Test(description="Ensure assumneNotNull succeeds when multiple non-null arguments are passed")] 
		public function shouldPassAsAllObjectsNotNull():void { 
			try {
				Assume.assumeNotNull(new Object(), new Object(), new Object());
			} catch(e:AssumptionViolatedException) {
				throw new AssertionFailedError("Assumption Violated");
			}
		}
		
		[Test(expected="org.flexunit.internals.AssumptionViolatedException",
			description="Ensure assumneNotNull fails for a sigle null argument")]
		public function shouldFailAsSingleArgIsNull():void { 
			Assume.assumeNotNull(null);
		}
		
		[Test(expected="org.flexunit.internals.AssumptionViolatedException",
			description="Ensure assumneNotNull fails for multiple arguments with one being a null argument")]
		public function shouldFailAsOneObjectOfManyIsNull():void { 
			Assume.assumeNotNull(new Object(), new Object(), null, new Object());
		}
		
		
		[Test(description="Ensure assumeThatNoException passes when no exception argument is passed")]
		public function shouldPassAsNoExceptionPassed():void {
			try {
				Assume.assumeNoException(null);
			} catch(e:AssumptionViolatedException) {
				throw new AssertionFailedError("Assumption Violated");
			}
		}
		
		[Test(expected="org.flexunit.internals.AssumptionViolatedException",
			description="Ensure assumeThatNoException fails when an exception argument is passed")]
		public function shouldFailAsProvidedException():void { 
			Assume.assumeNoException(new Error);
		}
	}
}