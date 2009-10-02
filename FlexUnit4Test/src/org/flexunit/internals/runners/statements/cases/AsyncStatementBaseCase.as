package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.AsyncStatementBase;

	public class AsyncStatementBaseCase
	{
		//TODO: Ensure that this test case has been created correctly and that it contains
		//all necessary tests.  Can a test be created for send complete?
		
		[Test(description="Ensure that the toString method has the proper output")]
		public function toStringTest():void {
			var asyncStatementBase:AsyncStatementBase = new AsyncStatementBase();
			
			Assert.assertEquals("Async Statement Base", asyncStatementBase.toString());
		}
	}
}