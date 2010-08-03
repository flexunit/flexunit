package flex.lang.reflect.cache {
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	public class ClassDataCache {
		private static var classCache:Dictionary = new Dictionary();
		
		public static function describeType( clazz:Class, refresh:Boolean = false ):XML {
			if ( ( refresh ) || ( classCache[ clazz ] == null ) ) {
				classCache[ clazz ] = flash.utils.describeType( clazz );
			}
				
			return classCache[ clazz ];
		}
		
		public function ClassDataCache() {
		}
	}
}