package org.flexunit.async
{
	import org.flexunit.async.cases.AsyncASCase;
	CONFIG::useFlexClasses
	{
	import org.flexunit.async.cases.AsyncFlexCase;
	}
	import org.flexunit.async.cases.AsyncHandlerCase;
	import org.flexunit.async.cases.AsyncLocatorCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite
	{	
		public var asyncCase:AsyncASCase;
		CONFIG::useFlexClasses
		{
		public var asyncFlexCase : AsyncFlexCase;
		import org.flexunit.async.cases.AsyncTestResponderCase;
		public var asyncTestRespondingCase : AsyncTestResponderCase;
		import org.flexunit.async.cases.TestResponderCase;
		public var testResponderCase : TestResponderCase;
		}
		public var asyncHandlerCase:AsyncHandlerCase;
		public var asyncLocatorCase:AsyncLocatorCase;
	}
}