package org.fluint.sequence.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.IEventDispatcher;
	
	import org.fluint.sequence.ISequencePend;
	import org.fluint.sequence.SequenceRunner;
	
	public class SequencePendMock implements ISequencePend
	{
		public var mock:Mock;
		
		public function get eventName():String
		{
			return mock.eventName;
		}
		
		public function get timeout():int
		{
			return mock.timeout;
		}
		
		public function get timeoutHandler():Function
		{
			return mock.timeoutHandler;
		}
		
		public function setupListeners(testCase:*, sequence:SequenceRunner):void
		{
			mock.setupListeners(testCase, sequence);
		}
		
		public function get target():IEventDispatcher
		{
			return mock.targetz;
		}
		
		public function SequencePendMock()
		{
			mock = new Mock(this);
		}
	}
}