package org.fluint
{
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestASComponentUse;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBindingUse;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestMXMLComponentUse;
	
	import org.fluint.sequence.SequenceSuite;
	import org.fluint.uiImpersonation.UIImpersonationSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnit4FluintSuite
	{
		
		public var sequenceSuite:SequenceSuite;
		public var uiImpersonationSuite:UIImpersonationSuite;
		
		public var testASComponentUse:TestASComponentUse;
		public var testMXMLComponentUse:TestMXMLComponentUse;
		public var testBindingUse:TestBindingUse;
	}
}