package compilationSuite
{
	import org.flexunit.FlexUnit4FlexSuite;
	import org.fluint.FlexUnit4FluintSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SuitesToRun
	{
		public var flexUnit4ASSuite:FlexUnit4ASSuite;
		
		// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
		// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
		// flex classes since it will cause errors.
		CONFIG::useFlexClasses
		public var flexUnit4FlexSuite:FlexUnit4FlexSuite;
		
		CONFIG::useFlexClasses
		public var flexUnit4FluintSuite:FlexUnit4FluintSuite;
	}
}