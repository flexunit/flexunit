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
	
	import org.flexunit.constants.AnnotationConstants;
	
	/**
	 * An object representing a method of a class or instance. You can invoke
	 * the method as well as inspect its metadata. 
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
		 * Returns the name of the <code>Method</code>
		 */
		public function get name():String {
			return _name;
		} 

		/**
		 * Returns true if the method is static and false if it is an instance method
		 */
		public function get isStatic():Boolean {
			return _isStatic;
		} 

		/**
		 * Returns the XML used to build this <code>Method</code>
		 */
		public function get methodXML():XML {
			return _methodXML;
		} 		

		/**
		 * Returns the the class where this <code>Method</code> is defined.
		 */
		public function get declaringClass():Class {
			if ( !_declaringClass ) {
				_declaringClass = getDeclaringClassFromMeta( methodXML );
			}
			
			return _declaringClass;
		}

		/**
		 * Returns the return type of the <code>Method</code>
		 */
		public function get returnType():Class {
			if ( !_returnType ) { 
				_returnType = getReturnTypeFromMeta( methodXML );
			}
			
			return _returnType;
		} 
		
		/**
		 * Returns the <code>Method</code> parameter types as an array.
		 */
		public function get parameterTypes():Array {
			if ( !_parameterTypes ) {
				_parameterTypes = getParameterTypes( methodXML );
			}
			
			return _parameterTypes;
		} 

		/**
		 * Returns an array of <code>MetaDataAnnotation</code> instances associated with this
		 * <code>Method</code>.
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
		 * If the return type is an array, returns the type of each element
		 */
		public function get elementType():Class {
			if ( _elementType ) {
				return _elementType;
			}
			
			if ( ( returnType == Array ) && ( hasMetaData( AnnotationConstants.ARRAY_ELEMENT_TYPE ) ) ) {
				//we are an array at least, so let's go further;
				var meta:MetaDataAnnotation = getMetaData( AnnotationConstants.ARRAY_ELEMENT_TYPE );
				var potentialClassName:String;
				
				try {
					if ( meta && meta.arguments ) {
						potentialClassName = meta.defaultArgument.key;
					}
					_elementType = Klass.getClassFromName( potentialClassName );
				} catch ( error:Error ) {
					_elementType = null;
					trace("Cannot find specified ArrayElementType("+meta+") in SWF");
				}
					
			}
			
			return _elementType;
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
		 * Calls <code>apply</code> on the method
		 * 
		 * @param obj the item to call
		 * @param argArray the paramaters to call with apply, if any
		 * 
		 * @return return value of the method
		 * 
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
		 * Calls <code>apply</code> on the method
		 * 
		 * @param obj the item to call
		 * @param args the paramaters to call with apply, if any
		 * 
		 * @return return value of the method
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
			var type:Class;
			
			if ( String( methodXML.@declaredBy ).length > 0 ) {
				type = Klass.getClassFromName( methodXML.@declaredBy ); 	
			}
			
			return type; 
		} 

		/**
		 * @private
		 */
		private static function getReturnTypeFromMeta( methodXML:XML ):Class {
			var type:Class;

			if ( String( methodXML.@returnType ).length > 0 ) {
				type = Klass.getClassFromName( methodXML.@returnType ); 	
			}
			
			return type; 
		} 
		
		/**
		 * @private
		 */
		private static function getParameterClass( parameter:XML ):Class {
			var type:Class;
			
			if ( String( parameter.@type ).length > 0 ) {
				type = Klass.getClassFromName( parameter.@type ); 	
			}
			
			return type; 
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
		 * Clones the existing method 
		 * @return a new Method
		 * 
		 */
		public function clone():Method {
			var xmlCopy:XML = methodXML.copy();
			var newMethod:Method = new Method( xmlCopy, isStatic );
			
			return newMethod;
		}
		
		/**
		 * Compares two Method instances for equality
		 * 
		 * @return Returns boolean indicating equality
		 * 
		 */
		public function equals( item:Method ):Boolean {
			if ( !item ) {
				return false;
			}
			
			var equiv:Boolean = ( ( this.name == item.name ) && 
				( this.isStatic == item.isStatic ) &&
				( this.declaringClass == item.declaringClass ) &&
				( this.returnType == item.returnType ) );

			var localParams:Array = this.parameterTypes;
			var remoteParams:Array = item.parameterTypes;

			var localMetaData:Array = this.metadata;
			var remoteMetaData:Array = item.metadata;
			
			if ( equiv ) {
				var localParamLen:int = localParams?localParams.length:0;
				var remoteParamLen:int = remoteParams?remoteParams.length:0;

				if ( localParamLen != remoteParamLen ) {
					return false;
				}

				if ( localParamLen > 0) {
					for ( var j:int=0; j<localParamLen; j++ ) {
						equiv = localParams[ j ] == remoteParams[ j ];
						if (!equiv) {
							break;
						}
					}
				}

				var localMetaLen:int = localMetaData?localMetaData.length:0;
				var remoteMetaLen:int = remoteMetaData?remoteMetaData.length:0;
				
				if ( localMetaLen != remoteMetaLen ) {
					return false;
				}
				
				if ( localMetaLen > 0) {
					for ( var i:int=0; i<localMetaLen; i++ ) {
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
		 * Constructor 
		 * Parses &lt;method/&gt; nodes returned from a call to &lt;code&gt;describeType&lt;/code&gt; to provide an 
		 * object wrapper for Methods
		 * 
		 * Expected format of the argument is
		 *     &lt;method name=&quot;someMethod&quot; declaredBy=&quot;tests::SomeClass&quot; returnType=&quot;void&quot;&gt;
		 * 		 &lt;metadata name=&quot;Before&quot;&gt;
		 * 			&lt;arg key=&quot;order&quot; value=&quot;2&quot;/&gt;
		 * 		 &lt;/metadata&gt;
		 * 	   &lt;/method&gt;
		 * 
		 * @param A &lt;metadata/&gt; XML node.
		 * 
		 */
		public function Method( methodXML:XML, isStatic:Boolean=false ) {

			if ( !methodXML ) {
				throw new ArgumentError("Valid XML must be provided to Method Constructor");
			}
			
			_methodXML = methodXML;
			_isStatic = isStatic;

			_name = methodXML.@name;
		}
	}
}