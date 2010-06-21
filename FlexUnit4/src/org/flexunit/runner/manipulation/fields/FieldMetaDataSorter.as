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

//This class is highly duplicated from OrderArgumentSorter and we should abstract common functionality
package org.flexunit.runner.manipulation.fields {
	import flex.lang.reflect.Field;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;

	import org.flexunit.constants.AnnotationArgumentConstants;

	/**
	 * A field sorter capable of sorting fields based on the order argument 
	 * @author mlabriola
	 * 
	 */
	public class FieldMetaDataSorter implements IFieldSorter {
		
		/**Controls a A to Z verssus Z to A sort **/
		private var invert:Boolean = false;
		
		/**
		 * Determines the value of the order for the argument if an order exists.
		 * 
		 * @param field <code>Field</code> the object to have its order checked.
		 * */
		protected function getOrderValueFrom( field:Field ):Number {
			var order:Number = 0;		
			
			var metadataArray:Array = field.metadata;
			var metaDataAnnotation:MetaDataAnnotation;
			
			for ( var i:int=0; i<metadataArray.length; i++ ) {
				metaDataAnnotation = metadataArray[ i ] as MetaDataAnnotation;
				
				//Determine if the node contains an 'order' key, if it does, get the order number
				var metaArg:MetaDataArgument = metaDataAnnotation.getArgument( AnnotationArgumentConstants.ORDER, true );
				if ( metaArg ) {
					order = Number( metaArg.value );
					break;
				}
			} 
			
			return order;
		}

		/**
		 * Compares field1 and field2 indicating which is first or second in order 
		 * @param field1
		 * @param field2
		 * @return 
		 * 
		 */
		public function compare( field1:Field, field2:Field ):int {
			var a:Number;
			var b:Number; 
			
			//Determine if the first object has an order
			if ( field1 ) { 
				a = getOrderValueFrom( field1 );
			} else {
				a = 0;
			}
			
			//Determine if the second object has an order
			if ( field2 ) {
				b = getOrderValueFrom( field2 );
			} else {
				b = 0;
			}
			
			//Determine the ordering of the two respected objects
			if (a < b)
				return invert?1:-1;
			if (a > b)
				return invert?-1:1;
			
			return 0;
		}
		
		/**
		 * Constructor 
		 * @param invert indicates a top down or bottom up sort
		 * 
		 */
		public function FieldMetaDataSorter( invert:Boolean = false ) {
			this.invert = invert;
		}
	}
}