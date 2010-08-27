/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
 *   
 **/
package org.flexunit.utils {
	import org.flexunit.runner.IDescription;

	/**
	 * This is a temporary class to work around parsing name issues with the Description when using parameterized
	 * testing. It is my hope that it can be removed and replaced with a better solution for 4.2 
	 * @author mlabriola
	 * 
	 */	
	public class DescriptionUtil {
		/**
		 *
		 * Returns a method name based on the provided description. In particular reverses the naming process of
		 * the parameterized runner. This class will be removed once description is modified for 4.2
		 *  
		 * @param description
		 * @return 
		 * 
		 */		
		public static function getMethodNameFromDescription( description:IDescription ):String {
			var spaceIndex:int = description.displayName.indexOf( " " );
			var hayStack:String;
			var lastDotIndex:int = 0;
			
			if ( spaceIndex < 0 ) {
				//This is a normal method
				hayStack = description.displayName;
			} else {
				//This is a parameterized method
				hayStack = description.displayName.substr( 0, spaceIndex );
			}
			
			lastDotIndex = hayStack.lastIndexOf( "." );
			
			if ( lastDotIndex < 0 ) {
				return "";
			}
			
			return hayStack.substr( lastDotIndex + 1 );
		}
	}
}