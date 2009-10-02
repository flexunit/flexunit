package org.flexunit.runners.model.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.mocks.RequestMock;
	import org.flexunit.runner.mocks.RunnerMock;
	import org.flexunit.runners.model.RunnerBuilderBase;

	public class RunnerBuilderBaseCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var runnerBuilderBase:RunnerBuilderBase;
		
		[Before(description="Create an instance of the RunnerBuilderBase class")]
		public function createRunnerBuilderBase():void {
			runnerBuilderBase = new RunnerBuilderBase();
		}
		
		[After(description="Remove the reference to the instance of the RunnerBuilderBase class")]
		public function destroyRunnerBuilderBase():void {
			runnerBuilderBase = null;
		}
		
		//TODO: Is it even possible to get to the "return null" at the bottom of the safeRunnerForClass
		[Ignore]
		[Test(description="Ensure that the safeRunnerForClass returns an IRunner when no exception is thrown")]
		public function safeRunnerForClassTest():void {
			Assert.assertTrue( runnerBuilderBase.safeRunnerForClass(Object) is IRunner );
		}
		
		//TODO: This test cannot currently be tested because there is no way to throw an exception
		[Test(description="Ensure that the safeRunnerForClass returns an ErrorReportingRunner when an exception is thrown")]
		public function safeRunnerForClassCatchTest():void {
			
		}
		
		//TODO: There currently does not appear to be a way to properly test add parent and remove parent
		[Test(description="Ensure that the runners functions retruns an array of runners")]
		public function runnersTest():void {
			var requestMock:RequestMock = new RequestMock();
			var runnerMock:RunnerMock = new RunnerMock();
			var children:Array = [null, requestMock];
			
			requestMock.mock.property("iRunner").returns(runnerMock);
			
			var runners:Array = runnerBuilderBase.runners(Object, children);
			
			Assert.assertEquals( 1, runners.length );
			Assert.assertEquals( runnerMock, runners[0] );
		}
		
		//TODO: Will this actually be returning an instance of the IRunner?
		[Test(description="Ensure that the runnerForClass function correctly returns an instance of an IRunner")]
		public function runnerForClassTest():void {
			Assert.assertNull( runnerBuilderBase.runnerForClass(Object) );
		}
	}
}