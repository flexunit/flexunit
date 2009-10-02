package flex.lang.reflect
{
	import flex.lang.reflect.cases.ConstructorCase;
	import flex.lang.reflect.cases.FieldCase;
	import flex.lang.reflect.cases.KlassCase;
	import flex.lang.reflect.cases.MethodCase;
	import flex.lang.reflect.theories.MethodTheory;
	import flex.lang.reflect.utils.MetadataToolsCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FlexUnit4ReflectSuite
	{
		public var fieldCase:FieldCase;
		public var klassCase:KlassCase;
		public var methodCase:MethodCase;
		public var constructorCase:ConstructorCase;
		
		// utils
		public var metadataTools:MetadataToolsCase;
		
		//Theories
		public var methodTheory:MethodTheory;
	}
}