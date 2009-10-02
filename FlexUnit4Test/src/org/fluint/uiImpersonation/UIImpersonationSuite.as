package org.fluint.uiImpersonation
{
	import org.fluint.uiImpersonation.cases.TestEnvironmentCase;
	import org.fluint.uiImpersonation.cases.UIImpersonatorCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class UIImpersonationSuite
	{
		public var testEnvironmentCase:TestEnvironmentCase;
		public var uiImpersonationCase:UIImpersonatorCase;
	}
}