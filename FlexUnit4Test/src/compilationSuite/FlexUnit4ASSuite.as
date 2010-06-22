package compilationSuite
{
	import flex.lang.reflect.FlexUnit4ReflectSuite;
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.FlexUnit4Suite;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.parameterizedSuite.ParamSuite;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.rulesSuite.RulesSuite;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite.TheorySuite;
	
	import org.flexunit.FlexUnit4FlexUnitSuite;
	import org.hamcrest.HamcrestSuite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnit4ASSuite
	{
		public var flexUnit4ReflectSuite:FlexUnit4ReflectSuite;
		public var flexUnit4FlexUnitSuite:FlexUnit4FlexUnitSuite;
		public var flexUnit4Suite:FlexUnit4Suite;
		public var hamcreastSuite:HamcrestSuite;
		public var paramSuite:ParamSuite;
		public var rulesSuite:RulesSuite;
		public var theorySuite:TheorySuite;
	}
}