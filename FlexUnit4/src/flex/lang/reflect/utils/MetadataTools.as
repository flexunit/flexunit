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
package flex.lang.reflect.utils
{
	public class MetadataTools
	{
		public static function isClass( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			return ( baseType == "Class" );
		}

		public static function isInstance( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			return ( baseType != "Class" );
		}

		public static function classExtends( description:XML, className:String ):Boolean {
			if ( isClass( description ) ) {
				return classExtendsFromNode( description.factory[ 0 ], className );
			} else {
				return classExtendsFromNode( description, className );
			}
		}
		
		public static function classImplements( description:XML, interfaceName:String ):Boolean {
			if ( isClass( description ) ) {
				return classImpementsNode( description.factory[ 0 ], interfaceName );
			} else {
				return classImpementsNode( description, interfaceName );
			}
		}
		
		
		public static function getArgValueFromDescription( description:XML, metadata:String, key:String ):String {
			if ( isClass( description ) ) {
				return getArgValueFromMetaDataNode( description.factory[ 0 ], metadata, key );
			} else {
				return getArgValueFromMetaDataNode( description, metadata, key );
			}
		}
		
		public static function getMethodsList( description:XML ):XMLList {
			return description.method;
		} 

		public static function getMethodsDecoratedBy( methodList:XMLList, metadata:String ):XMLList {
			var narrowedMethodList:XMLList = methodList.metadata.(@name==metadata);
			var parentNodes:XMLList = new XMLList();
			
			for ( var i:int=0; i<narrowedMethodList.length(); i++ ) {
				parentNodes += narrowedMethodList[ i ].parent();
			}
	
			return parentNodes;
		} 
		
		public static function classExtendsFromNode( node:XML, className:String ):Boolean {
			var extendsList:XMLList;
			var doesExtend:Boolean = false;
			
			if ( node && node.extendsClass ) {
				extendsList = node.extendsClass.(@type==className);
				doesExtend = ( extendsList && ( extendsList.length() > 0 ) ); 	
			}
			
			return doesExtend;
		}

		public static function classImpementsNode( node:XML, interfaceName:String ):Boolean {
			var implementsList:XMLList;
			var doesImplement:Boolean = false;
			
			if ( node && node.implementsInterface ) {
				implementsList = node.implementsInterface.(@type==interfaceName);
				doesImplement = ( implementsList && ( implementsList.length() > 0 ) ); 	
			}
			
			return doesImplement;
		}

		public static function nodeHasMetaData( node:XML, metadata:String ):Boolean {
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				var metaNodes:XMLList;
				
				metaNodes = node.metadata.(@name==metadata);
				
				if ( metaNodes.length() > 0  ) {
					return true;
				}
			} 
			
			return false;
		}

		public static function doesMethodAcceptsParams( method:XML ):Boolean {
			
			if ( method && method.parameter && ( method.parameter.length() > 0 ) ) {
				return true;
			} 
			
			return false;
		}

		public static function getMethodReturnType( method:XML ):String {
			
			if ( method ) {
				return method.@returnType;
			} 
			
			return "";
		}

		public static function nodeMetaData( node:XML ):XMLList {
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				var metaNodes:XMLList;
				
				return node.metadata;
			} 
			
			return null;
		}
		
		public static function getArgsFromFromNode( node:XML, metaDataName:String ):XML {
			var metadata:XML;

			if ( node.hasOwnProperty( 'metadata' ) ) {
				var xmlList:XMLList = node.metadata.(@name==metaDataName); 
				metadata = xmlList?xmlList[0]:null; 
			}			

			return metadata;
		}

		//upper/lower case issues
		public static function checkForValueInBlankMetaDataNode( node:XML, metaDataName:String, value:String ):Boolean {
			var exists:Boolean = false;
			var metaNodes:XMLList;
			var arg:XMLList;

			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				metaNodes = node.metadata.(@name==metaDataName);

				if ( metaNodes.arg ) {
					arg = metaNodes.arg.(@key=="");
					
					for ( var i:int=0; i<arg.length(); i++ ) {
						if ( arg[ i ].@value == value ) {
							exists = true;
							break
						}
					}
				}
			}
			
			return exists;
		}
		
		//Consider upper/lower case issues
		public static function getArgValueFromMetaDataNode( node:XML, metaDataName:String, key:String ):String {
			var value:String;
			var metaNodes:XMLList;
			var arg:XMLList;

			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				metaNodes = node.metadata.(@name==metaDataName);

				if ( metaNodes.arg ) {
					arg = metaNodes.arg.(@key==key);
					
					if ( String( arg.@value ).length > 0 ) {
						value = arg.@value;
					}
				}
			}
			
			return value;
		}
	}
}