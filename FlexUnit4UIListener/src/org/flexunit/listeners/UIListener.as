package org.flexunit.listeners
{
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunListener;
	import org.flexunit.runner.notification.ITemporalRunListener;

	[Deprecated(replacement="TestRunnerBase can be used directly now.", since="4.1")]
	public class UIListener implements ITemporalRunListener
	{
		private var uiListener : ITemporalRunListener;
		
		public function UIListener( uiListener : ITemporalRunListener )
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
		
		public function testTimed( description:IDescription, runTime:Number ):void {
			this.uiListener.testTimed( description, runTime );
		}
	}
}