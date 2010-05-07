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
package flex.lang.reflect {
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	/**
	 * Helper class designed to break down individual XML variables to ease processing in
	 * FlexUnit.  Fields consist of the fieldXML, the class defining the field, the variable type
	 * of the field, any metadata associated with the field and the name of the field.
	 */
	public class Field {
		/**
		 * @private
		 */
		private var _fieldXML:XML;
		/**
		 * @private
		 */
		private var _definedBy:Class;
		/**
		 * @private
		 */
		private var _elementType:Class;
		/**
		 * @private
		 */
		private var _metaData:Array;

		/**
		 * @private
		 */
		private var _name:String;
		/**
		 * Retrieves the name of the <code>Field</code>
		 */
		public function get name():String {
			return _name;
		}

		/**
		 * @private
		 */
		private var _isStatic:Boolean;
		/**
		 * Returns whether the <code>Field</code> is static.
		 */
		public function get isStatic():Boolean {
			return _isStatic;
		}
		
		/**
		 * @private
		 */
		private var _isProperty:Boolean;
		/**
		 * Returns whether the <code>Field</code> is a property.
		 */
		public function get isProperty():Boolean {
			return _isProperty;
		}
		
		/**
		 * Retrieves the Class associated with the object specified by the field name.
		 *   If a null paramater is passed will instead retrieve the field defined by the field name
		 * will instead return the Class defined by this field.
		 * 
		 * @param obj The object
		 * @return An object specified by name else the
		 */
		public function getObj( obj:Object ):Object {
			if ( obj == null ) {
				return _definedBy[ name ];
			} else {
				return obj[ name ];				
			}
		}
		
		/**
		 * Retrieves the element type of the <code>Field</code>
		 */
		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			var metaDataAnnotation:MetaDataAnnotation = getMetaData( "ArrayElementType" );
			if ( ( type == Array ) && metaDataAnnotation && metaDataAnnotation.defaultArgument ) {
				//we are an array at least, so let's go further;
				var meta:String = metaDataAnnotation.defaultArgument.key;
				
				//TODO : Shouldn't this throw an error rather than tracing it?
				try {
					_elementType = Klass.getClassFromName( meta );
				} catch ( error:Error ) {
					trace("Cannot find specified ArrayElementType("+meta+") in SWF");
				}
					
			}
			
			return _elementType;
		}

		/**
		 * Retrieves the metadata of the <code>Field</code>
		 */
		public function get metadata():Array {
			if ( !_metaData ) {
				_metaData = new Array();
				if ( _fieldXML && _fieldXML.metadata ) {
					var fieldMetaData:XMLList = _fieldXML.metadata;
					for ( var i:int=0; i<fieldMetaData.length(); i++ ) {
						_metaData.push( new MetaDataAnnotation( fieldMetaData[ i ] ) );
					}
				}
			}
			
			return _metaData;
		}
		
		/**
		 * Tests whether the <code>Field</code> has the metadata specified by <code>name</code>
		 * 
		 * @param name Name of the requested metadata
		 * 
		 * @return <code>true</code> if <code>Field</code> has the metadata, else <code>false</code>.
		 */
		public function hasMetaData( name:String ):Boolean {
			return ( getMetaData( name ) != null );
		}
		
		/**
		 * Retrieves the metadata associated with the <code>Field</code> having the paramater
		 * name and the paramater key.  If no key is specified, returns the value associated with
		 * the named metadata
		 * 
		 * @param name Name of the requested metadata
		 * @param key Key matching the name (<code>null</code> ok)
		 * 
		 * @return Value of the corresponding metadata
		 */
		public function getMetaData( name:String ):MetaDataAnnotation {
			var metadataAr:Array = metadata;
			
			if ( metadataAr.length ) {
				for ( var i:int=0; i<metadataAr.length; i++ ) {
					if ( ( metadataAr[ i ] as MetaDataAnnotation ).name == name ) {
						return metadataAr[ i ];
					}
				}				
			}
			
			return null;
		}

		/**
		 * @private
		 */
		private var _type:Class;
		/**
		 * Retrieves the <code>Class</code> associated with the <code>Field</code>
		 * 
		 * @return Associated <code>Class</code>.
		 */
		public function get type():Class {
			if (!_type) {
				_type = Klass.getClassFromName( _fieldXML.@type );
			}
			return _type;
		}

		/**
		 * <code>Field</code> Constructor
		 *
		 * @param fieldXML XML that describes the <code>Field</code> to be created
		 * @param isStatic <code>true</code> if <code>Field</code> is static, else <code>false</code>
		 * @param definedBy <code>Class</code> that defines the <code>Field</code> to be created
		 * @param isProperty <code>true</code> if the <code>Field</code> is a property, else <code>false</code>
		 */
		public function Field( fieldXML:XML, isStatic:Boolean, definedBy:Class, isProperty:Boolean ) {
			_fieldXML = fieldXML;
			_name = fieldXML.@name;		
			_isStatic = isStatic;	
			_definedBy = definedBy;
			_isProperty = isProperty;
		}

	}
}