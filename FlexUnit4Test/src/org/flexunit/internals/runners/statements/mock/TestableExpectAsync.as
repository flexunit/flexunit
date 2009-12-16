package org.flexunit.internals.runners.statements.mock
{
	import org.flexunit.internals.runners.statements.ExpectAsync;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	
	public class TestableExpectAsync extends ExpectAsync
	{
		public var errorWasCaught : Boolean = false;
		public var timersWereRestarted : Boolean = false;
		
		public function TestableExpectAsync(objectUnderTest:Object, statement:IAsyncStatement)
		{
			super(objectUnderTest, statement);
		}
		
		public function callProtect( method : Function, ...parameters ) : void
		{
			protect( method, parameters );
		}
		
		override protected function protect(method:Function, ...parameters):void
		{
			try {
				if ( parameters && parameters.length>0 ) {
					method.apply( this, parameters );
				} else {
					method();
				}
				
				if ( hasPendingAsync ) { 
					timersWereRestarted = true;
				} 
				
			} 
			catch (error:Error) {
				errorWasCaught = true;
			} 
		}
	}
}