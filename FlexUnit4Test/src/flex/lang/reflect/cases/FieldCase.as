package flex.lang.reflect.cases
{
	import flex.lang.reflect.Field;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.Assert;
	

	public class FieldCase
	{
		private var field:Field;
		private var fieldXML:XML;
		
		[Before]
		public function setup():void {
			fieldXML = <variable/>;
			field = new Field( fieldXML, false, LocalTestClass , false );
		}
		
		[After]
		public function tearDown():void {
			fieldXML = null;
			field = null;
		}	
		
		[Test(description="Test that getObj returns the proper object")]
		public function check_get_fieldName():void {
			var xml:XML = <variable name="aVar" type="String"/>;
			var testClass:LocalTestClass = new LocalTestClass();
			field = new Field( xml, false, LocalTestClass, false ); 
			var obj:Object = field.getObj( testClass );
			Assert.assertEquals( testClass.aVar, obj  );
		}
		
		[Test(description="Test that getObj returns the correct value in the case of a static variable")]
		public function check_emptyParam_get_fieldName():void {
			var xml:XML = <variable name="aVar" type="String"/>;
			var testClass:LocalTestClassWithStatic;
			field = new Field( xml, false, LocalTestClassWithStatic, false ); 
			var obj:Object = field.getObj( null );
			Assert.assertEquals( LocalTestClassWithStatic.aVar, obj );
		}
		
		[Test(description="Test that getObj returns a null value when the object is undefined")]
		public function check_Null_get_fieldName():void {
			var xml:XML = <variable name="aVar" type="String"/>;
			var testClass:LocalTestClass;
			field = new Field( xml, false, LocalTestClass, false ); 
			var obj:Object = field.getObj( testClass );
			Assert.assertNull( null );
		}
		
		[Test(description="ensure when element type is an ArrayElement that elementType is found")]
		public function check_get_element_type():void {
			var xml:XML = 	<variable name="aVar" type="Array">
								<metadata name="ArrayElementType">
      								<arg key="" value="String"/>
    							</metadata>
    						</variable>;
			field = new Field( xml, false, LocalTestClass, false );
			var elementType:Class = field.elementType;
			
			var testClass:* = new elementType();
			Assert.assertTrue( testClass is String );
		}
		
		//TODO : currently there is no error thrown by getElement.  The error is caught and dies.
		[Test(description="ensure when element type is an ArrayElement that error gets thrown if the ArrayElementType cannot be found")]
		public function check_get_element_type_when_cannot_specify_arrayElementType():void {
			var xml:XML = 	<variable name="aVar" type="Array">
								<metadata name="ArrayElementType">
      								<arg key="" value="Hooda"/>
    							</metadata>
    						</variable>;
			field = new Field( xml, false, LocalTestClass, false );

			var elementType:Class = field.elementType;
		}
		
		[Test(description="ensure correct value is returned when field has metadata")]
		public function check_field_hasMetadata_true():void {
			var xml:XML = 	<variable name="aVar" type="Array">
								<metadata name="ArrayElementType">
      								<arg key="" value="Hooda"/>
    							</metadata>
    						</variable>;
			field = new Field( xml, false, LocalTestClass, false );
			Assert.assertTrue( field.hasMetaData("ArrayElementType") );
		}
		
		[Test(description="ensure correct value is returned when field does not have metadata")]
		public function check_field_hasMetadata_false():void {
			var xml:XML = 	<variable name="aVar" type="Array" />;
			field = new Field( xml, false, LocalTestClass, false );
			Assert.assertFalse( field.hasMetaData("ArrayElementType") );
		}
		
		[Test(description="ensure metadata is retrieved properly")]
		public function check_retrieve_metadata():void {
			var xml:XML = 	<variable name="aVar" type="Array">
								<metadata name="ArrayElementType">
      								<arg key="Boogie" value="Board"/>
    							</metadata>
    						</variable>;
			field = new Field( xml, false, LocalTestClass, false );
			var metadata:MetaDataAnnotation = field.getMetaData( "ArrayElementType" );//, "Boogie" );
			var metadataArg:MetaDataArgument = metadata.getArgument("Boogie");
			Assert.assertEquals( "Board", metadataArg.value );
		}
		
		[Test(description="ensure field type is retrieved properly")]
		public function check_retrieve_class_type():void {
			var xml:XML = 	<variable name="aVar" type="Array" />
			field = new Field( xml, false, LocalTestClass, false );
			var c:Class = field.type;
			var testClass:* = new c();
			Assert.assertTrue( testClass is Array );
		}
		
		[Test(description="ensure field type is retrieved properly when type has already been set")]
		public function check_retrieve_class_type_after_type_has_been_set():void {
			var xml:XML = 	<variable name="aVar" type="Array" />
			field = new Field( xml, false, LocalTestClass, false );
			var fieldType:Class = field.type;
			var testClass:* = new fieldType();
			Assert.assertTrue( testClass is Array );
			// now retrieve the class type again
			fieldType = field.type;
			testClass = new fieldType();
			Assert.assertTrue( testClass is Array );
		}
		
		/**
		 * Constructor 
		 */
		public function FieldCase() {
		}
		
	}
}
/**
 * Test class used for test getting fields and methods.
 *  
 */
internal class LocalTestClass {
	public var aVar:String = "Boo";
	public var cVar:Number;
	public var bVar:Array;
	
	public function aMethod():void {}
	public function bMethod( param1:Number, param2:String, param3:Date ):void {}
	public function cMethod():void {}
}

/**
 * Test class used for test getting fields and methods.
 *  
 */
internal class LocalTestClassWithStatic {
	public static var aVar:String = "Boo";
	public var cVar:Number;
	public var bVar:Array;
	
	public function aMethod():void {}
	public function bMethod( param1:Number, param2:String, param3:Date ):void {}
	public function cMethod():void {}
}