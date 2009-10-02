package org.flexunit.runner.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IRequest;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.Request;
	import org.flexunit.runner.manipulation.ISort;
	
	public class RequestMock implements IRequest
	{
		public var mock:Mock;
		
		public function get sort():ISort
		{
			return mock.sort;
		}
		
		public function set sort(value:ISort):void
		{
			mock.sort = value;
		}
		
		public function get iRunner():IRunner
		{
			return mock.iRunner;
		}
		
		public function filterWith(filterOrDescription:*):Request
		{
			return mock.filerWith(filterOrDescription);
		}
		
		public function RequestMock()
		{
			mock = new Mock(this);
		}
	}
}