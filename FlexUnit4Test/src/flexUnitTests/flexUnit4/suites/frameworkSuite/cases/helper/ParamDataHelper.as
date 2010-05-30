package flexUnitTests.flexUnit4.suites.frameworkSuite.cases.helper {
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.internals.dependency.AsyncDependencyToken;

	public class ParamDataHelper {
		private var dToken:AsyncDependencyToken;
		private var httpService:HTTPService;

		private function success( data:ResultEvent ):void {
			dToken.notifyResult( data.result );
		}
		
		private function failure( info:FaultEvent ):void {
			var fakeData:Array = [ [ 0, 0 ], [ 1, 2 ], [ 2, 4 ] ];
			dToken.notifyResult( fakeData );
			//dToken.notifyFault();
		}
		
		public function send():AsyncDependencyToken {
			var token:AsyncToken = httpService.send();
			token.addResponder( new Responder( success, failure ) );

			return dToken;
		}
		
		public function ParamDataHelper( url:String ) {
			httpService = new HTTPService();
			httpService.url = url;

			dToken = new AsyncDependencyToken();
		}
	}
}
