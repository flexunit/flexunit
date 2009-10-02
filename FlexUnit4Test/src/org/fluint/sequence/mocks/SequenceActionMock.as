package org.fluint.sequence.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.IEventDispatcher;
	
	import org.fluint.sequence.ISequenceAction;
	
	public class SequenceActionMock implements ISequenceAction
	{
		public var mock:Mock;
		
		public function execute():void
		{
			mock.execute();
		}
		
		public function get target():IEventDispatcher
		{
			return mock.targetz;
		}
		
		public function SequenceActionMock()
		{
			mock = new Mock(this);
		}
	}
}