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
package org.flexunit.internals.requests {
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.Request;
	
	use namespace classInternal;
	
	/**
	 * A <code>Request</code> that is used to determine what runner to use to run a specific test class.
	 */
	public class ClassRequest extends Request {
		/**
		 * @private
		 */
		private var testClass:Class;
		/**
		 * @private
		 */
		private var canUseSuiteMethod:Boolean;
		
		/**
		 * Constructor.
		 * 
		 * @param testClass The test class that will be used in determining the runner.
		 * @param canUseSuiteMethod A Boolean value indicating whether the user can use a <code>SuiteMethod</code>.
		 */
		public function ClassRequest( testClass:Class, canUseSuiteMethod:Boolean=true ) {
			this.testClass= testClass;
			this.canUseSuiteMethod= canUseSuiteMethod;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get iRunner():IRunner {
			return new AllDefaultPossibilitiesBuilder(canUseSuiteMethod).safeRunnerForClass(testClass);
		}
	}
}