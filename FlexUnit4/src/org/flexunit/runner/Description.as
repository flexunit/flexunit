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
package org.flexunit.runner {
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	/**
	 * <p>A <code>Description</code> describes a test which is to be run or has been run. <code>Descriptions</code> 
	 * can be atomic (a single test) or compound (containing children tests). <code>Descriptions</code> are used
	 * to provide feedback about the tests that are about to run (for example, the tree view
	 * visible in many IDEs) or tests that have been run (for example, the failures view).</p>
	 * 
	 * <p><code>Descriptions</code> are implemented as a single class rather than a Composite because
	 * they are entirely informational. They contain no logic aside from counting their tests.</p>
	 * 
	 *  //TODO: Link to appropriate flexunit directories or remove links if N/A
	 * 
	 * <p>In the past, we used the raw {@link junit.framework.TestCase}s and {@link junit.framework.TestSuite}s
	 * to display the tree of tests. This was no longer viable in JUnit 4 because atomic tests no longer have 
	 * a superclass below {@link Object}. We needed a way to pass a class and name together. Description 
	 * emerged from this.</p>
	 * 
	 * @see org.flexunit.runner.Request
	 * @see org.flexunit.runner.Runner
	 */
	public class Description implements IDescription {
		public static var EMPTY:Description = new Description("Empty", null );
		public static var TEST_MECHANISM:Description = new Description("Test mechanism", null );

		private var _children:ArrayCollection;
		private var _displayName:String = "";
		private var _metadata:XML;
		private var _isSuite:Boolean = false;
		private var _testCount:int = 0;
		private var _isInstance:Boolean = false;
		
		/**
		 * @return the receiver's children, if any
		 */
		public function get children():ArrayCollection {
			return _children;
		}

		/**
		 * @return a user-understandable label
		 */
		public function get displayName():String {
			return _displayName;
		}

		/**
		 * @return <code>true</code> if the receiver is a suite
		 */
		public function get isSuite():Boolean {
			return _isSuite;
		}

		/**
		 * @return <code>true</code> if the receiver is an atomic test
		 */
		public function get isTest():Boolean {
			return !isSuite;
		}

		/**
		 * @return the total number of atomic tests in the receiver
		 */
		public function get testCount():int {
			return _testCount;
		}

		/**
		 * @return the metadata as XML that is attached to this description node, 
		 * or null if none exists
		 */
		public function getMetadata( type:String ):XML {			
			return _metadata;
		}

		public function getAllMetadata():XMLList {
			trace("Method not yet implemented");
			return new XMLList();
		}

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
		 * Add <code>Description</code> as a child of the receiver.
		 * @param description the soon-to-be child.
		 */
		public function addChild( description:IDescription ):void {
			children.addItem( description );
			
			if ( description.isTest ) {
				_testCount++;
			}
		}
		
			/**
		 * @return a copy of this description, with no children (on the assumption that some of the
		 * children will be added back)
		 */
		public function childlessCopy():IDescription {
			trace("Method not yet implemented");
			return new Description( _displayName, _metadata );
		}

		public function equals( obj:Object ):Boolean {
			if (!(obj is Description))
				return false;

			var d:Description = Description( obj );
			return ( ( displayName == d.displayName ) && ( ObjectUtil.compare( children, d.children ) == 0 ) );
		}		

		/**
		 * Create a <code>Description</code> named <code>name</code>.
		 * Generally, you will add children to this <code>Description</code>.
		 * @param suiteClassOrName the name of the <code>Description</code> or an existing Description 
		 * @param metaData 
		 * @return a <code>Description</code> named <code>name</code>
		 */
		public static function createSuiteDescription( suiteClassOrName:*, metaData:XML=null ):IDescription {
			var description:Description;
			if ( suiteClassOrName is String ) {
				description = new Description( suiteClassOrName, metaData );
			} else {
				//description = new Description(suiteClassOrName.name, suiteClassOrName.metaData );
				description = new Description( getQualifiedClassName( suiteClassOrName ), suiteClassOrName.metaData );
			}

			return description;
		}

		/**
		 * Create a <code>Description</code> of a single test named <code>name</code> in the class <code>testClassOrDescription</code>.
		 * Generally, this will be a leaf <code>Description</code>.
		 * @param testClassOrInstance the class of the test
		 * @param name the name of the test (a method name for test annotated with {@link org.junit.Test})
		 * @param metadata meta-data about the test, for downstream interpreters
		 * @return a <code>Description</code> named <code>name</code>
		 */
		public static function createTestDescription( testClassOrInstance:Class, name:String, metadata:XML=null ):IDescription {
			var description:Description = new Description( getQualifiedClassName( testClassOrInstance) + '.' + name, metadata );
			return description;
		}

		public function Description( displayName:String, metadata:XML, isInstance:Boolean=false ) {
			//_testClassOrInstance = testClassOrInstance;
			_displayName = displayName;
			_isInstance = isInstance;
			
			_children = new ArrayCollection();
			_metadata = metadata;
		}
	}
}