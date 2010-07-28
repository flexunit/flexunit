package tests.flex.lang.reflect.klass {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.constants.AnnotationConstants;
	
	import tests.flex.lang.reflect.klass.helper.Ancestor1;
	import tests.flex.lang.reflect.klass.helper.Ancestor2;
	import tests.flex.lang.reflect.klass.helper.ClassForIntrospection;
	import tests.flex.lang.reflect.klass.helper.IFakeInterface;

	public class KlassWithValidData {
		private var klass:Klass;

		[Before]
		public function setupKlass():void {
			klass = new Klass( ClassForIntrospection );
		}
		
		[Test]
		public function shouldReturnClassReference():void {
			assertEquals( ClassForIntrospection, klass.asClass );
		}

		[Test]
		public function shouldReturnClassDef():void {
			assertEquals( ClassForIntrospection, klass.classDef );
		}

		[Test]
		public function shouldReturnName():void {
			assertEquals( "tests.flex.lang.reflect.klass.helper::ClassForIntrospection", klass.name );
		}

		[Test]
		public function shouldFindConstructorWithTwoParams():void {
			var constructor:Constructor = klass.constructor;
			assertNotNull( constructor );
			assertNotNull( constructor.parameterTypes );
			assertEquals( 2, constructor.parameterTypes.length );
			assertEquals( int, constructor.parameterTypes[ 0 ] );
		}

		[Test]
		public function shouldFindSixFields():void {
			var fields:Array = klass.fields;

			assertNotNull( fields );
			assertEquals( 6, fields.length );
		}

		[Test]
		public function shouldFindThreeMethods():void {
			var methods:Array = klass.methods;
			
			assertNotNull( methods );
			assertEquals( 3, methods.length );
		}
		
		[Test]
		public function shouldImplementInterface():void {
			assertTrue( klass.implementsInterface( IFakeInterface ) );
		}		

		[Test]
		public function shouldNotImplementInterface():void {
			assertFalse( klass.implementsInterface( IEventDispatcher ) );
		}		

		[Test]
		public function shouldDescendFromSuper():void {
			assertTrue( klass.descendsFrom( Ancestor2 ) );
			assertTrue( klass.descendsFrom( Ancestor1 ) );
		}		

		[Test]
		public function shouldNotDescendFromEventDispatcher():void {
			assertFalse( klass.descendsFrom( EventDispatcher ) );
		}		

		[Test]
		public function shouldKnowSuperClass():void {
			assertEquals( Ancestor2, klass.superClass );
		}		

		[Test]
		public function shouldReturnPackageName():void {
			assertEquals( "tests.flex.lang.reflect.klass.helper", klass.packageName );
		}		

		[Test]
		public function shouldGetInstanceField():void {
			var field:Field = klass.getField( "testPropA" ); 
			assertNotNull( field );
			assertEquals( "testPropA", field.name );
		}		

		[Test]
		public function shouldGetStaticField():void {
			var field:Field = klass.getField( "testStaticPropB" ); 
			assertNotNull( field );
			assertEquals( "testStaticPropB", field.name );
		}		

		[Test]
		public function shouldNotGetNonExistantField():void {
			var field:Field = klass.getField( "monkeyProp" ); 
			assertNull( field );
		}		
		
		[Test]
		public function shouldGetInstanceMethod():void {
			var method:Method = klass.getMethod( "returnFalse" ); 
			assertNotNull( method );
			assertEquals( "returnFalse", method.name );
		}		
		
		[Test]
		public function shouldGetStaticMethod():void {
			var method:Method = klass.getMethod( "returnTrue" ); 
			assertNotNull( method );
			assertEquals( "returnTrue", method.name );
		}		
		
		[Test]
		public function shouldNotGetNonExistantMethod():void {
			var method:Method = klass.getMethod( "monkeyMethod" ); 
			assertNull( method );
		}		

		[Test]
		public function shouldFindIgnoreMetaData():void {
			assertTrue( klass.hasMetaData( "Ignore" ) );
		}		
		
		[Test]
		public function shouldGetIgnoreMetaData():void {
			var annotation:MetaDataAnnotation = klass.getMetaData( "Ignore" ); 
			assertNotNull( annotation );
		}
		
		[Test]
		public function shouldNotFindMonkeyMetaData():void {
			assertFalse( klass.hasMetaData( "Monkey" ) );
		}		
		
		[Test]
		public function shouldNotGetApeMetaData():void {
			var annotation:MetaDataAnnotation = klass.getMetaData( "Ape" ); 
			assertNull( annotation );
		}		
		
		[Test]
		public function shouldFindASingleInterface():void {
			var interfaces:Array = klass.interfaces; 

			assertNotNull( interfaces );
			assertEquals( 1, interfaces.length );
		}		

		[Test]
		public function shouldFindThreeeClassesInInheritance():void {
			var classes:Array = klass.classInheritance; 
			
			assertNotNull( classes );
			assertEquals( 3, classes.length );
		}		

		[Test]
		public function shouldGetClassFromDotColonName():void {
			var clazz:Class = Klass.getClassFromName( "tests.flex.lang.reflect.klass.helper::ClassForIntrospection" );
			
			assertNotNull( clazz );
			assertEquals( ClassForIntrospection, clazz );
		}		

		[Test]
		public function shouldNotGetClassFromWrongDotColonName():void {
			var clazz:Class = Klass.getClassFromName( "tests.flex.lang.reflect.klass.helper::SomeIntro" );
			
			assertNull( clazz );
		}		

		[Test]
		public function shouldFindTestMetaData():void {
			var method:Method = klass.getMethod( "baseMethod" );
			var annotation:MetaDataAnnotation = method.getMetaData( AnnotationConstants.TEST );
			
			assertNotNull( annotation );
		}		

		[Test]
		public function shouldFindSuiteMetaData():void {
			var method:Method = klass.getMethod( "baseMethod" );
			var annotation:MetaDataAnnotation = method.getMetaData( AnnotationConstants.SUITE );
			
			assertNotNull( annotation );
		}		


/*		[Test]
		   I don't know that we will ever be able to put this test back in.
		   Our good friends at Adobe pollute the methods with tons of metadata
		   when in debug mode. So, this test performs differenty when debugging in
		   flash builder than runtime 
		public function shouldGetCorrectMetaDataCount():void {
			var annotations:Array = klass.metadata; 
			assertNotNull( annotations );
			assertEquals( 1, annotations.length );
		}*/
	}
}