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
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.utils.MetadataTools;

	public class Klass {
		private static var metaDataCache:Dictionary = new Dictionary();

		private var classXML:XML;
		private var clazz:Class;
		public function get asClass():Class {
			return clazz;
		}
		
		private var _name:String;		
		public function get name():String {
			return _name;			
		}

		private var _metaData:XMLList;
		public function get metadata():XMLList {
			if ( !_metaData ) {
				_metaData = MetadataTools.nodeMetaData( classXML.factory[ 0 ] );	
			}

			return _metaData;
		}

		internal function get constructorXML():XML {
			return classXML.factory.constructor[ 0 ];
		}

		private var _constructor:Constructor;
		public function get constructor():Constructor {
			if ( !_constructor ) {
				_constructor = new Constructor( constructorXML, this )
			}
			return _constructor;
		}

		public function getField( name:String ):Field {
			for ( var i:int=0; i<fields.length; i++ ) {
				if ( fields[i].name == name ) {
					return fields[i];
				}
			}

			return null;
		}

		private var _fields:Array;
		public function get fields():Array {
			if (!_fields ) {
				_fields = buildFields();
			}

			return _fields;
		}

		public function getMethod( name:String ):Method {
			for ( var i:int=0; i<methods.length; i++ ) {
				if ( methods[i].name == name ) {
					return methods[i];
				}
			}

			return null;
		}

		private var _methods:Array;
		public function get methods():Array {
			if ( !_methods ) {
				_methods = buildMethods();
			}
			return _methods;
		}

		public function get interfaces():Array {
			return null;
		}

		private var _packageName:String;
		public function get packageName():String {
			if ( !_packageName ) {				
				_packageName = name.substr( 0, name.indexOf( "::" ) );
			}

			return _packageName;
		}

		public function get superClass():Class {
			return getClassFromName( classXML.factory.extendsClass.type );
		}

		private var _classDef:Class;
		public function get classDef():Class {
			if ( !_classDef ) {
				_classDef = getClassFromName( name );
			}
			
			return _classDef;
		}
		
		public function descendsFrom( clazz:Class ):Boolean {
			var className:String = getQualifiedClassName( clazz );	

			return MetadataTools.classExtendsFromNode( classXML.factory[ 0 ], className );
		}

		private static function getDotPathFromName( name:String ):String {
			var colonReplace:RegExp = /::/g;
			name = name.replace( colonReplace, "." );
			
			return name;
		}

		public static function getClassFromName( name:String ):Class {
			var stringName:String = getDotPathFromName( name );

			if ( stringName == "void" || stringName == "*" ) {
				return null;
			}

			return getDefinitionByName( stringName ) as Class;
		}
		
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
			if ( XMLList( classXML ).length() > 0 ) {
				staticMethodList = MetadataTools.getMethodsList( classXML );
			}

			for ( var j:int=0; j<staticMethodList.length(); j++ ) {
				methods.push( new Method( staticMethodList[ j ], true ) );
			}

			return methods;
		}

		private function buildFields():Array {
			var fields:Array = new Array();
			var fieldList:XMLList = classXML.factory.variable;			
			
			for ( var i:int=0; i<fieldList.length(); i++ ) {
				fields.push( new Field( fieldList[ i ], false, clazz ) );
			}

			var staticFieldList:XMLList = classXML.variable;			

			for ( var j:int=0; j<staticFieldList.length(); j++ ) {
				fields.push( new Field( staticFieldList[ j ], true, clazz ) );
			}

			return fields;
		}

		public function hasMetaData( name:String ):Boolean {
			return MetadataTools.nodeHasMetaData( classXML.factory[ 0 ], name );
		}
		
		public function getMetaData( name:String, key:String="" ):String {
			return MetadataTools.getArgValueFromMetaDataNode( classXML.factory[ 0 ], name, key );
		}
		
		internal function setDefintionForClass( clazz:Class ):void {
			classXML = cacheAndReturnDefintionForClass( clazz );
		}

		internal static function cacheAndReturnDefintionForClass( clazz:Class ):XML {			
			metaDataCache[ clazz ] = describeType( clazz ); 
			return getXMLForClass( clazz );
		} 

		internal static function getXMLForClass( clazz:Class ):XML {
			return metaDataCache[ clazz ];
		} 
		
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