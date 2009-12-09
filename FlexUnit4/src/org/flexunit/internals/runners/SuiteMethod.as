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
package org.flexunit.internals.runners {
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	
	import flexunit.framework.Test;
	
	
	/**
	 * Extends FlexUnit1ClassRunner
	 * SuiteMethod adds in the testFromSuiteMethod static class that is used to create a suite method
	 * from the passed in <code>Class</code>
	 * 
	 */
	public class SuiteMethod extends FlexUnit1ClassRunner {
		/**
		 * Constructor.
		 * 
		 * @param klass
		 */
		public function SuiteMethod( klass:Class ) {
			super( testFromSuiteMethod( klass ) );
		}
	
		/**
		 * Creates a test from a method in the suite.
		 * If there is no static suite() method, then an error is thrown.
		 * 
		 * @param clazz Class that the suite method is in.
		 * @return Test - Returns a Test 
		 * 
		 * @see flexunit.framework.Test
		 */
		public static function testFromSuiteMethod( clazz:Class ):Test {
			var suiteMethod:Method = null;
			var suite:Test = null;
			var klass:Klass = new Klass( clazz );

			try {
				suiteMethod = klass.getMethod("suite");
				if ( !suiteMethod.isStatic ) {
					throw new Error( klass.name + ".suite() must be static");
				}
				suite = Test( suiteMethod.invoke(null) );
			} catch ( e:Error ) {
				throw e;
			}
			return suite;
		}
	}
}