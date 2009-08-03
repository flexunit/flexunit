package org.flexunit.runner.manipulation {
	import flex.lang.reflect.Field;
	import flex.lang.reflect.utils.MetadataTools;

	public class FieldSorter {
		private var _fields:Array;
		
		[ArrayElementType("flex.lang.reflect.Field")]
		public function get fields():Array {
			return _fields;
		}

		private static function getOrderValueFrom( object:Field ):Number {
			var order:Number = 0;		
			
			var metadataNodes:XMLList = object.metadata;
			var metadata:XML;
			
			for ( var i:int=0; i<metadataNodes.length(); i++ ) {
				metadata = metadataNodes[ i ];
				
				var orderString:String = MetadataTools.getArgValueFromSingleMetaDataNode( metadata, "order" );
				if ( orderString ) {
					order = Number( orderString );
					break;
				}
			} 
			
			return order;
		}
		
		public static function defaultSortFunction( o1:Field, o2:Field ):int {
			var a:Number;
			var b:Number; 
			
			if ( !o1.metadata && !o2.metadata ) {
				return 0;
			}
			
			if ( !o1.metadata ) {
				return 1;
			}
			
			if ( !o2.metadata ) {
				return -1;
			}
			
			a = getOrderValueFrom( o1 );
			b = getOrderValueFrom( o2 );
			
			if (a < b)
				return -1;
			if (a > b)
				return 1;
			
			return 0;
		}	

		public function sort( comparisonFunction:Function=null ):void {
			var compareFn:Function = defaultSortFunction;
			
			if ( comparisonFunction != null ) {
				compareFn = comparisonFunction;
			}
			
			_fields.sort( compareFn );
		}
		
		public function FieldSorter( fields:Array ) {
			this._fields = fields.slice(0);;
 		}
	}
}