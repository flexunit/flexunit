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
package org.flexunit.experimental.theories {
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Method;
	
	import org.flexunit.runners.model.FrameworkMethod;
	
	public class ParameterSignature {

		private var _type:Class;
		private var _metaDataList:XMLList;

 		public static function signaturesByMethod( method:Method ):Array {
 			//trace("yo");
			return signatures( method.parameterTypes, method.metadata );
		}
	
		public static function signaturesByContructor( constructor:Constructor ):Array {
			return signatures( constructor.parameterTypes, null );
		}
	
		private static function signatures( parameterTypes:Array, metadataList:XMLList ):Array {
			var sigs:Array = new Array();
			for ( var i:int= 0; i < parameterTypes.length; i++) {
				sigs.push( new ParameterSignature( parameterTypes[i], metadataList ) );
			}
			return sigs;
		}
	
		public function canAcceptType( candidate:Class ):Boolean {
			return ( type == candidate );
		}
	
		public function get type():Class {
			return _type;
		}
	
		public function canAcceptArrayType( field:Field ):Boolean {
			return ( field.type == Array ) && canAcceptType( field.elementType ); 
		}

		public function canAcceptArrayTypeMethod( frameworkMethod:FrameworkMethod ):Boolean {
			return ( frameworkMethod.producesType( Array ) && canAcceptType( frameworkMethod.method.elementType ) );
		}

		public function hasMetadata( type:String ):Boolean {
			return getAnnotation(type) != null;
		}

 		public function findDeepAnnotation( type:String ):XML {
			var metaDataList2:XMLList = _metaDataList.copy();
			return privateFindDeepAnnotation( metaDataList2, type, 3);
		}
	
		private function privateFindDeepAnnotation( metaDataList:XMLList, type:String, depth:int ):XML {
			if (depth == 0)
				return null;

			//just return these for now... not sure how this will apply yet
			return getAnnotation( type );

/* 			for (Annotation each : annotations) {
				if (annotationType.isInstance(each))
					return annotationType.cast(each);
				Annotation candidate= findDeepAnnotation(each.annotationType()
						.getAnnotations(), annotationType, depth - 1);
				if (candidate != null)
					return annotationType.cast(candidate);
			}
			//not really getting this yet
 */	
			return null;
		}

		public function getAnnotation( type:String ):XML {
			for ( var i:int=0;i<_metaDataList.length(); i++ ) {
				if ( _metaDataList[ i ].@name == type ) {
					return _metaDataList[ i ];
				}
			}

			return null;
		}
		
 		public function toString():String {
			return "ParameterSignature ( type:" + type + ", metadata:" + _metaDataList + " )";
		}

		public function ParameterSignature( type:Class, metaDataList:XMLList ) {
			this._type= type;
			this._metaDataList = metaDataList;
		}
	}
}