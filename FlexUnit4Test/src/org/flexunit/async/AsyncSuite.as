package org.flexunit.async
{
	import org.flexunit.async.cases.AsyncASCase;
	import org.flexunit.async.cases.AsyncHandlerCase;
	import org.flexunit.async.cases.AsyncLocatorCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite
	{	
		public var ayncCase:AsyncASCase;
		public var asyncHandlerCase:AsyncHandlerCase;
		public var asyncLocatorCase:AsyncLocatorCase;
	}
}