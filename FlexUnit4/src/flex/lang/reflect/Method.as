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
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	/**
	 * Used to create XML style methods for use with FlexUnit
	 * These XML "methods" are then run through the associated
	 * apply/invoke call and allowing FlexUnit to pull the results
	 */
	public class Method {
		/**
		 * @private
		 */
		private var _methodXML:XML;
		
		/**
		 * @private
		 */
		private var _declaringClass:Class;
		
		/**
		 * @private
		 */
		private var _name:String;
		
		/**
		 * @private
		 */
		private var _parameterTypes:Array;
		
		/**
		 * @private
		 */
		private var _returnType:Class;
		
		/**
		 * @private
		 */
		private var _metaData:Array;
		
		/**
		 * @private
		 */
		private var _isStatic:Boolean = false;
		
		/**
		 * @private
		 */
		private var _elementType:Class;

		/**
		 * Retrieves the metadata attributed to the <code>Method</code>
		 */
		public function get metadata():Array {
			if ( !_metaData ) {
				_metaData = new Array();
				if ( methodXML && methodXML.metadata ) {
					var methodMetaData:XMLList = methodXML.metadata;
					for ( var i:int=0; i<methodMetaData.length(); i++ ) {
						_metaData.push( new MetaDataAnnotation( methodMetaData[ i ] ) );
					}
				}
			}

			return _metaData;
		}

		/**
		 * Retrieves the XML of the <code>Method</code>
		 */
		public function get methodXML():XML {
			return _methodXML;
		} 

		/**
		 * Retrieves the class from which the <code>Method</code> is derived.
		 */
		public function get declaringClass():Class {
			if ( !_declaringClass ) {
				_declaringClass = getDeclaringClassFromMeta( methodXML );
			}

			return _declaringClass;
		} 

		/**
		 * Retrieves the name of the <code>Method</code>
		 */
		public function get name():String {
			return _name;
		} 

		/**
		 * Retrieves the types of the paramaters associated with the <code>Method</code>
		 */
		public function get parameterTypes():Array {
			if ( !_parameterTypes ) {
				_parameterTypes = getParameterTypes( methodXML );
			}

			return _parameterTypes;
		} 

		/**
		 * Retrieves the return type of the <code>Method</code>
		 */
		public function get returnType():Class {
			if ( !_returnType ) { 
				_returnType = getReturnTypeFromMeta( methodXML );
			}

			return _returnType;
		} 

		/**
		 * If the return type is an array, retrieves the type of each element
		 */
		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			if ( ( returnType == Array ) && ( hasMetaData( "ArrayElementType" ) ) ) {
				//we are an array at least, so let's go further;
				var meta:MetaDataAnnotation = getMetaData( "ArrayElementType" );
				var potentialClassName:String;
				
				try {
					if ( meta && meta.arguments ) {
						potentialClassName = meta.defaultArgument.key;
					}
					_elementType = Klass.getClassFromName( potentialClassName );
				} catch ( error:Error ) {
					trace("Cannot find specified ArrayElementType("+meta+") in SWF");
				}
					
			}
			
			return _elementType;
		}

		/**
		 * Returns whether the method is static or not
		 */
		public function get isStatic():Boolean {
			return _isStatic;
		} 
		
		/**
		 * @private
		 */
		private function getFunction( obj:Object ):Function {
			var method:Function;

			if ( isStatic ) {
				method = declaringClass[ name ];
			} else {
				method = obj[ name ];
			}

			return method;			
		}
		
		/**
		 * Calls <code>apply</code> associated with the method
		 * 
		 * <p>
		 * @param obj the item to call
		 * @argArray the paramaters to call with apply, if any
		 * 
		 * <p>
		 * @return result of the apply
		 * 
		 * <p>
		 * @see #invoke()
		 */
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

		/**
		 * Calls <code>apply</code> associated with the method
		 * 
		 * <p>
		 * @param obj the item to call
		 * @args the paramaters to call with apply, if any
		 * 
		 * <p>
		 * @return result of the apply
		 * <p>
		 * @see #apply()
		 */
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

		/**
		 * @private
		 */
		private static function getDeclaringClassFromMeta( methodXML:XML ):Class {
			return Klass.getClassFromName( methodXML.@declaredBy );
		} 

		/**
		 * @private
		 */
		private static function getReturnTypeFromMeta( methodXML:XML ):Class {
			return Klass.getClassFromName( methodXML.@returnType );
		} 
		
		/**
		 * @private
		 */
		private static function getParameterClass( parameter:XML ):Class {
			return Klass.getClassFromName( parameter.@type );
		}

		/**
		 * @private
		 */
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

		/**
		 * Tests if the <code>Method</code> has the paramater metadata
		 * 
		 * <p>
		 * @param name of the metadata
		 * 
		 * <p>
		 * @return <code>true</code> if found, else <code>false</code>
		 */
		public function hasMetaData( name:String ):Boolean {
			return ( getMetaData( name ) != null );
		}
		
		/**
		 * Retrieves the value of the metadata defined by the paramater name with the paramater key.
		 * If key is left blank, will match the first metadata with the paramater name
		 * 
		 * <p>
		 * @param name of the metadata
		 * @param key matching the name (<code>null</code> ok)
		 * 
		 * <p>
		 * @return value of the metadata
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
		 * <code>Method</code> Constructor
		 * 
		 * <p>
		 * @param methodXML XML of the method to create
		 * @param isStatic specifies wether the method is static or not
		 */
		public function Method( methodXML:XML, isStatic:Boolean=false ) {
			_methodXML = methodXML;
			_isStatic = isStatic;

			_name = methodXML.@name;
		}
	}
}