package flex.lang.reflect.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Field;

	public class FieldMock extends Field
	{
		public var mock:Mock;
		
		/**
		 * Constructor
		 * @param fieldXML
		 * @param isStatic
		 * @param definedBy
		 * @param isProperty
		 * 
		 */
		public function FieldMock(fieldXML:XML = null, isStatic:Boolean = false, definedBy:Class = null, isProperty:Boolean = false) {
			mock = new Mock( this );
			
			//If fieldXML is null, provide xml that has a name so the constructor does not generate a RTE
			if(!fieldXML) {
				fieldXML = <field name='test'/>;
			}
			
			super(fieldXML, isStatic, definedBy, isProperty);
		}
		
		override public function get name():String {
			return mock.name;
		}
		
		override public function get isStatic():Boolean {
			return mock.isStatic;
		}
	
		override public function get isProperty():Boolean {
			return mock.isProperty;
		}

		override public function getObj( obj:Object ):Object {
			return mock.getObj( obj );
		}
		
		override public function get elementType():Class {
			return mock.elementType;
		}
		
		override public function hasMetaData( name:String ):Boolean {
			return mock.hasMetaData( name );
		}

		override public function getMetaData( name:String, key:String="" ):String {
			return mock.getMetaData( name, key );
		}

		override public function get type():Class {
			return mock.type;
		}
		
	}
}