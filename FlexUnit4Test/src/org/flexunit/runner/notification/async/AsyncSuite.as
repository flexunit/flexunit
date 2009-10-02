package org.flexunit.runner.notification.async
{
	import org.flexunit.runner.notification.async.cases.AsyncListenerWatcherCase;
	import org.flexunit.runner.notification.async.cases.WaitingListenerCase;
	import org.flexunit.runner.notification.async.cases.XMLListenerCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite
	{
		public var asyncListenerWatcherCase:AsyncListenerWatcherCase;
		public var waitingListenerCase:WaitingListenerCase;
		//public var xmlListenerCase:XMLListenerCase;
	}
}