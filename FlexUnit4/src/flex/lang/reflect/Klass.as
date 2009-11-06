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
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.utils.MetadataTools;

	/**
	 * Takes a <code>Class</code> defintion and converts it into an XML form
	 * this <code>Klass</code> is then used by FlexUnit to run methods associated with 
	 * the <code>Class</code>
	 */
	public class Klass {
		/**
		 * @private
		 */
		private static var metaDataCache:Dictionary = new Dictionary();

		/**
		 * @private
		 */
		private var classXML:XML;
		
		/**
		 * @private
		 */
		private var clazz:Class;
		
		/**
		 * Returns the <code>Class</code> definition defined by the Klass
		 * 
		 * @return Class defined by Klass
		 */
		public function get asClass():Class {
			return clazz;
		}
		
		/**
		 * @private
		 */
		private var _name:String;
		
		/**
		 * Returns the <code>String</code> name of the <code>Class</code>
		 * 
		 * @return name of the class
		 */
		public function get name():String {
			return _name;			
		}

		/**
		 * @private
		 */
		private var _metaData:XMLList;
		
		/**
		 * Returns an <code>XMLList</code> of metadata contained in the Class
		 * 
		 * @return metadata contained in the Class
		 */
		public function get metadata():XMLList {
			if ( !_metaData ) {
				_metaData = MetadataTools.nodeMetaData( classXML.factory[ 0 ] );	
			}

			return _metaData;
		}

		/**
		 * @internal
		 */
		internal function get constructorXML():XML {
			return classXML.factory.constructor[ 0 ];
		}

		/**
		 * @private
		 */
		private var _constructor:Constructor;
		
		/**
		 * Returns the constructor of the class as a <code>Constructor</code>
		 * 
		 * <p>
		 * @see Constructor
		 */
		public function get constructor():Constructor {
			if ( !_constructor ) {
				_constructor = new Constructor( constructorXML, this )
			}
			return _constructor;
		}

		/**
		 * Returns the <code>Field</code> matching the paramater name.
		 * 
		 * <p>
		 * @param name Name of the Field as a String
		 * 
		 * <p>
		 * @return A reference to the <code>Field</code> if found. <code>Null</code> if not found.
		 * 
		 * <p>
		 * @see Field
		 */
		public function getField( name:String ):Field {
			for ( var i:int=0; i<fields.length; i++ ) {
				if ( fields[i].name == name ) {
					return fields[i];
				}
			}

			return null;
		}

		/**
		 * @private
		 */
		private var _fields:Array;
		
		/**
		 * Returns an Array of elements where each element is of type <code>Field</code>
		 * 
		 * @return an Array of <code>Field</code> contained in the Class
		 * @see Field
		 */
		public function get fields():Array {
			if (!_fields ) {
				_fields = buildFields();
			}

			return _fields;
		}

		/**
		 * Returns the <code>Method</code> which matches the <code>String</code> paramater
		 * 
		 * <p>
		 * @param name the name of the <code>Method</code>
		 * <p>
		 * @see Method
		 */
		public function getMethod( name:String ):Method {
			for ( var i:int=0; i<methods.length; i++ ) {
				if ( methods[i].name == name ) {
					return methods[i];
				}
			}

			return null;
		}

		/**
		 * @private
		 */
		private var _methods:Array;
		
		/**
		 * Returns a list of all methods contained in the class as an
		 * Array whose elements are of type <code>Method</code>
		 * 
		 * <p>
		 * @return <code>Method</code>s in the class
		 * 
		 * <p>
		 * @see Method
		 */
		public function get methods():Array {
			if ( !_methods ) {
				_methods = buildMethods();
			}
			return _methods;
		}

		//TODO: 10/21/09 - interfaces implemented.
		/**
		 * @private
		 */
		private var _interfaces:Array;
		
		/**
		 * Returns an <code>Array</code> of all interfaces as <code>Class</code> definitions 
		 * implemented by the <code>Class</code>
		 * 
		 * <p>
		 * @return <code>Interface</code>s implemented by the Class
		 */
		public function get interfaces():Array {
			if ( !_interfaces ) {
				_interfaces = retrieveInterfaces(); 
			}
			return _interfaces
		}

		/**
		 * @private
		 */
		private var _packageName:String;
		
		/**
		 * Returns the package name that <code>Class</code> resides within.
		 */
		public function get packageName():String {
			if ( !_packageName ) {				
				_packageName = name.substr( 0, name.indexOf( "::" ) );
			}

			return _packageName;
		}

		/**
		 * Returns the super class that the <code>Class</code> extends
		 */
		public function get superClass():Class {
			//TODO : since type is an attribute of extendsClass, we need to ference it with @
			//also, since all objects extend from object, we need to be sure we are only
			//taking the type of the lowest level extend.
			return getClassFromName( classXML.factory.extendsClass[0].@type );
			//return getClassFromName( classXML.factory.extendsClass.type );
		}

		/**
		 * @private
		 */
		private var _classDef:Class;
		
		/**
		 * Returns the <code>Class</code> definition
		 */
		public function get classDef():Class {
			if ( !_classDef ) {
				_classDef = getClassFromName( name );
			}
			
			return _classDef;
		}
		
		/**
		 * Tests wether the class extends from the paramater class
		 * 
		 * <p>
		 * @param clazz the class to test against
		 * 
		 * <p>
		 * @return <code>true</code> if the class does extend from the paramater class,
		 *  <code>false</code> otherwise.
		 */
		public function descendsFrom( clazz:Class ):Boolean {
			var className:String = getQualifiedClassName( clazz );	

			return MetadataTools.classExtendsFromNode( classXML.factory[ 0 ], className );
		}

		/**
		 * @private
		 */
		private static function getDotPathFromName( name:String ):String {
			var colonReplace:RegExp = /::/g;
			name = name.replace( colonReplace, "." );
			
			return name;
		}

		/**
		 * Static method.  Returns the <code>Class</code> defined by the paramater name
		 * 
		 * <p>
		 * @param name of the class definition needed
		 * 
		 * <p>
		 * @return <code>Class</code> definition if found, <code>null</code> if not found.
		 */
		public static function getClassFromName( name:String ):Class {
			var stringName:String = getDotPathFromName( name );

			//We also need to check if it extends from object.  If so, it does not have any other
			//superclass.
			if ( stringName == "void" || stringName == "*" || stringName == "Object" ) {
			//if ( stringName == "void" || stringName == "*" ) {
				return null;
			}

			return getDefinitionByName( stringName ) as Class;
		}
		
		/**
		 * @private
		 */
		private function buildMethods():Array {
			var methods:Array = new Array();
			var methodList:XMLList = new XMLList();			
			if ( XMLList( classXML.factory ).length() > 0 ) {
				methodList = MetadataTools.getMethodsList( classXML.factory[ 0 ] );
			}
			
			for ( var i:int=0; i<methodList.length(); i++ ) {
				methods.push( new Method( methodList[ i ], false ) );
			}

			var staticMethodList:XMLList = new XMLList();		
			
			//TODO: XMLList( calssXML).length can never be 0 or less, an error would be thrown during construction if so
			//if ( XMLList( classXML ).length() > 0 ) {
				staticMethodList = MetadataTools.getMethodsList( classXML );
			//}

			for ( var j:int=0; j<staticMethodList.length(); j++ ) {
				methods.push( new Method( staticMethodList[ j ], true ) );
			}

			return methods;
		}

		/**
		 * @private
		 */
		private function buildFields():Array {
			var fields:Array = new Array();
			var fieldList:XMLList = classXML.factory.variable;			
			
			for ( var i:int=0; i<fieldList.length(); i++ ) {
				fields.push( new Field( fieldList[ i ], false, clazz, false ) );
			}

			var staticFieldList:XMLList = classXML.variable;			

			for ( var j:int=0; j<staticFieldList.length(); j++ ) {
				fields.push( new Field( staticFieldList[ j ], true, clazz, false ) );
			}
			
			var propertyFieldList:XMLList = classXML.factory.accessor;			

			for ( var k:int=0; k<propertyFieldList.length(); k++ ) {
				fields.push( new Field( propertyFieldList[ k ], true, clazz, true ) );
			}

			return fields;
		}
		
		//TODO: helper method to build the interface lists
		/**
		 * @private
		 */
		private function retrieveInterfaces():Array {
			var interfaceList:XMLList = classXML.factory.implementsInterface;
			var implement:Array = new Array();
			
			for( var i:int=0; i<interfaceList.length(); i++ ) {
				implement.push( getClassFromName( interfaceList[i].@type ) );
			}
			
			
			return implement;
		}

		/**
		 * Tests if the class defined by the name paramater has any metadata
		 * 
		 * <p>
		 * @param name of the Class
		 * 
		 * <p>
		 * @return <code>true</code> if the class has metadata, else
		 * <code>false</code>
		 */
		public function hasMetaData( name:String ):Boolean {
			return MetadataTools.nodeHasMetaData( classXML.factory[ 0 ], name );
		}
		
		/**
		 * Retrieves the value of any metadata matching the name and key.
		 * 
		 * <p>
		 * @param name of the metadata
		 * @param key of the metadata (<code>null</code> ok)
		 * 
		 * <p>
		 * @return value of metadata if found.  
		 */
		public function getMetaData( name:String, key:String="" ):String {
			return MetadataTools.getArgValueFromMetaDataNode( classXML.factory[ 0 ], name, key );
		}
		
		/**
		 * @internal
		 */
		internal function setDefintionForClass( clazz:Class ):void {
			classXML = cacheAndReturnDefintionForClass( clazz );
		}

		/**
		 * @internal
		 */
		internal static function cacheAndReturnDefintionForClass( clazz:Class ):XML {			
			metaDataCache[ clazz ] = describeType( clazz ); 
			return getXMLForClass( clazz );
		} 

		/**
		 * @internal
		 */
		internal static function getXMLForClass( clazz:Class ):XML {
			return metaDataCache[ clazz ];
		} 
		
		/**
		 * Klass Constructor
		 * 
		 * <p>
		 * @param clazz to create as an XML <code>Klass</code>
		 */ 
		public function Klass( clazz:Class ) {
			
			classXML = getXMLForClass( clazz );
			if ( !classXML ) {
				if ( clazz ) {
					classXML = cacheAndReturnDefintionForClass( clazz );
				} else {
					classXML = <type/>;
				}
			}

			this.clazz = clazz;
			
			_name = classXML.@name;
		}
	}
}