package org.flexunit.runner.notification.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;
	
	public class FailureMock extends Failure
	{
		public var mock:Mock;
		
		override public function get testHeader():String {
			return mock.testHeader;
		}
		
		override public function get description():IDescription {
			return mock.description;
		}
		
		override public function get exception():Error {
			return mock.exception;	
		}
		
		override public function toString():String {
			return mock.toString();
		}
		
		override public function get message():String {
			return mock.message;
		}
		
		override public function get stackTrace():String {
			return mock.stackTrace;	
		}
		
		//TODO: How the the constructor for the mock object be handled
		public function FailureMock(description:IDescription = null, exception:Error = null)
		{
			mock = new Mock( this );
			
			super(description, exception);
		}
	}
}