package org.flexunit.async
{
	import org.flexunit.async.cases.AsyncASCase;
	import tests.org.flexunit.async.AsyncHandlerCase;
	import tests.org.flexunit.async.AsyncLocatorCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite
	{	
		public var asyncCase:AsyncASCase;
		public var asyncHandlerCase:AsyncHandlerCase;
		public var asyncLocatorCase:AsyncLocatorCase;
	}
}