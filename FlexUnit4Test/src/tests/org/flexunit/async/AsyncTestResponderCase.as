package tests.org.flexunit.async {
	import mockolate.runner.MockolateRule;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.async.AsyncTestResponder;
	import org.flexunit.events.AsyncResponseEvent;

	public class AsyncTestResponderCase {
		
		[Test(description="Ensure the result function is correctly called")]
		public function shouldEmmitResult():void {
			var data:Object = new Object();
			var originalResponder:Object = new Object();

			var responder:AsyncTestResponder = new AsyncTestResponder( originalResponder );
			responder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, 
				function ( event:AsyncResponseEvent ):void {
					assertStrictlyEquals( originalResponder, event.originalResponder );
					assertStrictlyEquals( data, event.data );
					assertEquals( "result", event.status );
				}
			);
			
			responder.result( data );
		}
		
		[Test(description="Ensure the fault function is correctly called")]
		public function shouldEmmitFault():void {
			var data:Object = new Object();
			var originalResponder:Object = new Object();
			
			var responder:AsyncTestResponder = new AsyncTestResponder( originalResponder );
			responder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, 
				function ( event:AsyncResponseEvent ):void {
					assertStrictlyEquals( originalResponder, event.originalResponder );
					assertStrictlyEquals( data, event.data );
					assertEquals( "fault", event.status );
				}
			);
			
			responder.fault( data );
		}

		[Test(description="Ensure the result function is correctly called")]
		public function shouldFunctionWithOurResponderOrData():void {
			var responder:AsyncTestResponder = new AsyncTestResponder( null );
			responder.addEventListener( AsyncResponseEvent.RESPONDER_FIRED, 
				function ( event:AsyncResponseEvent ):void {
					assertNull( event.originalResponder );
					assertNull( event.data );
					assertEquals( "result", event.status );
				}
			);
			
			responder.result( null );
		}
		
	}
}