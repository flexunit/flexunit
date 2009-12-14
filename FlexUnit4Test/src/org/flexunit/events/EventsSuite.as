package org.flexunit.events
{
	import org.flexunit.events.cases.AsyncEventCase;
	import org.flexunit.events.cases.AsyncResponseEventCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EventsSuite
	{
		public var asyncEvent:AsyncEventCase;
		public var asyncResponseEventCase : AsyncResponseEventCase;
	}
}