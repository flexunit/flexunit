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
package org.flexunit.utils {
	/**
	 * Contains static methods to assist in class naming
	 */
	public class ClassNameUtil {
		import flash.utils.getQualifiedClassName;

		/**
		 * Converts all "." into "_" and concerts all "::" into "_" in contained in
		 * the class name
		 * 
		 * <p>
		 * @param instance Instance of the object of which to retrieve a name.
		 * <p>
		 * @return The modified class name
		 */
		public static function getLoggerFriendlyClassName( instance:Object ):String {
			var periodReplace:RegExp = /\./g;
			var colonReplace:RegExp = /::/g;

			var fullname:String = getQualifiedClassName( instance );
			fullname = fullname.replace( periodReplace, "_" );
			fullname = fullname.replace( colonReplace, "_" );

			return fullname;
		}

		public function ClassNameUtil() {
		}
	}
}