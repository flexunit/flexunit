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
	 * An object representing an argument of a metadata tag, in the example [Test(arg="1")]
	 * arg="1" is the argument. You can interrogate the arguments key and value. 
	 */
	public class MetaDataArgument {
		/**
		 * @private
		 */
		private var argument:XML;
		/**
		 * @private
		 */
		private var _key:String;
		/**
		 * @private
		 */
		private var _value:String;

		/**
		 * @private
		 */
		private var _unpaired:Boolean = false;
		
		/**
		 * Retrieves the key of an argument. Read Only. (The name of a name/value pair.)
		 * @return 
		 * 
		 */
		public function get key():String {
			return _key;
		}
		
		/**
		 * Retrieves the value portion of an argument. Read Only. (The value of a name/value pair.)
		 * 
		 * @return Returns the string of the value of the argument.
		 * 
		 */
		public function get value():String {
			return _value;
		}

		/**
		 * Indicates if the argument is unpaired. Given the following example:
		 * 
		 * [RunWith("org.flexunit.runners.Suite",order=1)]
		 * 
		 * order="1" is a paired argument where as "org.flexunit.runners.Suite" is unpaired. 
		 * 
		 * @return true if unpaired
		 * 
		 */
		public function get unpaired():Boolean {
			return _unpaired;
		}

		/**
		 * Compares two MetaDataArguments for key and value equality
		 * 
		 * @return Returns boolean indicating equality
		 * 
		 */
		public function equals( item:MetaDataArgument ):Boolean {
			return ( this.key == item.key && this.value == item.value );
		}

		/**
		 * Constructor
		 * Parses <arg/> nodes returned from a call to <code>describeType</code> to provide an object wrapper. 
		 * Expected format of the argument is
		 * 
		 * <arg key="someKey" value="someValue"/>
		 * 
		 * @param An <arg/> XML node.
		 * 
		 */
		public function MetaDataArgument( argumentXML:XML ) {

			if ( !argumentXML ) {
				throw new ArgumentError("Valid XML must be provided to MetaDataArgument Constructor");
			}

			this.argument = argumentXML;

			var potentialKey:String = argument.@key;
			_value = argument.@value;

			if ( potentialKey && potentialKey.length>0 ) {
				_key = potentialKey;
			} else if ( _value && _value.length>0 ){
				_unpaired = true;
				_key = _value;
				_value = "true";
			} else {
				_key = argument.@key;
			}
		}
	}
}
