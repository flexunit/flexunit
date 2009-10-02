package flexUnitTests.flexUnit4.suites.frameworkSuite.cases.helper {
	import flash.events.EventDispatcher;
	
	import org.flexunit.async.IAsyncTestResponder;
	import org.flexunit.events.AsyncResponseEvent;

	/**Sample responder to prove case where responder implenting IAsyncTestResponder are passed directly to the framework's async methods **/
	[Event(name="responderFired",type="net.digitalprimates.fluint.events.AsyncResponseEvent")]
	
	public class MySpecialResponder extends EventDispatcher implements IAsyncTestResponder {
		/**
		 *  @private
		 */
		private var _resultHandler:Function;
		
		/**
		 *  @private
		 */
		private var _faultHandler:Function;

		public function fault( info:Object ):void {
			_faultHandler( info );
			dispatchEvent( new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, this, 'fault', info ) );
		}
		
		public function result( data:Object ):void {
			_resultHandler( data );
			dispatchEvent( new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, this, 'result', data ) );
		}
		
		public function MySpecialResponder(result:Function, fault:Function) {
			super();
			_resultHandler = result;
			_faultHandler = fault;
		}
	}
}