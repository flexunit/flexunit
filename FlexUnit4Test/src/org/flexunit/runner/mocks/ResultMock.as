package org.flexunit.runner.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.RunListener;
	
	public class ResultMock extends Result
	{
		public var mock:Mock;
		
		override public function get failureCount():int {
			return mock.failureCount;
		}
		
		override public function get failures():Array {
			return mock.failures;	
		}
		
		override public function get ignoreCount():int {
			return mock.ignoreCount;	
		}
		
		override public function get runCount():int {
			return mock.runCount;	
		}
		
		override public function get runTime():Number {
			return mock.runTime;	
		}
		
		override public function get successful():Boolean {
			return mock.successful;
		}
		
		override public function createListener():RunListener {
			return mock.createListener();
		}
		
		public function ResultMock()
		{
			mock = new Mock( this)
		}
	}
}