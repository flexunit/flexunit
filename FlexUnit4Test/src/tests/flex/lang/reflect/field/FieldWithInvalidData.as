package tests.flex.lang.reflect.field {
	import flex.lang.reflect.Field;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	public class FieldWithInvalidData {

		[Test(expects="ArgumentError")]
		public function shouldThrowErrorConstructingWithoutDeclaringClass():void {
			
			var field:Field = new Field( null, false, null, false );
		}

		[Test(expects="ArgumentError")]
		public function shouldThrowErrorConstructingFromNullXML():void {
			
			var field:Field = new Field( null, false, String, false );
		}

		[Test(expects="TypeError")]
		public function shouldThrowErrorWhenAskingForType():void {
			var fieldXML:XML = <variable/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			var clazz:Class = field.type;
		}

		[Test]
		public function shouldReturnEmptyStringForName():void {
			var fieldXML:XML = <variable/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			assertEquals( "", field.name );
		}
		
		[Test]
		public function shouldReturnNullForElementType():void {
			var fieldXML:XML = <variable type="Array"/>
			
			var field:Field = new Field( fieldXML, false, String, false );
			assertNull( field.elementType );
		}
		
		[Test]
		public function shouldReturnEmptyArrayForMetadata():void {
			var fieldXML:XML = <variable/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			assertNotNull( field.metadata );
			assertEquals( 0, field.metadata.length );
		}
		
		[Test]
		public function shouldReturnFalseForHasMetaData():void {
			var fieldXML:XML = <variable/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			
			assertFalse( field.hasMetaData( "ArrayElementType" ) );
		}
		
		[Test]
		public function shouldReturnNullForGetMetaData():void {
			var fieldXML:XML = <variable/>;
			
			var field:Field = new Field( fieldXML, false, String, false );
			
			assertNull( field.getMetaData( "Test" ) );
		}

	}
}