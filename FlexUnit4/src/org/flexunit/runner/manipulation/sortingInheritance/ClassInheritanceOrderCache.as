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
package org.flexunit.runner.manipulation.sortingInheritance {
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runners.model.TestClass;
	import org.flexunit.utils.DescriptionUtil;
	
	/**
	 * ISortingInheritanceCache implementation that will allow querying of the inheritance order of a given method
	 * relative to its definition super and subclasses
	 *  
	 * @author mlabriola
	 * 
	 */	
	public class ClassInheritanceOrderCache implements ISortingInheritanceCache {
		/**
		 * @private 
		 */		
		private var superFirst:Boolean = true;
		/**
		 * @private 
		 */		
		private var testClass:TestClass;
		/**
		 * @private 
		 */		
		private var superIndexMap:Dictionary;
		/**
		 * @private 
		 */		
		private var klassInfo:Klass;

		/**
		 * @private 
		 */		
		private var maxInheritance:int;
		
		/**
		 * @private
		 * 
		 * This is ugly and needs to be refactored. I think we need to modify description
		 * to accomplish what I want, but I need to fix this for the moment 
		 */		
		private function returnOnlyName( description:IDescription ):String {
			return DescriptionUtil.getMethodNameFromDescription( description );
		}

		/**
		 * Returns the order of this method description relative to others in the super/subclasses 
		 * @param description
		 * @param superFirst
		 * @return 
		 * 
		 */
		public function getInheritedOrder( description:IDescription, superFirst:Boolean = true ):int {
			var method:Method = klassInfo.getMethod( returnOnlyName( description ) );
			var index:int = superIndexMap[ method.declaringClass ];
			
			if ( !superFirst ) {
				index = maxInheritance - index;
			}
			
			return index;
		}

		/**
		 * @private 
		 */		
		private function buildMap( testClass:TestClass ):Dictionary {
			var dict:Dictionary = new Dictionary( true );
			
			var inheritance:Array = klassInfo.classInheritance;
			
			maxInheritance = inheritance.length;
			
			dict[ testClass.asClass ] = 0;

			for ( var i:int=0; i<inheritance.length; i++ ) {
				dict[ inheritance[ i ] ] = i + 1;
			}
			
			return dict;
		}
		
		/**
		 * Builds a map of the class inheritance for a given testclass
		 *  
		 * @param testClass
		 * 
		 */		
		public function ClassInheritanceOrderCache( testClass:TestClass ) {
			this.testClass = testClass;
			this.klassInfo = testClass.klassInfo;
			
			superIndexMap = buildMap( testClass );
		}
	}
}