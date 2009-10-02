package org.flexunit.events
{
	import org.flexunit.events.cases.AsyncEventCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EventsSuite
	{
		public var asyncEvent:AsyncEventCase;
	}
}