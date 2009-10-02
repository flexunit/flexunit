package org.fluint.sequence.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.IEventDispatcher;
	
	import org.fluint.sequence.ISequenceStep;
	
	public class SequenceStepMock implements ISequenceStep
	{
		public var mock:Mock;
		
		public function get target():IEventDispatcher
		{
			return mock.targetz;
		}
		
		public function SequenceStepMock()
		{
			mock = new Mock(this);
		}
	}
}