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
package flex.lang.reflect {
	import flex.lang.reflect.utils.MetadataTools;
	
	public class Field {
		private var _fieldXML:XML;
		private var _definedBy:Class;
		private var _elementType:Class;

		private var _name:String;
		public function get name():String {
			return _name;
		}

		private var _isStatic:Boolean;
		public function get isStatic():Boolean {
			return _isStatic;
		}
		
		public function getObj( obj:Object ):Object {
			if ( obj == null ) {
				return _definedBy[ name ];
			} else {
				return obj[ name ];				
			}
		}
		
		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			if ( ( type == Array ) && ( hasMetaData( "ArrayElementType" ) ) ) {
				//we are an array at least, so let's go further;
				var meta:String = getMetaData( "ArrayElementType" );
				
				try {
					_elementType = Klass.getClassFromName( meta );
				} catch ( error:Error ) {
					trace("Cannot find specified ArrayElementType("+meta+") in SWF");
				}
					
			}
			
			return _elementType;
		}

		public function hasMetaData( name:String ):Boolean {
			return MetadataTools.nodeHasMetaData( _fieldXML, name );
		}
		
		public function getMetaData( name:String, key:String="" ):String {
			return MetadataTools.getArgValueFromMetaDataNode( _fieldXML, name, key );
		}

		private var _type:Class;
		public function get type():Class {
			if (!_type) {
				_type = Klass.getClassFromName( _fieldXML.@type );
			}
			return _type;
		}

		public function Field( fieldXML:XML, isStatic:Boolean, definedBy:Class ) {
			_fieldXML = fieldXML;
			_name = fieldXML.@name;		
			_isStatic = isStatic;	
			_definedBy = definedBy;
		}

	}
}