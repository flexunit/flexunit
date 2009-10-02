package flex.lang.reflect.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;

	/**
	 * KlassMock - Implementation mock 
	 * 
	 */
	public class KlassMock extends Klass
	{
		public var mock:Mock;
		
		/**
		 * Constructor
		 * 
		 */
		public function KlassMock( clazz:Class ) {
			mock = new Mock( this );
			
			super(clazz);
		}
		
		override public function get asClass():Class {
			return mock.asClass;
		}

		override public function get name():String {
			return mock.name;			
		}

		override public function get metadata():XMLList {
			return mock.metaData;
		}

		override public function get constructor():Constructor {
			return mock.constructor;
		}

		override public function getField( name:String ):Field {
			return mock.getField;
		}
		
		override public function get fields():Array {
			return mock.fields;
		}
		
		override public function getMethod( name:String ):Method {
			return mock.getMethod;
		}
		
		override public function get methods():Array {
			return mock.methods;
		}
		
		override public function get interfaces():Array {
			return mock.interfaces;
		}
		
		override public function get packageName():String {
			return mock.packageName;
		}

		override public function get superClass():Class {
			return mock.superClass();
		}
		
		override public function get classDef():Class {
			return mock.classDef;
		}

		override public function descendsFrom( clazz:Class ):Boolean {
			return mock.descendsFrom( clazz );
		}

		override public function hasMetaData( name:String ):Boolean {
			return mock.hasMetaData( name );
		}
		
		override public function getMetaData( name:String, key:String="" ):String {
			return mock.getMetaData( name, key );
		} 

	}
}