package tests.flex.lang.reflect.builders {
	import flash.utils.describeType;
	
	import flex.lang.reflect.Method;
	import flex.lang.reflect.builders.MethodBuilder;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.constants.AnnotationConstants;
	
	import tests.flex.lang.reflect.klass.helper.Ancestor1;
	import tests.flex.lang.reflect.klass.helper.Ancestor2;
	import tests.flex.lang.reflect.klass.helper.ClassForIntrospection;
	
	public class MethodBuilderWithValidData {		

		private var describedData:XML;
		private var methodBuilder:MethodBuilder;

		[Before]
		public function setup():void {
			describedData = describeType( ClassForIntrospection );
			methodBuilder = new MethodBuilder( describedData, [Ancestor2, Ancestor1, Object] );
		}
		
		[Test]
		public function shouldFindThreeMethods():void {
			var methods:Array = methodBuilder.buildAllMethods();
			
			assertNotNull( methods );
			assertEquals( 3, methods.length );
		}

		[Test]
		public function shouldFindThreeNamedMethods():void {
			var methods:Array = methodBuilder.buildAllMethods();
			
			assertNotNull( methods );

			methods.sortOn( "name" );
			assertEquals( "baseMethod",  ( methods[ 0 ] as Method ).name );
			assertEquals( "returnFalse", ( methods[ 1 ] as Method ).name );
			assertEquals( "returnTrue",  ( methods[ 2 ] as Method ).name );
		}		

		[Test]
		public function shouldFindOneStaticMethod():void {
			var methods:Array = methodBuilder.buildAllMethods();

			assertNotNull( methods );
			methods.sortOn( "name" );

			assertFalse( ( methods[ 0 ] as Method ).isStatic );
			assertFalse( ( methods[ 1 ] as Method ).isStatic );
			assertTrue(  ( methods[ 2 ] as Method ).isStatic );
		}		
		
		[Test]
		public function shouldFindMetaDataByInheritance():void {
			var methods:Array = methodBuilder.buildAllMethods();
			
			methods.sortOn( "name" );

			var method:Method = methods[ 0 ] as Method;
			var annotation:MetaDataAnnotation = method.getMetaData( AnnotationConstants.TEST );
			
			assertNotNull( annotation );
		}		
		
		[Test]
		public function shouldFindMetaDataInClass():void {
			var methods:Array = methodBuilder.buildAllMethods();
			
			methods.sortOn( "name" );
			
			var method:Method = methods[ 0 ] as Method;
			var annotation:MetaDataAnnotation = method.getMetaData( AnnotationConstants.SUITE );
			
			assertNotNull( annotation );
		}		
	}
}