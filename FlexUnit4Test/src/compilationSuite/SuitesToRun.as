package compilationSuite
{
	import compilationSuite.actionscript.ActionScriptSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SuitesToRun {		
		public var flexUnit4ASSuite:ActionScriptSuite;
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		CONFIG::useFlexClasses {
			import compilationSuite.flex.FlexSuite;
			
			public var flexSuite:FlexSuite;
		}
	}
}