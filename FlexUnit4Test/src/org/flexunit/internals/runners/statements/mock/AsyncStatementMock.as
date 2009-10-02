package org.flexunit.internals.runners.statements.mock
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.token.AsyncTestToken;
	
	public class AsyncStatementMock implements IAsyncStatement
	{
		public var mock:Mock;
		
		public function evaluate(parentToken:AsyncTestToken):void
		{
			mock.evaluate(parentToken);
		}
		
		public function toString():String {
			return mock.twoString();
		}
		
		public function AsyncStatementMock()
		{
			mock = new Mock( this );
		}
	}
}