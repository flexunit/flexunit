/**
 * Copyright (c) 2010 Digital Primates
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
package org.flexunit.constants {
	public class AnnotationArgumentConstants {
		/**
		 * Argument constant used in the Test metadata when specifying a TestNG Style parameterized test
		 */
		public static const DATAPROVIDER:String = "dataProvider";

		/**
		 * Argument constant used in the Test, Before, After, BeforeClass and AfterClass metadata 
		 * to specify that Asynchronous functionality should be enabled for this method.
		 */
		public static const ASYNC:String = "async";
		
		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * throw an error.
		 * 
		 * This is a synonym for expected
		 */
		public static const EXPECTS:String = "expects";

		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * throw an error.
		 * 
		 * This is a synonym for expects
		 */
		public static const EXPECTED:String = "expected";
		
		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * complete within the specified timeout. 
		 * 
		 */
		public static const TIMEOUT:String = "timeout";

		/**
		 * Argument constant used in the DataPoints or Parameters metadata to indicate that 
		 * data for this parameter will be loaded asynchronously. This constant references
		 * an implementation of IExternalDataLoader as a static in the same class
		 * 
		 */
		public static const LOADER:String = "loader";
		
		/**
		 * Argument constant usable in all metadata to indicate an order of operation as
		 * compared to other metadata of the same type.
		 * 
		 */
		public static const ORDER:String = "order";
	}
}