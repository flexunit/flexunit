package suite {
	import suite.cases.BasicMathTest;
	import suite.cases.MyTheory;
	

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class FlexUnitIn360 {
		public var t1:BasicMathTest;
		public var t2:MyTheory;
	}
	
}