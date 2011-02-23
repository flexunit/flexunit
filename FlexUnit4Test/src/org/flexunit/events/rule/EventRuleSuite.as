package org.flexunit.events.rule
{
	import org.flexunit.events.rule.cases.AsyncEventQuantityTesting;
	import org.flexunit.events.rule.cases.AsyncEventTesting;
	import org.flexunit.events.rule.cases.SyncEventQuantityTesting;
	import org.flexunit.events.rule.cases.SyncEventTesting;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EventRuleSuite
	{
		public var t1:SyncEventTesting;
		public var t2:SyncEventQuantityTesting;
		public var t3:AsyncEventTesting;
		public var t4:AsyncEventQuantityTesting;
	}
}