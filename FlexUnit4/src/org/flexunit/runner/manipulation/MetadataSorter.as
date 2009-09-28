/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.flexunit.runner.manipulation {
	import flex.lang.reflect.utils.MetadataTools;
	
	import org.flexunit.runner.IDescription;
	
	public class MetadataSorter {
		/**
		 * NULL is a <code>Sorter</code> that leaves elements in an undefined order
		 */
		public static var NULL:Sorter = new Sorter(none);
		public static var META:Sorter = new Sorter(defaultSortFunction);
		
		private static function none( o1:IDescription, o2:IDescription ):int {
			return 0;
		}
		
		private static function getOrderValueFrom( object:IDescription ):Number {
			var order:Number = 0;		
			
			var metadataNodes:XMLList = object.getAllMetadata();
			var metadata:XML;
			
			if ( metadataNodes.length() == 0 ) {
				trace("Stop");				
			}
			
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
		
		public static function defaultSortFunction( o1:IDescription, o2:IDescription ):int {
			var a:Number;
			var b:Number; 
			
			var o1Meta:XMLList = o1.getAllMetadata();
			var o2Meta:XMLList = o2.getAllMetadata();
			
			if ( o1Meta ) { 
				a = getOrderValueFrom( o1 );
			} else {
				a = 0;
			}

			if ( o2Meta ) {
				b = getOrderValueFrom( o2 );
			} else {
				b = 0;
			}
			
			if (a < b)
				return -1;
			if (a > b)
				return 1;
			
			return 0;
		}	
	}
}