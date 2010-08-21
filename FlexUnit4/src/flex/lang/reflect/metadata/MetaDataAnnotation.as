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

	/**
	 * An object representing an annotation represented as a metadata tag, in the example 
	 * [Test(arg="1")] Test is the annotation. You can interrogate the annotation's name and
	 * arguments. 
	 */
	public class MetaDataAnnotation {
		/**
		 * @private
		 */
		private var metaData:XML;
		/**
		 * @private
		 */
		private var _name:String;
		/**
		 * @private
		 */
		private var _arguments:Array;

		/**
		 * Getter for retrieving the metadata annotation name.
		 * 
		 * Given the following example
		 * 
		 * [Test(async='true',expects="TypeError")]
		 * 
		 * Test is the annotation name. 
		 * 
		 * @return The annotation name as a String
		 * 
		 */
		public function get name():String {
			return _name;
		}
		
		/**
		 * Getter for retrieving an array of arguments specified for the metadata annotation.
		 * 
		 * Given the following example
		 * 
		 * [Test(async="true",expects="TypeError")]
		 * 
		 * async="true" and expects="TypeError" are the arguments
		 * 
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
		 * Returns the first unpaired argument of an annotation.
		 * 
		 * Given the following example
		 * 
		 * [RunWith("org.flexunit.runners.Suite",order="1")]
		 * 
		 * The default argument would be "org.flexunit.runners.Suite". This is often used
		 * with MetaData such as RunWith which expects to have a default value. 
		 * 
		 * @return A MetaDataArgument instance.
		 */
		public function get defaultArgument():MetaDataArgument {
			var firstArg:MetaDataArgument;
			var arg:MetaDataArgument;
			var argLen:uint = 0;

			//You must keep the this when referring to arguments here
			//or actionscript thinks you mean unknown arguments being passed
			//to the function
			if ( this.arguments ) {
				argLen = this.arguments.length;
				for ( var i:uint=0; i<argLen; i++ ) {
					arg = this.arguments[ i ] as MetaDataArgument;
					
					if ( arg.unpaired ) {
						firstArg = arg;
						break;
					} 
				}
			}
			
			return firstArg;
		}
		
		/**
		 * Checks for the existance of a given argument within this annotation using the argument's key
		 * 
		 * @param key An argument key
		 * @param caseInsensitive default false, if set to true, then the key is matched in a case insensitive manner.
		 * @return Returns true if the key exists, false if it does not.
		 * 
		 * @see #getArgument()
		 */
		public function hasArgument( key:String, caseInsensitive:Boolean = false ):Boolean {
			return ( getArgument( key, caseInsensitive ) != null );
		}
		
		/**
		 * Returns the MetaDataArgument associated with a given argument using the argument's key
		 *  
		 * @param key An argument key
		 * @param caseInsensitive default false, if set to true, then the key is matched in a case insensitive manner.
		 * @return the MetaDataArgument instance for the argument key, or null if it was not found.
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

				if ( hayStackKey == needleKey ) {
					return this.arguments[ i ];
				}
			}	
			
			return null;
		}

		/**
		 * Builds an array of MetaDataArguments from metadata nodes
		 * 
		 * @return Returns an array containing MetaDataArgument instances. 
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
		 * Parses <metadata/> nodes returned from a call to <code>describeType</code> to provide an 
		 * object wrapper for annotations
		 * 
		 * Expected format of the argument is
		 * 		<metadata name="metaDataParam">
		 * 			<arg key="someKey" value="someValue"/>
		 * 			<arg key="someKey" value="someValue"/>
		 * 		</metadata>
		 * 
		 * @param A <metadata/> XML node.
		 * 
		 */
		public function MetaDataAnnotation( metaDataXML:XML ) {
			if ( !metaDataXML ) {
				throw new ArgumentError("Valid XML must be provided to MetaDataAnnotation Constructor");
			}
			
			this.metaData = metaDataXML;
			_name = metaDataXML.@name;
		}
	}
}