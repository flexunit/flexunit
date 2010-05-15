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
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.runner.IDescription;
	
	/**
	 * A <code>MetadataSorter</code> compares two values to determine which value is greater.
	 * 
	 */
	public class OrderArgumentSorter implements ISorter  {
		/**
		 * NULL is a <code>Sorter</code> that leaves elements in an undefined order
		 */
		//public static var NULL:Sorter = new Sorter(none);
		
		/**
		 * ORDER_ARG_SORTER is an <code>ISorter</code> that sorts elements by their order argument
		 */
		public static var ORDER_ARG_SORTER:ISorter = new OrderArgumentSorter();
		
		/**
		 * Does not compare its two arguments for order. Returns a zero regardless of the arguments being passed.
		 * 
		 * @param o1 <code>IDescription</code> the first object to be compared.
		 * @param o2 <code>IDescription</code> the second object to be compared.
		 * */
		private static function none( o1:IDescription, o2:IDescription ):int {
			return 0;
		}

		/**
		 * Sorts the test in <code>runner</code> using <code>compare function</code>.
		 * 
		 * @param object
		 */
		public function apply(object:Object):void {
			if (object is ISortable) {
				var sortable:ISortable = (object as ISortable);
				sortable.sort(this);
			}
		}
		
		/**
		 * Determines the value of the order for the argument if an order exists.
		 * 
		 * @param o1 <code>IDescription</code> the object to have its order checked.
		 * */
		protected function getOrderValueFrom( object:IDescription ):Number {
			var order:Number = 0;		
			
			var metadataArray:Array = object.getAllMetadata();
			var metaDataAnnotation:MetaDataAnnotation;
			
/*			if ( metadataArray.length == 0 ) {
				trace("Stop");				
			}*/
			
			for ( var i:int=0; i<metadataArray.length; i++ ) {
				metaDataAnnotation = metadataArray[ i ] as MetaDataAnnotation;
				
				//Determine if the node contains an 'order' key, if it does, get the order number
				var metaArg:MetaDataArgument = metaDataAnnotation.getArgument( "order", true );
				if ( metaArg ) {
					order = Number( metaArg.value );
					break;
				}
			} 
			
			return order;
		}

		/**
		 * Compares its two arguments for order. Returns a negative integer, zero, or a positive integer 
		 * as the first argument is less than, equal to, or greater than the second. If the two objects are
		 * of equal order number, then we are simply going to return them in alphabetical order..
		 * 
		 * @param o1 <code>IDescription</code> the first object to be compared.
		 * @param o2 <code>IDescription</code> the second object to be compared.
		 * */
		public function compare(o1:IDescription, o2:IDescription):int {
			var a:Number;
			var b:Number; 
			
			var o1Meta:Array = o1.getAllMetadata();
			var o2Meta:Array = o2.getAllMetadata();
			
			//Determine if the first object has an order
			if ( o1Meta ) { 
				a = getOrderValueFrom( o1 );
			} else {
				a = 0;
			}
			
			//Determine if the second object has an order
			if ( o2Meta ) {
				b = getOrderValueFrom( o2 );
			} else {
				b = 0;
			}
			
			//Determine the ordering of the two respected objects
			if (a < b)
				return -1;
			if (a > b)
				return 1;
			
			return 0;
		}	
	}
}