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
package flex.lang.reflect.metadata {
	public class MetaDataAnnotation {
		private var metaData:XML;
		private var _name:String;
		private var _arguments:Array;

		/**
		 * Getter for retrieving the metadata annotation (e.g. Test, Before, AfterClass) 
		 * @return The annotation as a String
		 * 
		 */
		public function get name():String {
			return _name;
		}
		
		/**
		 * Getter for retrieving the list of arguments for the metadata annotation.
		 * @return An array of <code>MetaDataArgument</code> objects.
		 * 
		 */
		public function get arguments():Array {
			if ( !_arguments ) {
				_arguments = buildArguments();
			}

			return _arguments;
		}
		
		/**
		 * Returns the first argument of an annotation.
		 * Used for annotations such as RunWith.
		 * This will change to getting the first argument with a key but no value later,
		 * to prevent some issues when there can be more than one argument and the empty value one is not put first. 
		 * @return A MetaDataArgument.
		 */
		public function get defaultArgument():MetaDataArgument {
			var firstArg:MetaDataArgument;

			if ( this.arguments && this.arguments.length > 0 ) {
				firstArg = this.arguments[ 0 ];	
			}
			
			return firstArg;
		}
		
		/**
		 * Given a key, checks the arguments of an annotation to see if the key exists for that annotation.
		 * Uses getArgument to find the key.
		 * 
		 * @param key The String value of the argument being looked for on an annotation.
		 * @return Returns a boolean True if the key exists, False if it does not.
		 * @see #getArgument()
		 */
		public function hasArgument( key:String ):Boolean {
			return ( getArgument( key ) != null );
		}
		
		/**
		 * Given a key, returns the MetaDataArgument with that key, if it exists, or null if it does not.
		 *  
		 * @param key The string version of the MetaDataArgument that is being looked for. e.g. order.
		 * @param caseInsensitive default False, if set to true, then the key is looked for without regard to case.
		 * @return Returns the full MetaDataArgument object for the found key, or null if it was not found.
		 * 
		 */
		public function getArgument( key:String, caseInsensitive:Boolean = false ):MetaDataArgument {
			var argsLen:int = this.arguments.length;
			var needleKey:String = key;
			
			if ( caseInsensitive && key ) {
				needleKey = needleKey.toLowerCase();
			}

			for ( var i:int=0; i<argsLen; i++ ) {
				var hayStackKey:String = ( this.arguments[ i ] as MetaDataArgument ).key;
				
				if ( caseInsensitive && hayStackKey ) {
					hayStackKey = hayStackKey.toLowerCase();
				}

				if ( ( this.arguments[ i ] as MetaDataArgument ).key == key ) {
					return this.arguments[ i ];
				}
			}	
			
			return null;
		}

		/**
		 * Builds the MetaDataArgument objects that were passed into the constructor as XML.
		 * 
		 * @return Returns an array, with MetaDataArgument objects inside. 
		 * 
		 */
		protected function buildArguments():Array {
			var arguments:Array = new Array();
			var args:XMLList = metaData.arg;

			if ( args && args.length() ) {
				for ( var i:int=0; i<args.length(); i++ ) {
					arguments.push( new MetaDataArgument( args[ i ] ) );
				}
			}
			
			return arguments;
		}

		/**
		 * Compares two MetaDataAnnotations for name and argument equality
		 * 
		 * @return Returns boolean indicating equality
		 * 
		 */
		public function equals( item:MetaDataAnnotation ):Boolean {
			if ( !item ) {
				return false;
			}

			var equiv:Boolean = this.name == item.name;
			var localArgs:Array = this.arguments;
			var remoteArgs:Array = item.arguments;

			if ( equiv ) {
				var localLen:int = localArgs?localArgs.length:0;
				var remoteLen:int = remoteArgs?remoteArgs.length:0;
				
				if ( localLen != remoteLen ) {
					return false;
				}
				
				if ( localLen > 0) {
					for ( var i:int=0; i<localLen; i++ ) {
						var localArg:MetaDataArgument = localArgs[ i ];
						var remoteArg:MetaDataArgument = remoteArgs[ i ];
						
						equiv = localArg.equals( remoteArg );
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
		 * @param metaDataXML The metaDataXML that is passed to the class to be parsed to find
		 * 						the annotation and arguments for a piece of metadata.
		 * 
		 */
		public function MetaDataAnnotation( metaDataXML:XML ) {
			this.metaData = metaDataXML;
			_name = metaDataXML.@name;
		}
	}
}