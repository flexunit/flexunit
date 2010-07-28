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
	
	import tests.flex.lang.reflect.klass.helper.Ancestor1;
	import tests.flex.lang.reflect.klass.helper.Ancestor2;
	import tests.flex.lang.reflect.klass.helper.ClassForIntrospection;
	import tests.flex.lang.reflect.klass.helper.IFakeInterface;

	public class KlassWithInvalidData {
		private var klass:Klass;
		
		[Before]
		public function setupKlass():void {
			klass = new Klass( null );
		}
		
		[Test]
		public function shouldReturnNullForClassReference():void {
			assertNull( klass.asClass );
		}
		
		[Test]
		public function shouldReturnNullClassDef():void {
			assertNull( klass.classDef );
		}
		
		[Test]
		public function shouldReturnBlankName():void {
			assertEquals( "", klass.name );
		}
		
		[Test]
		public function shouldNotFindConstructor():void {
			var constructor:Constructor = klass.constructor;
			assertNotNull( constructor );
			assertNotNull( constructor.parameterTypes );
			assertEquals( 0, constructor.parameterTypes.length );
		}
		
		[Test]
		public function shouldFindZeroFields():void {
			var fields:Array = klass.fields;
			
			assertNotNull( fields );
			assertEquals( 0, fields.length );
		}
		
		[Test]
		public function shouldFindZeroMethods():void {
			var methods:Array = klass.methods;
			
			assertNotNull( methods );
			assertEquals( 0, methods.length );
		}
		
		[Test]
		public function shouldNotImplementInterface():void {
			assertFalse( klass.implementsInterface( IEventDispatcher ) );
		}		
		
		[Test]
		public function shouldNotDescendFromEventDispatcher():void {
			assertFalse( klass.descendsFrom( EventDispatcher ) );
		}		
		
		[Test]
		public function shouldFindNoSuperClass():void {
			assertNull( klass.superClass );
		}		
		
		[Test]
		public function shouldReturnBlankPackageName():void {
			assertEquals( "", klass.packageName );
		}		
		
		[Test]
		public function shouldNotGetNonExistantField():void {
			var field:Field = klass.getField( "monkeyProp" ); 
			assertNull( field );
		}		
				
		[Test]
		public function shouldNotGetNonExistantMethod():void {
			var method:Method = klass.getMethod( "monkeyMethod" ); 
			assertNull( method );
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
		public function shouldFindNoInterfaces():void {
			var interfaces:Array = klass.interfaces; 
			
			assertNotNull( interfaces );
			assertEquals( 0, interfaces.length );
		}		
		
		[Test]
		public function shouldFindNoClassInheritance():void {
			var classes:Array = klass.classInheritance; 
			
			assertNotNull( classes );
			assertEquals( 0, classes.length );
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
	}
}