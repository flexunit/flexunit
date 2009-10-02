package org.flexunit.async.mocks
{
	import com.anywebcam.mock.Mock;
	
	import mx.rpc.IResponder;
	
	public class ResponderMock implements IResponder
	{
		public var mock:Mock;
		
		public function result(data:Object):void
		{
			mock.result(data);
		}
		
		public function fault(info:Object):void
		{
			mock.fault(info);
		}
		
		public function ResponderMock()
		{
			mock = new Mock();
		}
	}
}