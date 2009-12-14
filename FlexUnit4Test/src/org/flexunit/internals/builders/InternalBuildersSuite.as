package org.flexunit.internals.builders
{
	import org.flexunit.internals.builders.cases.AllDefaultPossibilitiesBuilderASCase;
	import org.flexunit.internals.builders.cases.FlexUnit1BuilderCase;
	import org.flexunit.internals.builders.cases.FlexUnit4BuilderCase;
	import org.flexunit.internals.builders.cases.IgnoredBuilderCase;
	import org.flexunit.internals.builders.cases.IgnoredClassRunnerCase;
	import org.flexunit.internals.builders.cases.MetaDataBuilderCase;
	import org.flexunit.internals.builders.cases.NullBuilderCase;
	import org.flexunit.internals.builders.cases.SuiteMethodBuilderCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalBuildersSuite
	{
		public var ignoreClassRunnerCase:IgnoredClassRunnerCase;
		public var allDefaultPossibilitiesCase:AllDefaultPossibilitiesBuilderASCase;
		public var flexUnit1BuilderCase:FlexUnit1BuilderCase;
		public var flexUnit4BuilderCase:FlexUnit4BuilderCase;
CONFIG::useFlexClasses
		public var fluint1BuilderCase:org.flexunit.internals.builders.cases.Fluint1BuilderCase;

		public var ignoredBuilderCase:IgnoredBuilderCase;
		public var ignoredClassRunnerCase :IgnoredClassRunnerCase;
		public var suiteMethodBuilderCase:SuiteMethodBuilderCase;
		
		public var metaDataBuilderCase : MetaDataBuilderCase;
		
		//empty test case
		//public var nullBuilderCase : NullBuilderCase;
	}
}