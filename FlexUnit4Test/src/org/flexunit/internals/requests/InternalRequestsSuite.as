package org.flexunit.internals.requests
{
	import org.flexunit.internals.requests.cases.ClassRequestCase;
	import org.flexunit.internals.requests.cases.FilterRequestCase;
	import org.flexunit.internals.requests.cases.SortingRequestCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalRequestsSuite
	{
		public var classRequestCase:ClassRequestCase;
		public var filterRequestCase:FilterRequestCase;
		public var sortRequestCase:SortingRequestCase;
	}
}