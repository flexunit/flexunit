package org.flexunit.internals.runners.model
{
	import org.flexunit.internals.runners.model.cases.EachTestNotifierCase;
	import org.flexunit.internals.runners.model.cases.MultipleFailureExceptionCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalRunnersModelSuite
	{
		public var eachTestNotifierCase:EachTestNotifierCase;
		public var multipleFailureExceptionCase:MultipleFailureExceptionCase;
	}
}