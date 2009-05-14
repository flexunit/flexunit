package org.flexunit.listeners
{
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunListener;

	public class UIListener implements IRunListener
	{
		private var uiListener : IRunListener;
		
		public function UIListener( uiListener : IRunListener)
		{
			super();
			this.uiListener = uiListener;
		}
		
		public function testRunStarted( description:IDescription ):void {
			this.uiListener.testRunStarted( description );
		}
		
		public function testRunFinished( result:Result ):void {
			this.uiListener.testRunFinished( result );
		}
		
		public function testStarted( description:IDescription ):void {
			this.uiListener.testStarted(description );
		}
	
		public function testFinished( description:IDescription ):void {
			this.uiListener.testFinished( description );
		}
	
		public function testFailure( failure:Failure ):void {
			this.uiListener.testFailure( failure );
		}
	
		public function testAssumptionFailure( failure:Failure ):void {
			this.uiListener.testAssumptionFailure( failure );
		}
	
		public function testIgnored( description:IDescription ):void {
			this.uiListener.testIgnored( description );
		}
	}
}