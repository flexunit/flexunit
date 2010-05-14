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
package org.flexunit.runner.notification {
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	
	/**
	 * If you need to respond to the events during a test run, extend <code>RunListener</code>
	 * and override the appropriate methods. If a listener throws an exception while processing a 
	 * test event, it will be removed for the remainder of the test run.
	 * 
	 * <p>
	 * For example, suppose you have a <code>Cowbell</code>
	 * class that you want to make a noise whenever a test fails. You could write:
	 * <pre>
	 * public class RingingListener extends RunListener {
	 * 	public function testFailure(failure:Failure):void {
	 * 		Cowbell.ring();
	 * 	}
	 * }
	 * </pre>
	 * </p>
	 * 
	 * <p>To invoke your listener, you need to run your tests through <code>FlexUnitCore</code>.
	 * <pre>
	 * core:FlexUnitCore = new FlexUnitCore();
	 * core.addListener(new RingingListener());
	 * core.run(MyTestClass);
	 * </pre></p>
	 * 
	 * @see org.flexunit.runner.FlexUnitCore
	 */
	public class RunListener implements IRunListener {
		/**
		 * The <code>Result</code> recieved for a finished test run.
		 */
		public var result:Result;

		/**
		 * Called before any tests have been run.
		 * @param description describes the tests to be run
		 */
		public function testRunStarted( description:IDescription ):void {
		}
		
		/**
		 * Called when all tests have finished
		 * @param result the summary of the test run, including all the tests that failed
		 */
		public function testRunFinished( result:Result ):void {
			this.result = result;
		}
		
		/**
		 * Called when an atomic test is about to be started.
		 * @param description the description of the test that is about to be run 
		 * (generally a class and method name)
		 */
		public function testStarted( description:IDescription ):void {
		}
	
		/**
		 * Called when an atomic test has finished, whether the test succeeds or fails.
		 * @param description the description of the test that just ran
		 */
		public function testFinished( description:IDescription ):void {
		}
	
		/** 
		 * Called when an atomic test fails.
		 * @param failure describes the test that failed and the exception that was thrown
		 */
		public function testFailure( failure:Failure ):void {
		}
	
		/**
		 * Called when an atomic test flags that it assumes a condition that is
		 * false
		 * 
		 * @param failure
		 *            describes the test that failed and the
		 *            <code> AssumptionViolatedException</code> that was thrown
		 */
		public function testAssumptionFailure( failure:Failure ):void {
		}
	
		/**
		 * Called when a test will not be run, generally because a test method is annotated 
		 * with <code> org.junit.Ignore</code>.
		 * 
		 * @param description describes the test that will not be run
		 */
		public function testIgnored( description:IDescription ):void {
		}
	}
}