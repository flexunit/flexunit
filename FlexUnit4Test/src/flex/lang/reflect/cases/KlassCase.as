package flex.lang.reflect.cases
{
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.Assert;
	import org.flexunit.runner.RunnerLocator;
	import org.flexunit.runners.mocks.RunnerLocatorMock;
	
	public class KlassCase
	{
		protected var klass:Klass;
		
		[Before]
		public function setup():void {
			klass = new Klass( null );
		}
		
		[After]
		public function tearDown():void {
			klass = null;
		}
		
		[Test(description='check initialize Klass name property when constructor param is null')]
		public function check_initialize_Klass_name_with_null_contructor_param():void {
			klass = new Klass( null );
			Assert.assertEquals("", klass.name);
		}
		
		[Test(description='check initialize Klass name property when constructor param is not null')]
		public function check_initialize_Klass_name_with_nonNull_contructor_param():void {
			klass = new Klass( RunnerLocatorMock );
			Assert.assertEquals("org.flexunit.runners.mocks::RunnerLocatorMock", klass.name);
		}
		
		[Test(description='check initialize Klass clazz property when constructor param is null')]
		public function check_initialize_Klass_clazz_property_with_null_contructor_param():void {
			klass = new Klass( null );
			Assert.assertNull( klass.asClass );
		}
		
		[Test(description='check initialize Klass clazz property when constructor param is not null')]
		public function check_initialize_Klass_clazz_property_with_nonNull_contructor_param():void {
			klass = new Klass( Klass );
			// get the clazz property through the public asClass property
			var clazz:* = klass.asClass;
			Assert.assertNotNull( clazz );
			// create a new test class that should be of type Klass
			var testClass:* = new clazz( null );
			Assert.assertTrue( testClass is Klass );
		}
		
		[Test(description='ensure that fields of the class are returned properly')]
		public function check_get_fields():void {
			klass = new Klass( LocalTestClass );
			
			var fields:Array = klass.fields;
			Assert.assertEquals( 3, fields.length );
			
			// fields are not guaranteed to be returned in any type of order so 
			// sort them now so we can be sure we are checking the correct values in
			// our assertions.
			fields.sortOn( "name" );
			
			Assert.assertEquals( "aVar", fields[0].name );
			Assert.assertEquals( "bVar", fields[1].name );
			Assert.assertEquals( "cVar", fields[2].name );
		}
		
		[Test(description='ensure that methods of the class are returned properly')]
		public function check_get_methods():void {
			klass = new Klass( LocalTestClass );
			
			var methods:Array = klass.methods;
			Assert.assertEquals( 3, methods.length );
			
			// fields are not guaranteed to be returned in any type of order so 
			// sort them now so we can be sure we are checking the correct values in
			// our assertions.
			methods.sortOn( "name" );
			
			Assert.assertEquals( "aMethod", methods[0].name );
			Assert.assertEquals( "bMethod", methods[1].name );
			Assert.assertEquals( "cMethod", methods[2].name );
		}
		
		[Test(description='ensure that a method of the class is returned properly')]
		public function check_get_method():void {
			klass = new Klass( LocalTestClass );
			
			var method:Method = klass.getMethod( "bMethod" );
			
			Assert.assertEquals( "bMethod", method.name );
			Assert.assertEquals( 3, method.parameterTypes.length );
			
			Assert.assertStrictlyEquals( Number, method.parameterTypes[0] );
			Assert.assertStrictlyEquals( String, method.parameterTypes[1] );
			Assert.assertStrictlyEquals( Date, method.parameterTypes[2] );
		}
		
		[Test(description='ensure package name is returned properly')]
		public function check_get_packageName():void {
			klass = new Klass( RunnerLocatorMock );
			var packageName:String = klass.packageName;
			var expectedPackageName:String = "org.flexunit.runners.mocks";
			Assert.assertEquals( expectedPackageName, packageName );	
		}
		
		[Test(description="getMetadata")]
		public function check_get_metadata():void {
			klass = new Klass( RunnerLocatorMock );

			var metadata:MetaDataAnnotation = klass.getMetaData("Bindable" ); //,"event");
			var metadataArg:MetaDataArgument = metadata.getArgument( "event" );
			Assert.assertEquals('testMetadata', metadataArg.value );
		}
		
		[Test(description='ensure class definition is returned properly')]
		public function check_get_superClassName():void {
			klass = new Klass( RunnerLocatorMock );
			var classDef:Class = klass.classDef;
			
			var testClass:* = new classDef();
			Assert.assertTrue( testClass is RunnerLocatorMock );
		}
		
		[Test(description='ensure determine if klass is a descendant works properly')]
		public function check_klass_descendsFrom_true():void {
			klass = new Klass( RunnerLocatorMock );
			var descends:Boolean = klass.descendsFrom( RunnerLocator );
			Assert.assertTrue( descends );
		}
		
		[Test(description='ensure determine if klass is not a descendant works properly')]
		public function check_klass_descendsFrom_false():void {
			klass = new Klass( RunnerLocatorMock );
			var descends:Boolean = klass.descendsFrom( LocalTestClass );
			Assert.assertFalse( descends );
		}
		
		[Test(description='ensure we can generate a class definition from the class name')]
		public function check_generate_class_definition_from_class_name():void {
			var classDef:Class = Klass.getClassFromName("org.flexunit.runners.mocks::RunnerLocatorMock");
			var testClass:* = new classDef();
			Assert.assertTrue( testClass is RunnerLocatorMock );
		}
		
		[Test(description="ensure if Klass has user defined metadata that it returns true")]
		public function check_hasMetaData_true():void {
			klass = new Klass( RunnerLocatorMock );
			var hasBindableMetaData:Boolean = klass.hasMetaData( "Bindable" );
			Assert.assertTrue( hasBindableMetaData );
		}
		
		[Test(description="ensure if Klass does not have user defined metadata that it returns false")]
		public function check_hasMetaData_false():void {
			klass = new Klass( RunnerLocatorMock );
			var hasBindableMetaData:Boolean = klass.hasMetaData( "Event" );
			Assert.assertFalse( hasBindableMetaData );
		}
		
	}
}

/**
 * Test class used for test getting fields and methods.
 *  
 */
class LocalTestClass {
	public var aVar:String;
	public var cVar:Number;
	public var bVar:Array;
	
	public function aMethod():void {}
	public function bMethod( param1:Number, param2:String, param3:Date ):void {}
	public function cMethod():void {}
}