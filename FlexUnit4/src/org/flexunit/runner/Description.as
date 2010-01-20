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
package org.flexunit.runner {
	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.Klass;
	
	import mx.utils.ObjectUtil;
	
	/**
	 * A <code>Description</code> describes a suite, test case, or test which is to be run or has been run. 
	 * <code>Descriptions</code> can be atomic (a single test) or compound (containing children tests). 
	 * <code>Description</code>s are used to provide feedback about the tests that are about to run (for example, 
	 * the tree view visible in many IDEs) or tests that have been run (for example, the failures view).
	 * This information can be used to report the current progress of the test run.<br/>
	 * 
	 * <code>Description</code>s are implemented as a single class rather than a composite because
	 * they are entirely informational. They contain no logic aside from counting their tests.<br/>
	 * 
	 * @see org.flexunit.runner.IRunner
	 */
	public class Description implements IDescription {
		public static var EMPTY:Description = new Description("Empty", null );
		public static var TEST_MECHANISM:Description = new Description("Test mechanism", null );
		
		/**
		 * @private
		 */
		private var _children:Array;
		/**
		 * @private
		 */
		private var _displayName:String = "";
		/**
		 * @private
		 */
		private var _metadata:Array;
		/**
		 * @private
		 */
		private var _isInstance:Boolean = false;
		
		/**
		 * @return a list of the receiver's children, if any exists.
		 */
		public function get children():Array {
			return _children;
		}

		/**
		 * @return a user-understandable label.
		 */
		public function get displayName():String {
			return _displayName;
		}

		/**
		 * @return <code>true</code> if the receiver is a suite.
		 */
		public function get isSuite():Boolean {
			return !isTest;
		}

		/**
		 * @return <code>true</code> if the receiver is an atomic test.
		 */
		public function get isTest():Boolean {
			return ( ( children == null ) || ( children && children.length == 0 ) );
		}

		/**
		 * @return the total number of atomic tests in the receiver.
		 */
		public function get testCount():int {
			if ( isTest ) {
				return 1;
			}

			var result:int = 0;
			
			//If the receiver has children, determine how many tests they have
			if ( children ) {
				var child:IDescription;
				for ( var i:int=0; i<children.length; i++ ) {
					child = children[ i ] as IDescription;
					result += child.testCount;
				}
			}

			return result;
		}

		/**
		 * Returns the metadata node that is attached to this description if a node is found with a matching <code>type</code> 
		 * or a value of <code>null</code> if no such node exists.
		 * 
		 * @param type The name of the node to find in the description's metadta.
		 * 
		 * @return the metadata node that is attached to this description if a node is found with a matching <code>type</code> 
		 * or a value of <code>null</code> if no such node exists.
		 */
/*		public function getMetadata( type:String ):Array {
			var metaDataItems:Array = new Array();
			var allMetaData:Array = getAllMetadata();
			
			for ( var i:int=0; i<allMetaData.length; i++ ) {
				if ( ( allMetaData[ i ] as MetaDataAnnotation ).name == type ) {
					metaDataItems.push( allMetaData[ i ] ); 
				}
			}
			 
			//Extract specific needed node by type
			return metaDataItems;
		}*/
		
		/**
		 * Returns all of the metadata that is attached to this description node.
		 * 
		 * @return the metadata as XML that is attached to this description node, 
		 * or null if none exists
		 */
		public function getAllMetadata():Array {
			return _metadata;
		}
		
		/**
		 * @return <code>true</code> if the receiver is an instance
		 */
		public function get isInstance():Boolean {
			return ( _isInstance );
		}

		/**
		 * @return true if this is a description of a Runner that runs no tests
		 */
		public function get isEmpty():Boolean {
			return ( !isTest && ( testCount == 0 ) );
		}

		/**
		 * Adds an <code>IDescription</code> as a child of the receiver.
		 * 
		 * @param description the soon-to-be child.
		 */
		public function addChild( description:IDescription ):void {
			children.push( description );
		}
		
		/**
		 * Returns a copy of this description, with no children (on the assumption that some of the
		 * children will be added back).
		 * 
		 * @return a copy of this description, with no children (on the assumption that some of the
		 * children will be added back).
		 */
		public function childlessCopy():IDescription {
			trace("Method not yet implemented");
			return new Description( _displayName, _metadata );
		}
		
		/**
		 * Determines if the current description is equal to the provided <code>obj</code>.
		 * 
		 * @param obj The object to check against the current description.
		 * 
		 * @return true if this is a description of a Runner that runs no tests
		 */
		public function equals( obj:Object ):Boolean {
			if (!(obj is Description))
				return false;

			var d:Description = Description( obj );
			
			//Determine if the displayNames and children are equal; if so, the descriptions are equal
			return ( ( displayName == d.displayName ) && ( ObjectUtil.compare( children, d.children ) == 0 ) );
		}		

		/**
		 * Creates an <code>IDescription</code> named <code>name</code>.
		 * Generally, you will add children to this <code>IDescription</code>.
		 * 
		 * @param suiteClassOrName The class of the object to be described or the name of 
		 * the class to be subscribed.
		 * @param metaData Metadata about the test.
		 * 
		 * @return an <code>IDescription</code> named <code>name</code>.
		 */
		public static function createSuiteDescription( suiteClassOrName:*, metaData:Array=null ):IDescription {
			var description:Description;			
			if ( suiteClassOrName is String ) {
				description = new Description( suiteClassOrName, metaData );
			} else {
				//description = new Description(suiteClassOrName.name, suiteClassOrName.metaData );
				//instantiating a new Klass with suiteClassOrName passed in.  Necessary to get the metadata for the description.
				var klass : Klass = new Klass( suiteClassOrName );
				description = new Description( getQualifiedClassName( suiteClassOrName ), klass.metadata );
			}

			return description;
		}

		/**
		 * Creates a <code>Description</code> of a single test named <code>name</code> in the class <code>testClassOrDescription</code>.
		 * Generally, this will be a leaf <code>IDescription</code>.
		 * 
		 * @param testClassOrInstance The class of the test.
		 * @param name The name of the test.
		 * @param metadata Metadata about the test.
		 * 
		 * @return an <code>IDescription</code> named <code>name</code>.
		 */
		public static function createTestDescription( testClassOrInstance:Class, name:String, metadata:Array=null ):IDescription {
			var description:Description = new Description( getQualifiedClassName( testClassOrInstance) + '.' + name, metadata );
			return description;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param displayName The display name of the description node.
		 * @param metadata The metadata of the description node.
		 * @param isInstance A Boolean value indicating whether the descrption node is an instance.
		 */
		public function Description( displayName:String, metadata:Array, isInstance:Boolean=false ) {
			//_testClassOrInstance = testClassOrInstance;
			_displayName = displayName;
			_isInstance = isInstance;
			
			_children = new Array();
			_metadata = metadata;
		}
	}
}