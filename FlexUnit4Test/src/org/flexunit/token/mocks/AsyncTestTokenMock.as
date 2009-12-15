package org.flexunit.token.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.IAsyncTestToken;
	
	public class AsyncTestTokenMock extends AsyncTestToken
	{
		public var mock:Mock;
		
		override public function get parentToken():IAsyncTestToken {
			return mock.parentToken;
		}
		
		override public function set parentToken(value:IAsyncTestToken):void {
			mock.parentToken = value;
		}
		
		override public function get error():Error {
			return mock.error;
		}
		
		override public function addNotificationMethod(method:Function, debugClassName:String=null):IAsyncTestToken {
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