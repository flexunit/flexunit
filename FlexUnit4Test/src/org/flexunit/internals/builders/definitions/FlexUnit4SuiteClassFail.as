package org.flexunit.internals.builders.definitions
{
	[Suite]
	[RunWith(description="This will fail because the class path should go first.", "org.flexunit.runners.Suite")]
	public class FlexUnit4SuiteClassFail
	{
		public var flexUnit4Class:FlexUnit4Class;
	}
}