package tests.flex.lang.reflect.field {
	import flash.utils.describeType;
	
	import flex.lang.reflect.Field;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	
	public class FieldAsAVariable {

		[Test]
		public function shouldReturnFalseWhenVariable():void {
			var fieldXML:XML = <variable name="testVariable" type="Array"/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			assertFalse( field.isProperty );
		}

		[Test]
		public function shouldReturnValueFromInstance():void {
			var testInstance:LocalTestClass = new LocalTestClass();
			var fieldXML:XML = <variable name="instanceVar" type="String"/>;
			
			var field:Field = new Field( fieldXML, false, LocalTestClass, false );
			assertEquals( "instanceVarValue", field.getObj( testInstance ) );
		}

		[Test]
		public function shouldReturnValueFromClass():void {
			var fieldXML:XML = <variable name="staticVar" type="String"/>;
			
			var field:Field = new Field( fieldXML, true, LocalTestClass, false );
			assertEquals( "staticVarValue", field.getObj() );
		}
		
		[Test(expects="ArgumentError")]
		public function shouldThrowErrorGettingInstanceValueFromClass():void {
			var fieldXML:XML = <variable name="instanceVar" type="String"/>;
			
			var field:Field = new Field( fieldXML, false, LocalTestClass, false );
			var value:* = field.getObj();
		}

		[Test(expects="ArgumentError")]
		public function shouldThrowErrorGettingStaticValueFromInstance():void {
			var testInstance:LocalTestClass = new LocalTestClass();
			var fieldXML:XML = <variable name="staticVar" type="String"/>;
			
			var field:Field = new Field( fieldXML, true, LocalTestClass, false );
			var value:* = field.getObj( testInstance );
		}
	}
}

class LocalTestClass {
	public static var staticVar:String = "staticVarValue";
	public var instanceVar:String = "instanceVarValue";
}
