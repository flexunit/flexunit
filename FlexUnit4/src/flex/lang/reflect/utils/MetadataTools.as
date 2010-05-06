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
	/**
	 * The <code>MetadataTools</code> contains methods that are responsible for the parsing and interpretation of XML
	 * metadata.  It contains methods that are responsible for determing whether provided metadata contains a certain 
	 * tag as well as methods used to obtain information from the metadata based on provided keys.
	 */
	public class MetadataTools
	{
		/**
		 * Determine if the <code>description</code> XML describes a class.
		 * 
		 * @param description The XML description to check.
		 * 
		 * @return a Boolean value indicating whether the <code>description</code> XML has a base attribute 
		 * containing "Class" as the value.
		 */
		public static function isClass( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			return ( baseType == "Class" );
		}
		
		/**
		 * Determine if the <code>description</code> XML describes an instance of a class.
		 * 
		 * @param description The XML description to check.
		 * 
		 * @return a Boolean value indicating whether the <code>description</code> XML does not have a base attribute 
		 * containing "Class" as the value.
		 */
		public static function isInstance( description:XML ):Boolean {
			var baseType:String = description.@base;
			
			return ( baseType != "Class" );
		}
		
		/**
		 * Determine if the <code>description</code> XML has a superclass of type <code>className</code>.
		 * 
		 * @param description The XML description to check.
		 * @param className The class name to check.
		 * 
		 * @return a Boolean value indicating whether the <code>description</code> XML extends from
		 *  <code>className</code>.
		 */
		public static function classExtends( description:XML, className:String ):Boolean {
			if ( isClass( description ) ) {
				return classExtendsFromNode( description.factory[ 0 ], className );
			} else {
				return classExtendsFromNode( description, className );
			}
		}
		
		/**
		 * Determine if the <code>description</code> XML implements  <code>interfaceName</code>.
		 * 
		 * @param description The XML description to check.
		 * @param interfaceName The interface name to check.
		 * 
		 * @return a Boolean value indicating whether the <code>description</code> XML implements the 
		 * <code>interfaceName</code>.
		 */
		public static function classImplements( description:XML, interfaceName:String ):Boolean {
			if ( isClass( description ) ) {
				return classImpementsNode( description.factory[ 0 ], interfaceName );
			} else {
				return classImpementsNode( description, interfaceName );
			}
		}
		
		/**
		 * Determine if an XML <code>description</code> contains <code>metadata</code> with the attribute specified by <code>key</code>.
		 * If some nodes exist, the value of the argument node is returned. 
		 * 
		 * @param description The XML description to check.
		 * @param metadata The name of the metadata node to check.
		 * @param key The key used to find the value in the <code>metadata</code> node.
		 * 
		 * @return a String with the value of the specific argument that was found with the <code>metadata</code> name and
		 * <code>key</code>; if no match is found, a value of <code>null</code> is returned.
		 */
		public static function getArgValueFromDescription( description:XML, metadata:String, key:String ):String {
			if ( isClass( description ) ) {
				return getArgValueFromMetaDataNode( description.factory[ 0 ], metadata, key );
			} else {
				return getArgValueFromMetaDataNode( description, metadata, key );
			}
		}
		
		/**
		 * Returns an <code>XMLList</code> containing method nodes of the <code>description</code> XML.
		 * 
		 * @param description The XML description to check.
		 * 
		 * @return an <code>XMLList</code> containing methods nodes of the <code>description</code> XML.
		 */
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
		
		/**
		 * Returns whether the <code>description</code> XML node extends from <code>className</code>.
		 * 
		 * @param method The XML node to check.
		 * @param className The name of the class to check.
		 * 
		 * @return a Boolean value indicating whether the <code>description</code> XML node has a extendsClass node that has 
		 * a type of the provided <code>className</code>.
		 */
		public static function classExtendsFromNode( node:XML, className:String ):Boolean {
			var extendsList:XMLList;
			var doesExtend:Boolean = false;
			
			if ( node && node.extendsClass ) {
				extendsList = node.extendsClass.(@type==className);
				doesExtend = ( extendsList && ( extendsList.length() > 0 ) ); 	
			}
			
			return doesExtend;
		}
		
		/**
		 * Determines if the <code>node</code> XML implements <code>interfaceName</code>.
		 * 
		 * @param node The XML node to check.
		 * @param interfaceName The name of the interface to check.
		 * 
		 * @return a Boolean value indicating whether the <code>node</code> XML node contains an implementsInterface node that has a type attribute
		 * that matches the <code>interfaceName</code>.
		 */
		public static function classImpementsNode( node:XML, interfaceName:String ):Boolean {
			var implementsList:XMLList;
			var doesImplement:Boolean = false;
			
			if ( node && node.implementsInterface ) {
				implementsList = node.implementsInterface.(@type==interfaceName);
				doesImplement = ( implementsList && ( implementsList.length() > 0 ) ); 	
			}
			
			return doesImplement;
		}
		
		/**
		 * Determines if the <code>node</code> XML has metadata <code>metadata</code>.
		 * 
		 * @param method The XML node to check.
		 * @param metadata The name of the metadata name.
		 * 
		 * @return a Boolean value indicating whether <code>node</code> has metadata <code>metadata</code>
		 */
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
		
		/**
		 * Determines if the <code>method</code> node accepts parameters.
		 * 
		 * @param method The XML node to check.
		 * 
		 * @return a Boolean value indicating whether the <code>method</code> node can accept parameters.
		 */
		public static function doesMethodAcceptsParams( method:XML ):Boolean {
			
			if ( method && method.parameter && ( method.parameter.length() > 0 ) ) {
				return true;
			} 
			
			return false;
		}
		
		/**
		 * Returns the return type of paramater <code>method</code> XML node as a String.
		 * 
		 * @param method The XML node to check.
		 * 
		 * @return a String with the return type attribute of the <code>method</code> XML node.  If the XML node is null, an 
		 * empty String is returned.
		 */
		public static function getMethodReturnType( method:XML ):String {
			
			if ( method ) {
				return method.@returnType;
			} 
			
			return "";
		}
		
		/**
		 * Retruns all metadata nodes for a given <code>node</code>.
		 * 
		 * @param node The XML node to check for metadata nodes.
		 * 
		 * @return an XMLList containing all metadata nodes in a given <code>node</code> XML node.  If no metadata nodes 
		 * exist, a value of <code>null</code> is returned.
		 */
		public static function nodeMetaData( node:XML ):XMLList {
			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				var metaNodes:XMLList;
				
				return node.metadata;
			} 
			
			return null;
		}
		
		/**
		 * Retrieves a metadata node with a specific name in the provided <code>nodes</code> XMLList.
		 * 
		 * @param nodes The XMLList that potentially contains the node.
		 * @param type The name of the node to find.
		 * 
		 * @return a metadata node in the <code>nodes</code> XMLList that has a matching name.  If no metadata name matches
		 * a value of <code>null</code> is returned.
		 */
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
		
		/**
		 * Returns the metadata of <code>node</code> if it contains <code>metaDataName</code>
		 * 
		 * @param node The XML node to check.
		 * @param metaDataName The name of the metadata node to check.
		 * 
		 * @return a metadata node that is contained in the <code>node</code> XML and that has a 
		 * metadata name that matches the provided <code>metaDataName</code>.  If no metadata name matches,
		 * a value of <code>null</code> is returned.
		 */
		public static function getArgsFromFromNode( node:XML, metaDataName:String ):XML {
			var metadata:XML;

			if ( node.hasOwnProperty( 'metadata' ) ) {
				var xmlList:XMLList = node.metadata.(@name==metaDataName); 
				metadata = xmlList?xmlList[0]:null; 
			}			

			return metadata;
		}

		//upper/lower case issues
		/**
		 * Returns whether a <code>node</code> contains metadata matching <code>metadata</code> with no key but a value of
		 * <code>value</code>.
		 * 
		 * @param node The XML node to check.
		 * @param metaDataName The name of the metadata node to check.
		 * @param value the String that potentially exists as an value attribute of an argument in the <code>metaDataName</code> node.
		 * 
		 * @return a Boolean value indicating whether a match was found for the corresponding <code>vlaue</code>.
		 */
		public static function checkForValueInBlankMetaDataNode( node:XML, metaDataName:String, value:String ):Boolean {
			var exists:Boolean = false;
			var metaNodes:XMLList;
			var arg:XMLList;

			if ( node && node.metadata && ( node.metadata.length() > 0 ) ) {
				metaNodes = node.metadata.(@name==metaDataName);

				if ( metaNodes.arg ) {
					arg = metaNodes.arg.(@key=="");
					
					//Check each blank key argument and determine if the key value matches the nodes value attribute
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
		/**
		 * Returns the value of a <code>node</code> with metadata matching <code>metadata</code> with key of <code>key</code>.
		 * 
		 * @param node The XML node to check.
		 * @param metaDataName The name of the metadata node to check.
		 * @param key the String that potentially exists as an attribute of an argument in the <code>metaDataName</code> node.
		 * 
		 * @return a String with the value of the specific argument that contains the matching <code>key</code>; if no match 
		 * is found, a value of <code>null</code> is returned.
		 */
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
		
		//Consider upper/lower case issues
		/**
		 * Determine if the <code>node</code> XML contains an argument with key matching <code>key</code>.
		 * 
		 * @param node The XML node to check.
		 * @param key the String that potentially exists as an attribute of an argument in the <code>node</code> XML.
		 * 
		 * @return a String with the value of the specific argument that contains the matching key; if no match is found, a
		 * value of <code>null</code> is returned.
		 */
		public static function getArgValueFromSingleMetaDataNode( node:XML, key:String ):String {
			var value:String;
			var metaNodes:XMLList;
			var arg:XMLList;
			
			if ( node  ) {
				
				if ( node.arg && ( node.arg.length() > 0) ) {
					arg = node.arg.(@key==key);
					
					if ( String( arg.@value ).length > 0 ) {
						value = arg.@value;
					} 
				}
			}
			
			return value;
		}
	}
}