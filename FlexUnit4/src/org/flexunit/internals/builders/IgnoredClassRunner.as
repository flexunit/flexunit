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
	
	/**
	 * An <code>IRunner</code> for test classes to be ignored
	 */
	public class IgnoredClassRunner implements IRunner {
		private var testClass:Class;
		
		/** 
		 * Constructor. 
		 * 
		 * param testClass The class to ignore
		 */ 
		public function IgnoredClassRunner( testClass:Class ) {
			this.testClass = testClass;
		}
		
		/**
		 * Instruct the notifier that a class has been ignored and update the token
		 * 
		 * @param notifier
		 * @param token 
		 */ 
		public function run( notifier:IRunNotifier, token:AsyncTestToken ):void {
			notifier.fireTestIgnored( description );
			token.sendResult();
		}
		
		/**
		 * Returns an <code>IDescription</code> of the testClass
		 */ 
		public function get description():IDescription {
			return Description.createSuiteDescription( testClass );
		}
	}
}