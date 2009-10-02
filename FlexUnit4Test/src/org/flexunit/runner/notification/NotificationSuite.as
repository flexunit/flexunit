package org.flexunit.runner.notification
{
	import org.flexunit.runner.notification.async.AsyncSuite;
	import org.flexunit.runner.notification.cases.FailureCase;
	import org.flexunit.runner.notification.cases.RunListenerCase;
	import org.flexunit.runner.notification.cases.RunNotifierCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class NotificationSuite
	{
 		public var asyncSuite:AsyncSuite;
		
		public var failureCase:FailureCase;
		public var runListenerCase:RunListenerCase;
		public var runNotifierCase:RunNotifierCase;
	}
}