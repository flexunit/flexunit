package org.flexunit.experimental.theories.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.experimental.theories.IPotentialAssignment;
	
	public class PotentialAssignmentMock implements IPotentialAssignment
	{
		public var mock:Mock;
		
		public function getValue():Object {
			return mock.getValue();
		}
		
		public function getDescription():String {
			return mock.getDescription();
		}
		
		public function toString():String {
			return mock.toString();
		}
		
		public function PotentialAssignmentMock()
		{
			mock = new Mock(this);
		}
	}
}