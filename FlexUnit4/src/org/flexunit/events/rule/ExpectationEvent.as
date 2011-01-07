package org.flexunit.events.rule {
	import flash.events.Event;
	
	public class ExpectationEvent extends Event {
		public var reason:String;
		public static const FAIL_EXPECTATION:String = "failEventExpectation";
		public static const PASS_EXPECTATION:String = "passEventExpectation";

		public function ExpectationEvent( type:String, reason:String ) {
			this.reason = reason;
			super(type, false, false );
		}
	}
}