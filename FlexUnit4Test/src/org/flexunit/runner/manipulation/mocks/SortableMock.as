package org.flexunit.runner.manipulation.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.Assert;
	import org.flexunit.runner.manipulation.ISortable;
	import org.flexunit.runner.manipulation.ISorter;
	
	public class SortableMock implements ISortable
	{
		public var mock:Mock;
		
		public function sort(sorter:ISorter):void
		{
			mock.sort(sorter);
		}
		
		public function SortableMock()
		{
			mock = new Mock( this );
		}
	}
}