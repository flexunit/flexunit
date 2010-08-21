/**
 * Copyright (c) 2010 Digital Primates
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
package flex.lang.reflect.builders {
	import flex.lang.reflect.Field;

	public class FieldBuilder {
		/**
		 * @private
		 */
		private var classXML:XML;
		/**
		 * @private
		 */
		private var clazz:Class;

		/**
		 * Builds all field objects from the provided XML 
		 * @return an Array of fields
		 * 
		 */		
		public function buildAllFields():Array {
			var fields:Array = new Array();
			var variableList:XMLList = classXML.factory.variable;			
			
			for ( var i:int=0; i<variableList.length(); i++ ) {
				fields.push( new Field( variableList[ i ], false, clazz, false ) );
			}
			
			var staticVariableList:XMLList = classXML.variable;			
			
			for ( var j:int=0; j<staticVariableList.length(); j++ ) {
				fields.push( new Field( staticVariableList[ j ], true, clazz, false ) );
			}
			
			var propertyList:XMLList = classXML.factory.accessor;			
			
			for ( var k:int=0; k<propertyList.length(); k++ ) {
				fields.push( new Field( propertyList[ k ], true, clazz, true ) );
			}
			
			var staticPropertyList:XMLList = classXML.accessor;			
			
			for ( var l:int=0; l<staticPropertyList.length(); l++ ) {
				//we need to exclude the prototype accessor
				if ( staticPropertyList[ l ].@name != 'prototype' ) {
					fields.push( new Field( staticPropertyList[ l ], true, clazz, true ) );
				}
			}
			
			return fields;
		}

		/**
		 * 
		 * @param classXML
		 * @param clazz
		 * 
		 */		
		public function FieldBuilder( classXML:XML, clazz:Class ) {
			this.classXML = classXML;
			this.clazz = clazz; 			
		}
	}
}