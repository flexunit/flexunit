package org.flexunit.token.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.token.AsyncTestToken;
	
	public class AsyncTestTokenMock extends AsyncTestToken
	{
		public var mock:Mock;
		
		override public function get parentToken():AsyncTestToken {
			return mock.parentToken;
		}
		
		override public function set parentToken(value:AsyncTestToken):void {
			mock.parentToken = value;
		}
		
		override public function get error():Error {
			return mock.error;
		}
		
		override public function addNotificationMethod(method:Function, debugClassName:String=null):AsyncTestToken {
			return mock.addNotificationMethod(method, debugClassName);
		}
		
		override public function sendResult(error:Error=null):void {
			mock.sendResult(error);
		}
		
		override public function toString():String {
			return mock.toString();
		}
		
		public function AsyncTestTokenMock(debugClassName:String=null)
		{
			mock = new Mock( this );
			
			super(debugClassName);
		}
	}
}