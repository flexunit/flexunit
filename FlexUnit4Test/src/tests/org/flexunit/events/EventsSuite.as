package tests.org.flexunit.events {
	import tests.org.flexunit.events.cases.AsyncEventCase;
	import tests.org.flexunit.events.cases.AsyncResponseEventCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EventsSuite {
		public var asyncEvent:AsyncEventCase;
		public var asyncResponseEventCase : AsyncResponseEventCase;
	}
}