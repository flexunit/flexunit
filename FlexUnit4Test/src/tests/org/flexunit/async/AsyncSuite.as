package tests.org.flexunit.async {
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncSuite {
		CONFIG::useFlexClasses {		
			public var testResponder:TestResponderCase;
		}
		public var asyncResponder:AsyncTestResponderCase;
		public var nativeResponder:AsyncNativeTestResponderCase;
		public var asyncLocator:AsyncLocatorCase;
	}
}