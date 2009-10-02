package org.flexunit.runner.manipulation.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.manipulation.ISort;
	
	public class SortMock implements ISort
	{
		public var mock:Mock;
		
		public function SortMock()
		{
			mock = new Mock(this);
		}
	}
}