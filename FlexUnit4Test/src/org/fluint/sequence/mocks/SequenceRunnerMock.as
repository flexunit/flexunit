package org.fluint.sequence.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.fluint.sequence.SequenceRunner;
	
	public class SequenceRunnerMock extends SequenceRunner
	{
		//TODO: This mock nees to be fully fleshed out
		
		public var mock:Mock;
		
		public function SequenceRunnerMock(testCase:* = null)
		{
			mock = new Mock(this);
			
			super(testCase);
		}
	}
}