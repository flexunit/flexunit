/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runners.model.TestClass;
	
	/**
	 * A <code>MetadataSorter</code> compares two values to determine which value is greater.
	 * 
	 */
	public class OrderArgumentPlusInheritanceSorter implements ISorter  {

		private var existingSorter:ISorter; 
		private var superFirst:Boolean = true;
		private var testClass:TestClass;
		private var superIndexMap:Dictionary;
		private var klassInfo:Klass;

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
		
		private function returnOnlyName( description:IDescription ):String {
			var index:int = description.displayName.lastIndexOf( "." );
			return description.displayName.substr( index + 1 );
		}

		private function getInheritedOrder( description:IDescription ):int {
			var method:Method = klassInfo.getMethod( returnOnlyName( description ) );
			var index:int = superIndexMap[ method.declaringClass ];

			return index;
		}
		
		/**
		 * Compares its two arguments for order. Returns a negative integer, zero, or a positive integer 
		 * as the first argument is less than, equal to, or greater than the second. If the two objects are
		 * of equal order number, then we are simply going to return them in alphabetical order..
		 * 
		 * This method also takes into account the order of the found objects in terms of their super and sub classes
		 * 
		 * @param o1 <code>IDescription</code> the first object to be compared.
		 * @param o2 <code>IDescription</code> the second object to be compared.
		 * */
		public function compare( o1:IDescription, o2:IDescription ):int {
			var o1InheritedOrder:int = getInheritedOrder( o1 );
			var o2InheritedOrder:int = getInheritedOrder( o2 );

			//Determine the ordering of the two respected names
			if (o1InheritedOrder < o2InheritedOrder)
				return 1;
			if (o1InheritedOrder > o2InheritedOrder)
				return -1;

			//If they are equal inheritance, then check the order
			var orderSortDecision:int = existingSorter.compare( o1, o2 );

			return orderSortDecision;
		}
		
		private function buildMap( testClass:TestClass, superFirst:Boolean ):Dictionary {
			var dict:Dictionary = new Dictionary( true );
			
			var inheritance:Array = klassInfo.classInheritance;
			var inheritanceLength:int = 0;
			var reverseLength:int = 0;
			
			inheritanceLength = inheritance.length;

			if ( !superFirst ) {
				reverseLength = inheritance.length;
			}
			
			if ( superFirst ) {
				dict[ testClass.asClass ] = 0;
			} else {
				dict[ testClass.asClass ] = inheritanceLength;
				inheritanceLength--;
			}
			for ( var i:int=0; i<inheritance.length; i++ ) {
				dict[ inheritance[ i ] ] = superFirst?(i + 1):(inheritanceLength - i );
			}
			
			return dict;
		}

		public function OrderArgumentPlusInheritanceSorter( existingSorter:ISorter, testClass:TestClass, superFirst:Boolean = true ) {
			this.existingSorter = existingSorter;
			this.superFirst = superFirst;
			this.testClass = testClass;
			this.klassInfo = testClass.klassInfo;
			
			superIndexMap = buildMap( testClass, superFirst );
		}
	}
}