package org.flexunit.runner.notification.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.Assert;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunListener;
	import org.flexunit.runner.notification.IRunNotifier;
	
	public class RunNotifierMock implements IRunNotifier
	{
		public var mock:Mock;
		
		public function fireTestRunStarted(description:IDescription):void
		{
			mock.fireTestRunStarted(description);
		}
		
		public function fireTestRunFinished(result:Result):void
		{
			mock.fireTestRunFinished(result);
		}
		
		public function fireTestStarted(description:IDescription):void
		{
			mock.fireTestStarted(description);
		}
		
		public function fireTestFailure(failure:Failure):void
		{
			mock.fireTestFailure(failure);
		}
		
		public function fireTestAssumptionFailed(failure:Failure):void
		{
			mock.fireTestAssumptionFailed(failure);
		}
		
		public function fireTestIgnored(description:IDescription):void
		{
			mock.fireTestIgnored(description);
		}
		
		public function fireTestFinished(description:IDescription):void
		{
			mock.fireTestFinished(description);
		}
		
		public function addListener(listener:IRunListener):void
		{
			mock.addListener(listener);
		}
		
		public function addFirstListener(listener:IRunListener):void
		{
			mock.addFirstListener(listener);
		}
		
		public function removeListener(listener:IRunListener):void
		{
			mock.removeListener(listener);
		}

		public function removeAllListeners():void {
			mock.removeAllListeners();
		}

		public function pleaseStop():void
		{
			mock.pleaseStop();
		}

		public function RunNotifierMock()
		{
			mock = new Mock( this, true );
		}
	}
}