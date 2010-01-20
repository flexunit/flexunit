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
package org.flexunit.runners.model {
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	/**
	 * The <code>TestClass</code> wraps a class that is to be executing, providing method 
	 * validation and annotation searching.
	 */
	public class TestClass {
		/**
		 * @private
		 */
		private var klass:Class;
		/**
		 * @private
		 */
		private var _klassInfo:Klass;
		/**
		 * @private
		 */
		private var metaDataDictionary:Dictionary = new Dictionary( false );

	//TODO: I'm guessing JDK should be replaced with something else
		/**
		 * Constructor.
		 * 
		 * Creates a <code>TestClass</code> wrapping <code>klass</code>. Each time this
		 * constructor executes, the class is scanned for annotations, which can be
		 * an expensive process (we hope in future JDK's it will not be.) Therefore,
		 * try to share instances of <code>TestClass</code> where possible.
		 * 
		 * @param klass The Class to wrap.
		 */
		public function TestClass( klass:Class ) {
			this.klass = klass;
			_klassInfo = new Klass( klass );
			
			var methods:Array = _klassInfo.methods;
			var method:Method;
			
			for ( var i:int=0; i<methods.length; i++) {
				method = methods[i] as Method;
				
				addToMetaDataDictionary( new FrameworkMethod( method ) );
			}
		}
		
		/**
		 * Returns a <code>Klass</code> that was generated from the class provided to TestClass
		 */
		public function get klassInfo():Klass {
			return _klassInfo;
		}
		
		/**
		 * Registers the <code>testMethod</code> with a list of all other test methods that share
		 * the same metadata tags.
		 * 
		 * @param testMethod The <code>FrameworkMethod</code> to register with other <code>FrameworkMethod</code>s
		 * based on the <code>FrameworkMethod</code>'s metadata tags.
		 */
		private function addToMetaDataDictionary( testMethod:FrameworkMethod ):void {
			var metaDataList:Array = testMethod.metadata;
			var metaTag:MetaDataAnnotation;
			var entry:Array;
			
			//Determine if metadata exists for this FrameworkMethod
			if ( metaDataList ) {
				for ( var i:int=0; i<metaDataList.length; i++ ) {
					metaTag = metaDataList[ i ];
					
					//Determine if a specific metaTag has already been registered for another FrameworkMethod; if not,
					//create a new array to store these specific metaTags
					entry = metaDataDictionary[ metaTag.name ];
					
					if ( !entry ) {
						metaDataDictionary[ metaTag.name ] = new Array();
						entry = metaDataDictionary[ metaTag.name ]
					}
					
					var found:Boolean = false;
					//Before we push this onto the stack, we take a quick pass to ensure it is not already there
					//this covers the case where someone double flags a test with a piece of metadata
					//bugID="FXU-33")
 					for ( var j:int=0; j<entry.length; j++ ) {
						if ( ( entry[ j ] as FrameworkMethod ).method === testMethod.method ) {
							found = true;
							break;	
						}
					}
					
					if ( !found ) {
						entry.push( testMethod );
					}
				}
			}
		}
		
		/**
		 * Returns the underlying class.
		 */
		public function get asClass():Class {
			return klass;
		}

		/**
		 * Returns the class's name.
		 */
		public function get name():String {
			if (!klassInfo) {
				return "null";
			}

			return klassInfo.name;
		}

		/**
		 * Returns the metadata on this class.
		 */
		public function get metadata():Array {
			if ( !klassInfo ) {
				return null;				
			}

			return klassInfo.metadata;	
		}
		
		/**
		 * Returns, efficiently, all the non-overridden methods in this class and
		 * its superclasses that contain the metadata tag <code>metaTag</code>.
		 * 
		 * @param metaTag The tag used to locate the methods.
		 * 
		 * @return all the non-overridden methods in this class and
		 * its superclasses that contain the metadata tag <code>metaTag</code>.
		 */
		public function getMetaDataMethods( metaTag:String ):Array {
			var methodArray:Array;
			methodArray = metaDataDictionary[ metaTag ];
			
			if ( !methodArray ) {
				methodArray = new Array();
			}
			
			return methodArray;
		} 
		
		/**
		 * Returns the name of the of the class.
		 */
		public function toString():String {
			var str:String = "TestClass ";
			
			if ( _klassInfo ) {
				str += ( "(" + _klassInfo.name + ")" );
			}
			
			return str;
		}
	}
}