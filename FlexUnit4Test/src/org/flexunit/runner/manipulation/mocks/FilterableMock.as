package org.flexunit.runner.manipulation.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runner.manipulation.IFilterable;
	
	public class FilterableMock implements IFilterable
	{
		public var mock:Mock;
		
		public function filter(filter:Filter):void
		{
			mock.filter(filter);
		}
		
		public function FilterableMock()
		{
			mock = new Mock();
		}
	}
}