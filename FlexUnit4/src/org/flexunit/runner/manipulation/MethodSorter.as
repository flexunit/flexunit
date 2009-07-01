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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.runner.manipulation {
	import flex.lang.reflect.Method;
	import flex.lang.reflect.utils.MetadataTools;
	
	public class MethodSorter {
		private function getOrderValueFromMethod( method:Method ):Number {
			var order:Number = 0;
			
			var metaDataList:XMLList = method.metadata;
			var metaData:XML;
			
			for ( var i:int=0; i<metaDataList.length(); i++ ) {
				metaData = metaDataList[ i ];

				var orderString:String = MetadataTools.getArgValueFromMetaDataNode( method.methodXML, metaData.@name, "order" );
				if ( orderString ) {
					order = Number( orderString );
					break;
				}
			} 
	
			return order;
		}
	
		private function orderMethodSortFunction( aMethod:Method, bMethod:Method ):int {
			var field:String;
			var a:Number;
			var b:Number; 

			if ( !aMethod.metadata && !bMethod.metadata ) {
				return 0;
			}
			
			if ( !aMethod.metadata ) {
				return -1;
			}
			
			if ( !bMethod.metadata ) {
				return 1;
			}
			
			a = getOrderValueFromMethod( aMethod );
			b = getOrderValueFromMethod( bMethod );

			if (a < b)
				return -1;
			if (a > b)
				return 1;

			return 0;
		}
		
	    public function createCursor():ISimpleCursor {
        	return new MethodSorterCursor( collection );
	    }

	    public function get length():int {
	    	return collection.length;
	    }

		public function sort():void {
			collection.sort( orderMethodSortFunction );
		}

		private var collection:Array;
		public function MethodSorter( methodList:Array ) {
			
			collection = methodList.slice();
		}
	}
}
	import org.flexunit.runner.manipulation.ISimpleCursor;
	

class MethodSorterCursor implements ISimpleCursor {
	private static const afterLast:String = "afterLast";
	private static const beforeFirst:String = "beforeFirst";
	private var currentIndex:int = 0;
	private var collection:Array;
	
	public function MethodSorterCursor( collection:Array ) {
		this.collection = collection;
	}	
	
	public function moveNext():Boolean {
        if (afterLast) {
            return false;
        }
        
		currentIndex++;
		
		return !afterLast;
	}

	public function movePrevious():Boolean {
        if (beforeFirst) {
            return false;
        }
		
		currentIndex--;
		
        return !beforeFirst;
	}

	public function get current():Object {
		if ( beforeFirst || afterLast ) {
			return null;
		}	
		
		return collection[ currentIndex ];
	}
	
	public function get beforeFirst():Boolean {
		return ( currentIndex < 0 || collection.length == 0 ); 
	}

	public function get afterLast():Boolean {
		return ( currentIndex >= collection.length || collection.length == 0 ); 
	}
}