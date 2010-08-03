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
	
	import org.flexunit.constants.AnnotationConstants;
	
	/**
	 * An object representing a property or variable of a class or instance. You can gain access to the
	 * value of the field as well as inspect its metadata. 
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
		 * Returns whether the <code>Field</code> is a property. Fields are either 
		 * properties (getter/setters) or variables.
		 * 
		 */
		public function get isProperty():Boolean {
			return _isProperty;
		}
		
		/**
		 * Returns the Class that defines this field.
		 *  
		 * @return a Class. 
		 * 
		 */		
		public function get definedBy():Class {
			return _definedBy;
		}
		
		/**
		 * Retrieves the actual field represented by this Field object within the instance or class 
		 * where it exists. 
		 * 
		 * If an object is passed, then this field is returned from that object instance. 
		 * 
		 * If a null argument is passed and the field is static, then the field is treated as static and
		 * returned from the class. 
		 * 
		 * If a null argument is passed and the field is NOT static, then an error is thrown.
		 * 
		 * @param obj An instance where the field exists
		 * @return The object represented by this Field within the specified object or class. 
		 */
		public function getObj( obj:Object=null ):Object {
			if ( isStatic && ( obj == null ) ) {
				return _definedBy[ name ];
			} 

			if ( !isStatic && ( obj != null ) ) {
				return obj[ name ];
			}

			throw new ArgumentError( "Attempting to access inaccessible field on object or class." );
		}
		
		/**
		 * Retrieves the element type of the <code>Field</code>
		 */
		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			var metaDataAnnotation:MetaDataAnnotation = getMetaData( AnnotationConstants.ARRAY_ELEMENT_TYPE );
			if ( ( type == Array ) && metaDataAnnotation && metaDataAnnotation.defaultArgument ) {
				//we are an array at least, so let's go further;
				var meta:String = metaDataAnnotation.defaultArgument.key;
				
				try {
					_elementType = Klass.getClassFromName( meta );
				} catch ( error:Error ) {
					_elementType = null;
					//trace("Cannot find specified ArrayElementType("+meta+") in SWF");
				}
					
			}
			
			return _elementType;
		}

		/**
		 * Retrieves an array of MetaDataAnnotation instances associated with the <code>Field</code>
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
		 * Checks for the existance of a metadata annotation using the annotation's name
		 * 
		 * @param name the name of the annotation
		 * @return Returns true if the annotation exists, false if it does not.
		 * 
		 * @see #getMetaData()
		 */
		public function hasMetaData( name:String ):Boolean {
			return ( getMetaData( name ) != null );
		}
		
		/**
		 * Returns the MetaDataAnnotation associated with a given annotation using the annotation's name
		 *  
		 * @param name the name of the annotation
		 * @return the MetaDataAnnotation instance for the annotation name, or null if it was not found.
		 * 
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
				var strType:String = _fieldXML.@type;
				
				if ( strType.length > 0 ) {
					_type = Klass.getClassFromName( strType );
				} else {
					throw new TypeError("Unknown Type");
				}
			}
			return _type;
		}

		/**
		 * Compares two Field instances for equality
		 * 
		 * @return Returns boolean indicating equality
		 * 
		 */
		public function equals( item:Field ):Boolean {
			if ( !item ) {
				return false;
			}
			
			var equiv:Boolean = ( ( this.name == item.name ) && 
				                  ( this.type == item.type ) &&
								  ( this.isStatic == item.isStatic ) &&
								  ( this.isProperty == item.isProperty ) &&
								  ( this.definedBy == item.definedBy ) );

			var localMetaData:Array = this.metadata;
			var remoteMetaData:Array = item.metadata;
			
			if ( equiv ) {
				var localLen:int = localMetaData?localMetaData.length:0;
				var remoteLen:int = remoteMetaData?remoteMetaData.length:0;
				
				if ( localLen != remoteLen ) {
					return false;
				}
				
				if ( localLen > 0) {
					for ( var i:int=0; i<localLen; i++ ) {
						var localMeta:MetaDataAnnotation = localMetaData[ i ];
						var remoteMeta:MetaDataAnnotation = remoteMetaData[ i ];
						
						equiv = localMeta.equals( remoteMeta );
						if (!equiv) {
							break;
						}
					}
				}
			}
			
			return equiv;
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
			if ( !fieldXML ) {
				throw new ArgumentError("Valid XML must be provided to Field Constructor");
			}

			if ( !definedBy ) {
				throw new ArgumentError("Invalid owning class passed to Field Constructor");
			}
			
			_fieldXML = fieldXML;
			_name = fieldXML.@name;		
			_isStatic = isStatic;	
			_definedBy = definedBy;
			_isProperty = isProperty;
		}

	}
}