package org.flexunit.async.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public class EventDispatcherMock implements IEventDispatcher
	{
		public var mock:Mock;
		
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
			return mock.dispatchzEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return mock.hazEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return mock.willzTrigger(type);
		}
		
		//This property has been added for several tests
		[Bindable]
		public var testProperty:Object;
		
		public function EventDispatcherMock()
		{
			mock = new Mock(this);
		}
	}
}