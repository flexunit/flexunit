package tests.org.flexunit.events.cases
{
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.events.AsyncEvent;
	import org.flexunit.events.AsyncResponseEvent;

	public class AsyncResponseEventCase {

		[Test]
		public function shouldStoreTypeCorrectly():void {
			var asyncEvent:AsyncResponseEvent = new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED );
			assertEquals( AsyncResponseEvent.RESPONDER_FIRED, asyncEvent.type );

			var asyncEvent1:AsyncResponseEvent = new AsyncResponseEvent( "other" );
			assertEquals( "other", asyncEvent1.type );

		}
		
		[Test]
		public function shouldStoreOriginalResponder():void {
			var originalResponder:Object = new Object();
			
			var asyncEvent:AsyncResponseEvent = new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, originalResponder );
			
			assertStrictlyEquals( originalResponder, asyncEvent.originalResponder );
		}

		[Test]
		public function shouldStoreStatus():void {
			var asyncEvent:AsyncResponseEvent = new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, null, "MyStatus" );
			
			assertEquals( "MyStatus", asyncEvent.status );
		}

		public function shouldStoreData():void {
			var data:Object = new Object();
			
			var asyncEvent:AsyncResponseEvent = new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, null, null, data );
			
			assertStrictlyEquals( data, asyncEvent.data );
		}
		
		[Test]
		public function shouldPassParamsCorrectlyToSuperClass():void {
			var asyncEvent1:AsyncResponseEvent = new AsyncResponseEvent("async", false, false, null );
			
			assertFalse( asyncEvent1.bubbles );
			assertFalse( asyncEvent1.cancelable );
			
			var asyncEvent2:AsyncResponseEvent = new AsyncResponseEvent("async", true, true, null );
			
			assertTrue( asyncEvent2.bubbles );
			assertTrue( asyncEvent2.cancelable );
		}
		
		[Test(description="Ensure the AsyncResponseEvent is successfully cloned")]
		public function shouldBeAbleToCloneEvent():void {
			var originalResponder:Object = new Object();
			var status:String = "theStatus";
			var data:Object = new Object();

			var asyncEvent1:AsyncResponseEvent = new AsyncResponseEvent("async", true, false, originalResponder, status, data );
			var newAsyncEvent1:AsyncResponseEvent = asyncEvent1.clone() as AsyncResponseEvent;
			
			assertEquals( asyncEvent1.type, newAsyncEvent1.type );
			assertEquals( asyncEvent1.bubbles, newAsyncEvent1.bubbles );
			assertEquals( asyncEvent1.cancelable, newAsyncEvent1.cancelable );
			assertStrictlyEquals( originalResponder, newAsyncEvent1.originalResponder);
			assertEquals( asyncEvent1.status, newAsyncEvent1.status );
			assertStrictlyEquals( data, newAsyncEvent1.data );
			
			var asyncEvent2:AsyncResponseEvent = new AsyncResponseEvent("async", false, true, originalResponder, status, data );
			var newAsyncEvent2:AsyncResponseEvent = asyncEvent2.clone() as AsyncResponseEvent;
			
			assertEquals( asyncEvent2.type, newAsyncEvent2.type );
			assertEquals( asyncEvent2.bubbles, newAsyncEvent2.bubbles );
			assertEquals( asyncEvent2.cancelable, newAsyncEvent2.cancelable );
			assertStrictlyEquals( originalResponder, newAsyncEvent2.originalResponder);
			assertEquals( asyncEvent2.status, newAsyncEvent2.status );
			assertStrictlyEquals( data, newAsyncEvent2.data );
		}
	}
}