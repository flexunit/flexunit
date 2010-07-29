package compilationSuite.actionscript {
	import compilationSuite.FlexUnit4ASSuite;
	
	import tests.flex.lang.reflect.ReflectionSuite;
	import tests.org.flexunit.assert.AssertionAndAssumptionSuite;
	import tests.org.flexunit.async.AsyncSuite;
	import tests.org.flexunit.events.EventsSuite;
	import tests.org.flexunit.runner.util.DescriptionUtilTest;
	import tests.org.flexunit.token.TokenSuite;
	import tests.org.flexunit.utils.UtilsSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ActionScriptSuite {
		public var reflectionSuite:ReflectionSuite;
		public var assertSuite:AssertionAndAssumptionSuite;
		public var eventSuite:EventsSuite;
		public var utilsSuite:UtilsSuite;
		public var tokenSuite:TokenSuite;
		public var async:AsyncSuite;

		public var descriptionUtil:DescriptionUtilTest;
		public var flexUnit4ASSuite:FlexUnit4ASSuite;
	}
}