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
	
	import flex.lang.reflect.builders.FieldBuilder;
	import flex.lang.reflect.builders.MetaDataAnnotationBuilder;
	import flex.lang.reflect.builders.MethodBuilder;
	import flex.lang.reflect.cache.ClassDataCache;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
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
		 * Indicates if this class is actually interface. In ActionScript, you can't easily tell the difference as both are of Class type.
		 * 
		 * @return Boolean indicating if the described class is an interface
		 */
		public function get isInterface():Boolean {
			var isInt:Boolean = true;
			
			if ( classXML && classXML.factory ) {
				var obj:XMLList = classXML.factory.extendsClass.(@type=="Object");
				if ( obj && obj.length() > 0 ) {
					isInt = false;
				}
			}

			return isInt;
		}

		/**
		 * @private
		 */
		private var _name:String;
		
		/**
		 * Returns the name of the <code>Class</code>
		 * 
		 * @return name of the class
		 */
		public function get name():String {
			return _name;			
		}

		/**
		 * @private
		 */
		private var _metaData:Array;
		
		/**
		 * Returns an Array of MetaDataAnnotation instances decorating the Class
		 * 
		 * @return an array of MetaDataAnnotation instances
		 */
		public function get metadata():Array {
			if ( !_metaData ) {
				var annotationBuilder:MetaDataAnnotationBuilder = new MetaDataAnnotationBuilder( classXML );
				_metaData = annotationBuilder.buildAllAnnotations();
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
		 * Returns a <code>Constructor</code> instance that represents the constructor for this class.
		 * 
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
		 * @param name Name of the Field as a String
		 * 
		 * @return A reference to the <code>Field</code> if found. <code>Null</code> if not found.
		 * 
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
		 * Returns an Array of <code>Field</code> instances representing the individual static 
		 * and instance properties and variables of the class. 
		 * 
		 * @return an Array of <code>Field</code> instances
		 * @see Field
		 */
		public function get fields():Array {
			if (!_fields ) {
				var fieldBuilder:FieldBuilder = new FieldBuilder( classXML, clazz );
				_fields = fieldBuilder.buildAllFields();
			}

			return _fields;
		}

		/**
		 * Returns the <code>Method</code> instance with the provided name.
		 * 
		 * @param name the name of the <code>Method</code>
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
		 * Returns an Array of <code>Method</code> instances representing the static and instance
		 * methods of this class.
		 * 
		 * @return an Array of <code>Method</code> instances
		 * 
		 * @see Method
		 */
		public function get methods():Array {
			if ( !_methods ) {
				var methodBuilder:MethodBuilder = new MethodBuilder( classXML, classInheritance );
				_methods = methodBuilder.buildAllMethods();
			}
			return _methods;
		}

		/**
		 * @private
		 */
		private var _interfaces:Array;
		
		/**
		 * Returns an <code>Array</code> of Class objects representing each interfaces 
		 * implemented by the <code>Class</code>
		 * 
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
		 * Returns the package name that of the <code>Class</code>.
		 */
		public function get packageName():String {
			if ( !_packageName ) {				
				_packageName = name.substr( 0, name.indexOf( "::" ) );
			}

			return _packageName;
		}

		private function buildInheritance():Array {
			var className:String;
			var superArray:Array = new Array();

			//TODO : since type is an attribute of extendsClass, we need to reference it with @
			//also, since all objects extend from object, we need to be sure we are only
			//taking the type of the lowest level extend.

			if ( classXML.factory && classXML.factory.extendsClass ) {
				for ( var i:int=0; i<classXML.factory.extendsClass.length(); i++ ) {
					className = classXML.factory.extendsClass[ i ].@type
						
					//Workaround for issue where getClassFromName cannot find Object
					if ( className == "Object" ) {
						superArray.push( Object );
					} else {
						superArray.push( getClassFromName( className ) );
					}
				}
			}			
			
			return superArray;
		}
		
		/**
		 * @private
		 */
		private var _inheritance:Array;

		/**
		 * Returns an array of classes representing each super class in the chain between the 
		 * current class and <code>Object</code>.
		 *  
		 * @return an Array of classes  
		 * 
		 */
		public function get classInheritance():Array {

			if ( !_inheritance ) {
				_inheritance = buildInheritance();
			}
			
			return _inheritance;
		}

		/**
		 * Returns the super class.
		 */
		public function get superClass():Class {
			var inheritance:Array = classInheritance;

			if ( inheritance.length > 0 ) {
				return inheritance[ 0 ];	
			} else {
				return null;
			}
		}

		/**
		 * Returns the <code>Class</code> definition
		 */
		public function get classDef():Class {
			return asClass;
		}
		
		/**
		 * Tests whether the class extends from the specified class
		 * 
		 * @param clazz the class to test against
		 * 
		 * @return <code>true</code> if the class extends from the specified class
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
		 * Static method.  Returns the <code>Class</code> defined by the provided name
		 * 
		 * @param name of the class definition needed in package.subpackage::Class format.
		 * 
		 * @return <code>Class</code> definition if found, <code>null</code> if not found.
		 */
		public static function getClassFromName( name:String ):Class {
			var stringName:String = getDotPathFromName( name );
			var resolvedClass:Class;

			//We also need to check if it extends from object.  If so, it does not have any other
			//superclass. //|| stringName == "Object"
			if ( stringName == "void" || stringName == "*" ) {
				return null;
			}

			try {
				resolvedClass = getDefinitionByName( stringName ) as Class; 	
			}
			catch (e:Error) {
				resolvedClass = null;
			}
			
			return resolvedClass;
		}
		
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
		 * Tests whether the class implements a provided interface
		 *  
		 * @param interfaceRef The interface to test against
		 * 
		 * @return true if the class implements the interface 
		 * 
		 */
		public function implementsInterface( interfaceRef:Class ):Boolean {
			var interfaces:Array = interfaces;
			var found:Boolean = false;
			
			for ( var i:int=0; i<interfaces.length; i++ ) {
				if ( interfaces[ i ] == interfaceRef ) {
					found = true;
					break;
				}
			}
			
			return found;
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
			var len:int = metadata.length;
			for ( var i:int=0; i<len; i++ ) {
				if ( ( metadata[ i ] as MetaDataAnnotation ).name == name ) {
					return metadata[ i ];
				} 
			}
			
			return null;
		}
		
		/**
		 * @internal
		 */
		internal function refreshClassXML( clazz:Class ):void {
			classXML = ClassDataCache.describeType( clazz, true );
		}

		/**
		 * Klass Constructor
		 * 
		 * @param clazz to create as an XML <code>Klass</code>
		 */ 
		public function Klass( clazz:Class ) {
			
			if ( clazz ) {
				classXML = ClassDataCache.describeType( clazz );
			}

			if ( !classXML ) {
				classXML = <type/>;
			}

			this.clazz = clazz;

			_name = classXML.@name;
		}
	}
}