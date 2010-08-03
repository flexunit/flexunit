package tests.flex.lang.reflect.field {
	import flex.lang.reflect.Field;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;

	public class FieldAsAProperty {

		[Test]
		public function shouldReturnTrueWhenProperty():void {
			var fieldXML:XML = <accessor name="cProp" access="readwrite" type="Array" declaredBy=""/>;
			
			var field:Field = new Field( fieldXML, false, String, true );
			assertTrue( field.isProperty );
		}

		[Test]
		public function shouldReturnValueFromInstance():void {
			var testInstance:LocalTestClass = new LocalTestClass();
			var fieldXML:XML = <accessor name="rwInstanceProperty" access="readwrite" type="String" declaredBy=""/>;
			
			var field:Field = new Field( fieldXML, false, LocalTestClass, true );
			assertEquals( "rwInstancePropertyValue", field.getObj( testInstance ) );
		}

		[Test]
		public function shouldReturnValueFromClass():void {
			var fieldXML:XML = <accessor name="rwStaticProperty" access="readwrite" type="String" declaredBy=""/>;
			
			var field:Field = new Field( fieldXML, true, LocalTestClass, true );
			assertEquals( "rwStaticPropertyValue", field.getObj() );
		}

	}
}

class LocalTestClass {
	private static var _rwStaticProperty:String = "rwStaticPropertyValue";
	public static function get rwStaticProperty():String {
		return _rwStaticProperty;
	}
	
	public static function set rwStaticProperty( value:String ):void {
		_rwStaticProperty = value;
	}
	
	private var _rwInstanceProperty:String = "rwInstancePropertyValue";
	public function get rwInstanceProperty():String {
		return _rwInstanceProperty;
	}
	
	public function set rwInstanceProperty(value:String):void {
		_rwInstanceProperty = value;
	}
}
