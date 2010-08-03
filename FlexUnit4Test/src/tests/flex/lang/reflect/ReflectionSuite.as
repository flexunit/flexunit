package tests.flex.lang.reflect {
	import tests.flex.lang.reflect.builders.BuilderSuite;
	import tests.flex.lang.reflect.constructor.ConstructorSuite;
	import tests.flex.lang.reflect.field.FieldSuite;
	import tests.flex.lang.reflect.klass.KlassSuite;
	import tests.flex.lang.reflect.metadata.MetaDataSuite;
	import tests.flex.lang.reflect.method.MethodSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ReflectionSuite {
		public var metaDataSuite:MetaDataSuite;
		public var fieldSuite:FieldSuite;
		public var methodSuite:MethodSuite;
		public var constructorSuite:ConstructorSuite;
		public var klassSuite:KlassSuite;
		public var builderSuite:BuilderSuite;
		
	}
}