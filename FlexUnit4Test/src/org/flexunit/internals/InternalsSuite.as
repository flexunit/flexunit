package org.flexunit.internals
{
	import org.flexunit.internals.builders.InternalBuildersSuite;
	import org.flexunit.internals.cases.TraceListenerCase;
	import org.flexunit.internals.events.cases.ExecutionCompleteEventCase;
	import org.flexunit.internals.requests.InternalRequestsSuite;
	import org.flexunit.internals.runners.InternalRunnersSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalsSuite
	{
		public var internalBuildersSuite:InternalBuildersSuite;
		public var internalRequestSuite:InternalRequestsSuite;
		public var internalRunnersSuite:InternalRunnersSuite;
		
		public var executionCompletionEvent:ExecutionCompleteEventCase;
		public var traceListenerCase:TraceListenerCase;
		
		//Not yet implemented
	}
}