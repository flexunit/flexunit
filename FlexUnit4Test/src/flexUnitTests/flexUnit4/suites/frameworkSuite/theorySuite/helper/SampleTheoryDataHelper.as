package flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite.helper {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.runner.external.ExternalDependencyToken;
	import org.flexunit.runner.external.IExternalDependencyLoader;

	public class SampleTheoryDataHelper implements IExternalDependencyLoader {
		private var dToken:ExternalDependencyToken;
		private var timer:Timer;

		private function success( data:TimerEvent ):void {
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, success );
			dToken.notifyResult( [1,2,3,4,5,6,7,8,9] );
		}
		
		private function failure( info:* ):void {
			//dToken.notifyResult( fakeData );
			//dToken.notifyFault( info.fault.message );
			dToken.notifyFault( "Totally broken" );
		}
		
		public function retrieveDependency( testClass:Class ):ExternalDependencyToken {
			timer.start();

			return dToken;
		}
		
		public function SampleTheoryDataHelper( url:String ) {
			timer = new Timer( 250, 1 );
			timer .addEventListener(TimerEvent.TIMER_COMPLETE, success );
			//Just fake this with a timer to illustrate the point

			dToken = new ExternalDependencyToken();
		}
	}
}
