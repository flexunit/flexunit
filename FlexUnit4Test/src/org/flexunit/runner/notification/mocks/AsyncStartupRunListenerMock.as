package org.flexunit.runner.notification.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.Event;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;
	
	public class AsyncStartupRunListenerMock implements IAsyncStartupRunListener
	{
		public var mock:Mock;
		
		public function get ready():Boolean
		{
			return mock.ready;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			mock.addzEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			mock.removezEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return mock.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return mock.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return mock.willTrigger(type);
		}
		
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
		
		public function AsyncStartupRunListenerMock()
		{
			mock = new Mock(this);
		}
	}
}