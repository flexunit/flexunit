package org.flexunit.token
{
	import org.flexunit.token.cases.AsyncListenersTokenCase;
	import org.flexunit.token.cases.AsyncTestTokenCase;
	import org.flexunit.token.cases.ChildResultCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TokenSuite
	{
		public var asyncListenersTokenCase:AsyncListenersTokenCase;
		public var asynTestTokenCase:AsyncTestTokenCase;
		public var childResultCase:ChildResultCase;
	}
}