package org.flexunit.async
{
	import org.flexunit.async.cases.AsyncASCase;
	import org.flexunit.async.cases.AsyncFlexCase;
	import org.flexunit.async.cases.AsyncHandlerCase;
	import org.flexunit.async.cases.AsyncLocatorCase;
	import org.flexunit.async.cases.AsyncTestResponderCase;
	import org.flexunit.async.cases.TestResponderCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite
	{	
		public var asyncCase:AsyncASCase;
		public var asyncFlexCase : AsyncFlexCase;
		public var asyncHandlerCase:AsyncHandlerCase;
		public var asyncLocatorCase:AsyncLocatorCase;
		public var asyncTestRespondingCase : AsyncTestResponderCase;
		public var testResponderCase : TestResponderCase;
	}
}