package org.flexunit.runner.notification.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunListener;
	
	public class RunListenerMock implements IRunListener
	{
		public var mock:Mock;
		
		public function testRunStarted(description:IDescription):void
		{
			mock.testRunStarted(description);
		}
		
		public function testRunFinished(result:Result):void
		{
			mock.testRunFinished(result);
		}
		
		public function testStarted(description:IDescription):void
		{
			mock.testStarted(description);
		}
		
		public function testFinished(description:IDescription):void
		{
			mock.testFinished(description);
		}
		
		public function testFailure(failure:Failure):void
		{
			mock.testFailure(failure);
		}
		
		public function testAssumptionFailure(failure:Failure):void
		{
			mock.testAssumptionFailure(failure);
		}
		
		public function testIgnored(description:IDescription):void
		{
			mock.testIgnored(description);
		}
		
		public function RunListenerMock()
		{
			mock = new Mock( this );
		}
	}
}