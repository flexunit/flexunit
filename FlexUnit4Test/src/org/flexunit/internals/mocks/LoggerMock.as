package org.flexunit.internals.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.Event;
	
	import mx.logging.ILogger;
	
	public class LoggerMock implements ILogger
	{
		public var mock:Mock;
		
		public function get category():String
		{
			return mock.category;
		}
		
		public function log(level:int, message:String, ...parameters):void
		{
			mock.invokeMethod("log", [level, message].concat(parameters));
		}
		
		public function debug(message:String, ...parameters):void
		{
			mock.invokeMethod("debug", [message].concat(parameters));
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			mock.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			mock.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return mock.dispatchEvent(event);
		}
		
		public function error(message:String, ...parameters):void
		{
			mock.invokeMethod("error", [message].concat(parameters));
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return mock.hasEventListener(type);
		}
		
		public function fatal(message:String, ...parameters):void
		{
			mock.invokeMethod("fatal", [message].concat(parameters));
		}
		
		public function willTrigger(type:String):Boolean
		{
			return mock.willTrigger(type);
		}
		
		public function info(message:String, ...parameters):void
		{
			mock.invokeMethod("info", [message].concat(parameters));
		}
		
		public function warn(message:String, ...parameters):void
		{
			mock.invokeMethod("warn", [message].concat(parameters));
		}
		
		public function LoggerMock()
		{
			mock = new Mock( this );
		}
	}
}