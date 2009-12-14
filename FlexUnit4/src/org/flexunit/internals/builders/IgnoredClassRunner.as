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
package org.flexunit.internals.builders {
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.IAsyncTestToken;
	
	/**
	 * The <code>IgnoredClassRunner</code> is an <code>IRunner</code> for test classes that are 
	 * to be ignored.  The runner will not run any tests in the provided test class.  Instead,
	 * it will report that the class has been ignored, providing information about that tests that
	 * are present in the ignored testClass.
	 */
	public class IgnoredClassRunner implements IRunner {
		/**
		 * @private
		 */
		private var testClass:Class;
		
		/** 
		 * Constructor. 
		 * 
		 * param testClass The class that is to be ignored.
		 */ 
		public function IgnoredClassRunner( testClass:Class ) {
			this.testClass = testClass;
		}
		
		/**
		 * Instructs the <code>notifier</code> that a class has been ignored, indiciating how many
		 * tests have been ignored in the process.  The provided <code>token</code> is then notified
		 * that the <code>IgnoredClassRunner</code> has finished.
		 * 
		 * @param notifier The <code>IRunNotifier</code> to notify that the class has been ignored.
		 * @param token The <code>AsyncTestToken</code> to notify that the test class has been ignored.
		 */ 
		public function run( notifier:IRunNotifier, previousToken:IAsyncTestToken ):void {
			notifier.fireTestIgnored( description );
			previousToken.sendResult();
		}
		
		/**
		 * Returns an <code>IDescription</code> of the testClass.  This <code>IDescription</code>
		 * is used to provide information about this testClass that can be used in order to determine
		 * how many tests have been ignored.
		 */ 
		public function get description():IDescription {
			return Description.createSuiteDescription( testClass );
		}
	}
}