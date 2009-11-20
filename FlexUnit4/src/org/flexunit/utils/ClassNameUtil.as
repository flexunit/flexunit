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
	 * The <code>ClassNameUtil</code> is responsible for assisting in the formatting of class names.
	 */
	public class ClassNameUtil {
		import flash.utils.getQualifiedClassName;

		/**
		 * Returns a logger friendly class name for the provided <code>instance</code>.  The
		 * normal qualified class name will have all "::" and "." replaced with underscores.
		 * 
		 * @param instance The Object for which to obtain a logger friendly class name.
		 * 
		 * @return a qualified path name with all "::" and "." replaced with underscores.
		 */
		public static function getLoggerFriendlyClassName( instance:Object ):String {
			var periodReplace:RegExp = /\./g;
			var colonReplace:RegExp = /::/g;

			var fullname:String = getQualifiedClassName( instance );
			fullname = fullname.replace( periodReplace, "_" );
			fullname = fullname.replace( colonReplace, "_" );

			return fullname;
		}
		
		/**
		 * Constructor.
		 */
		public function ClassNameUtil() {
		}
	}
}