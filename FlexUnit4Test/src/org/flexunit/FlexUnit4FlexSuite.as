package org.flexunit
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestAsynchronousFlex;
	
	import org.flexunit.async.cases.AsyncFlexCase;
	import org.flexunit.async.cases.AsyncTestResponderCase;
	import org.flexunit.async.cases.TestResponderCase;
	import org.flexunit.events.cases.AsyncResponseEventCase;
	import org.flexunit.internals.cases.TextListenerCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnit4FlexSuite
	{
		public var asyncFlexCase:AsyncFlexCase;
		
		public var asyncTestResponderCase:AsyncTestResponderCase;
		public var testResponderCase:TestResponderCase;
		public var asyncResponseEventCase:AsyncResponseEventCase;
		public var textListenerCase:TextListenerCase;
		
		public var testAsynchornousFlex:TestAsynchronousFlex;
	}
}