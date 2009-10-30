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
package flex.lang.reflect.utils
{
	public class MetadataTools
	{
		/**
		 * Invoke to test if {@link XML} describes a class
		 * 
		 * @param description the XML to check
		 * 
		 * @return <code>true</code> if XML describes a class, otherwise <code>false</code>
		 */
		public static function isClass( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			//Return true if our XML describes a class
			return ( baseType == "Class" );
		}

		/**
		 * Invoke to test if {@link XML} describes an instance of a class
		 * 
		 * @param description the XML to check
		 * 
		 * @return <code>true</code> if XML describes an instance, otherwise <code>false</code>
		 */
		public static function isInstance( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			//Return true if our XML does not describe a class, meaning it must be an instance
			return ( baseType != "Class" );
		}

		/**
		 * Invoke to test if {@link XML} extends a class
		 * 
		 * @param description the XML to check
		 * @param className the name of the class to check for as a <code>String</code>
		 * 
		 * @return <code>true</code> if XML extends from the class, otherwise <code>false</code>
		 */
		public static function classExtends( description:XML, className:String ):Boolean {
			if ( isClass( description ) ) {
				//If our XML describes a class use the factory description to check if it extends a paramater class
				//and return true if it does.
				return classExtendsFromNode( description.factory[ 0 ], className );
			} else {
				//If it is not a class it must be an instance.  In that case return true if our XML
				//describes a class that extends from the paramater class.
				return classExtendsFromNode( description, className );
			}
		}
		
		/**
		 * Invoke to test if {@link XML} implements a specific class
		 * 
		 * @param description the XML to check
		 * @param interfaceName name of the class to check for as a <code>String</code>
		 * 
		 * @return <code>true</code> if XML implements the class, otherwise <code>false</code>
		 */
		public static function classImplements( description:XML, interfaceName:String ):Boolean {
			if ( isClass( description ) ) {
				//If our XML describes a class, use the factory description to return true if our class
				//Implements the parameter interface.
				return classImpementsNode( description.factory[ 0 ], interfaceName );
			} else {
				//Otherwise, our class is an instance.  Return true if it implements the interface.
				return classImpementsNode( description, interfaceName );
			}
		}
		
		/**
		 * Invoke to retrieve the specified metadata from the XML that matches the specified method (if any)
		 * 
		 * @param description class definition as XML to check
		 * @param metadata the metadata to search for as a <code>String</code>
		 * @param key the name of the method to to search as a <code>String</code>
		 * 
		 * @return <code>String</code> value of metadata specified by metadata paramater
		 */
		public static function getArgValueFromDescription( description:XML, metadata:String, key:String ):String {
			if ( isClass( description ) ) {
				//If our XML describes a class, get the factory description specified by metadata and key
				return getArgValueFromMetaDataNode( description.factory[ 0 ], metadata, key );
			} else {
				//Else it is an instance, get the metadata value from the description.
				return getArgValueFromMetaDataNode( description, metadata, key );
			}
		}
		
		/**
		 * Invoke to retrieve the methods specified in our description XML
		 * 
		 * @param description XML to retrieve the method XMLList
		 * 
		 * @return methods as an <code>XMLList</code>
		 */
		public static function getMethodsList( description:XML ):XMLList {
			return description.method;
		} 

		public static function getMethodsDecoratedBy( methodList:XMLList, metadata:String ):XMLList {
			var narrowedMethodList:XMLList = methodList.metadata.(@name==metadata);
			var parentNodes:XMLList = new XMLList();
			
			//After narrowing our list, return all parents of classes that have a description specified
			//by the paramater metadata.
			for ( var i:int=0; i<narrowedMethodList.length(); i++ ) {
				parentNodes += narrowedMethodList[ i ].parent();
			}
	
			return parentNodes;
		} 
		
		/**
		 * 
		 */
		public static function classExtendsFromNode( node:XML, className:String ):Boolean {
			var extendsList:XMLList;
			var doesExtend:Boolean = false;
			
			//Parse the XML for a class that extends the parameter class.  If the list is
			//is not null(the class does extend the parameter), return true.  Else return false.
			if ( node && node.extendsClass ) {
				extendsList = node.extendsClass.(@type==className);
				//extendsList is never null, but may be empty
				//doesExtend = ( extendsList && ( extendsList.length() > 0 ) );
				doesExtend = ( extendsList.length() > 0 );
			}
			
			return doesExtend;
		}

		public static function classImpementsNode( node:XML, interfaceName:String ):Boolean {
			var implementsList:XMLList;
			var doesImplement:Boolean = false;
			
			//Parse the XML for a class that implements the parameter interface.  If the list is
			//not null(the class does implement the interface), return true.  Else, return false
			if ( node && node.implementsInterface ) {
				implementsList = node.implementsInterface.(@type==interfaceName);
				//implementsList is never null, but it may be empty
				//doesImplement = ( implementsList && ( implementsList.length() > 0 ) );
				doesImplement = ( implementsList.length() > 0 );
			}
			
			return doesImplement;
		}

		public static function nodeHasMetaData( node:XML, metadata:String ):Boolean {
			//If the XML class has metadata
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				var metaNodes:XMLList;
				
				//Find all nodes matching the parameter metadata.
				metaNodes = node.metadata.(@name==metadata);
				
				//If we have at least one node with the specified metadata, return true
				if ( metaNodes.length() > 0  ) {
					return true;
				}
			} 
			
			return false;
		}

		public static function doesMethodAcceptsParams( method:XML ):Boolean {
			
			//If the XML class specifies parameters, return true
			//TODO: A method will always have a paramater list, we only care if it is empty
			//if ( method && method.parameter && ( method.parameter.length() > 0 ) ) {
			if ( method && ( method.parameter.length() > 0 ) ) {
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
			//If the XML class has metadata, return that metadata
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				var metaNodes:XMLList;
				
				return node.metadata;
			} 
			
			return null;
		}
		
		public static function getMetaDataNodeFromNodesList( nodes:XMLList, type:String ):XML {
			if(nodes) {
				
				var node:XML;
				for( var i:int=0; i<nodes.length(); i++ ) {
					node = nodes[i] as XML;
					
					//Determine if the node contains a name with the referenced type
					if( ( node.(@name == type) ).length() ) {
						return  node;
					}
				}
			}
			
			return null;
		}
		
		public static function getArgsFromFromNode( node:XML, metaDataName:String ):XML {
			var metadata:XML;

			//If the XML has metadata, return the first child with the parameter metadata
			//Else return null.
			if ( node.hasOwnProperty( 'metadata' ) ) {
				var xmlList:XMLList = node.metadata.(@name==metaDataName);
				//TODO: is there ever a case when xmlList is null?
				//metadata = xmlList?xmlList[0]:null;
				metadata = ( xmlList.length() > 0 )?xmlList[0]:null;
			}			

			return metadata;
		}

		//upper/lower case issues
		public static function checkForValueInBlankMetaDataNode( node:XML, metaDataName:String, value:String ):Boolean {
			var exists:Boolean = false;
			var metaNodes:XMLList;
			var arg:XMLList;

			//In the case that we have metadata
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				//Pull any metadata specified by the parameter name
				metaNodes = node.metadata.(@name==metaDataName);

				//If any metadata is found
				//if ( metaNodes.arg ) {
				if ( metaNodes.arg.length() > 0 ) {
					//Check if any have a missing key
					arg = metaNodes.arg.(@key=="");
					
					for ( var i:int=0; i<arg.length(); i++ ) {
						//If any of the metadata with a missing key actually has a value, return true
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

			//If metadata exists
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				//Find all metadata that matches the parameter name
				metaNodes = node.metadata.(@name==metaDataName);

				//If some metadata is found matching the name, find any that match the key
				//if ( metaNodes.arg ) {
				if ( metaNodes.arg.length() > 0 ) {
					arg = metaNodes.arg.(@key==key);
					
					//And return the value specified.  If the value is empty, returns an empty string.
					if ( String( arg.@value ).length > 0 ) {
						value = arg.@value;
					}
				}
			}
			
			return value;
		}
		
		//Consider upper/lower case issues
		public static function getArgValueFromSingleMetaDataNode( node:XML, key:String ):String {
			var value:String;
			var metaNodes:XMLList;
			var arg:XMLList;
			
			if ( node  ) {
				
				//If any metadata exists
				if ( ( node.arg.length() > 0) ) {
					//Find any that matches the specified key
					arg = node.arg.(@key==key);
					
					//And return the value if any.
					if ( String( arg.@value ).length > 0 ) {
						value = arg.@value;
					} 
				}
			}
			
			return value;
		}
	}
}