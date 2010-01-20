package org.flexunit.runner.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.IAsyncTestToken;
	
	public class RunnerMock implements IRunner
	{
		public var mock:Mock;
		
		public function run(notifier:IRunNotifier, previousToken:IAsyncTestToken):void
		{
			mock.run(notifier, previousToken);
		}
		
		public function get description():IDescription
		{
			return mock.description;
		}
		
		public function RunnerMock()
		{
			mock = new Mock(this);
		}
	}
}