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
package org.flexunit.runner
{
	import flash.utils.Dictionary;
	
	/**
	 * The <code>RunnerLocator</code> is used to keep track of what runner a particular test class is using.
	 */
	public class RunnerLocator {
		
		/**
		 * @private
		 */
		private var d:Dictionary = new Dictionary( true );
		
		/**
		 * Registers the <code>runner</code> with the provided <code>test</code>.
		 * 
		 * @param test The test class used to register the <code>runner</code>.
		 * @param runner The <code>IRunner</code> to be registered.
		 */
		public function registerRunnerForTest( test:Object, runner:IRunner ):void {
			d[ test ] = runner;
		}	
		
		/**
		 * Retrieves the <code>IRunner</code> for a particular <code>test</code>.  If no runner has been 
		 * registered for the test, a <code>null</code> value is returned.
		 * 
		 * @param test The test class used to determine if there is a registered <code>IRunner</code>.
		 * 
		 * @return the <code>IRunner</code> asscoiated with that test class.
		 */
		public function getRunnerForTest( test:Object ):IRunner {
			return d[ test ] as IRunner;
		} 	

		private static var instance:RunnerLocator;

		/**
		 * Returns the single instance of the class. This is a singleton class. 
		 */		
		public static function getInstance():RunnerLocator {
			if ( !instance ) {
				instance = new RunnerLocator();
			}

			return instance;
		}
	}
}