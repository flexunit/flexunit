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
	
	public class Method {
		private var _methodXML:XML;
		private var _declaringClass:Class;
		private var _name:String;
		private var _parameterTypes:Array;
		private var _returnType:Class;
		private var _metaData:XMLList;
		private var _isStatic:Boolean = false;
		private var _elementType:Class;

		public function get metadata():XMLList {
			if ( !_metaData ) {
				_metaData = MetadataTools.nodeMetaData( methodXML );	
			}

			return _metaData;
		}

		public function get methodXML():XML {
			return _methodXML;
		} 

		public function get declaringClass():Class {
			if ( !_declaringClass ) {
				_declaringClass = getDeclaringClassFromMeta( methodXML );
			}

			return _declaringClass;
		} 

		public function get name():String {
			return _name;
		} 

		public function get parameterTypes():Array {
			if ( !_parameterTypes ) {
				_parameterTypes = getParameterTypes( methodXML );
			}

			return _parameterTypes;
		} 

		public function get returnType():Class {
			if ( !_returnType ) { 
				_returnType = getReturnTypeFromMeta( methodXML );
			}

			return _returnType;
		} 

		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			if ( ( returnType == Array ) && ( hasMetaData( "ArrayElementType" ) ) ) {
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

		public function get isStatic():Boolean {
			return _isStatic;
		} 
		
		private function getFunction( obj:Object ):Function {
			var method:Function;

			if ( isStatic ) {
				method = declaringClass[ name ];
			} else {
				method = obj[ name ];
			}

			return method;			
		}
		
		public function apply( obj:Object, argArray:* ):* {
			var method:Function = getFunction( obj );
			var returnVal:Object;
			
			if ( argArray && ( argArray.length > 0 ) ) {
				returnVal = method.apply( obj, argArray );
			} else {
				returnVal = method.apply( obj );
			}
			
			return returnVal;
		}

		public function invoke( obj:Object, ...args ):Object {
			var method:Function = getFunction( obj );
			var returnVal:Object;

			if ( args && ( args.length > 0 ) ) {
				returnVal = method.apply( obj, args );
			} else {
				returnVal = method.apply( obj );
			}
			
			return returnVal;
		}

		private static function getDeclaringClassFromMeta( methodXML:XML ):Class {
			return Klass.getClassFromName( methodXML.@declaredBy );
		} 

		private static function getReturnTypeFromMeta( methodXML:XML ):Class {
			return Klass.getClassFromName( methodXML.@returnType );
		} 
		
		private static function getParameterClass( parameter:XML ):Class {
			return Klass.getClassFromName( parameter.@type );
		}

		private static function getParameterTypes( methodXML:XML ):Array {
			var paramsLength:int = 0;
			var paramArray:Array;
			var parameters:XMLList = methodXML.parameter;

			if (!paramArray) {
				paramArray = new Array();
			}
			
			paramsLength = parameters.length();

			if ( parameters && paramsLength>0 ) {
				for ( var i:int=0; i<paramsLength; i++ ) {
					paramArray.push( getParameterClass( parameters[ i ] ) );
				}
			}
			
			return paramArray;
		}

		public function hasMetaData( name:String ):Boolean {
			return MetadataTools.nodeHasMetaData( _methodXML, name );
		}
		
		public function getMetaData( name:String, key:String="" ):String {
			return MetadataTools.getArgValueFromMetaDataNode( _methodXML, name, key );
		}

		public function Method( methodXML:XML, isStatic:Boolean=false ) {
			_methodXML = methodXML;
			_isStatic = isStatic;

			_name = methodXML.@name;
			
/* 			_metaData = MetadataTools.nodeMetaData( methodXML );
			_declaringClass = getDeclaringClassFromMeta( methodXML );
			_returnType = getReturnTypeFromMeta( methodXML );
			_parameterTypes = getParameterTypes( methodXML );
 */		}
	}
}