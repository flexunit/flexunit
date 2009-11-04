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
 * @version	   0    
 **/ 
package org.flexunit.runner.notification {
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	
	/**
	 * If you write custom runners, you may need to notify FlexUnit of your progress running tests.
	 * Do this by invoking the <code>IRunNotifier</code> passed to your implementation of
	 * <code> org.flexunit.runner.Runner#run(RunNotifier)</code>. Future evolution of this class is likely to 
	 * move <code> #fireTestRunStarted(Description)</code> and <code> #fireTestRunFinished(Result)</code>
	 * to a separate class since they should only be called once per run.
	 */
	public interface IRunNotifier {
		/**
		 * Invoke to tell listeners that the test run is about to start.
		 * @param description the description of the test run
		 */
		function fireTestRunStarted( description:IDescription ):void;
		
		/**
		 * Invoke to tell listeners that the test run has finished.
		 * @param result The results of the test run.
		 */
		function fireTestRunFinished( result:Result ):void;
		
		/**
		 * Invoke to tell listeners that an atomic test is about to start.
		 * @param description the description of the atomic test (generally a class and method name)
		 */
		function fireTestStarted( description:IDescription ):void;
		
		/**
		 * Invoke to tell listeners that an atomic test failed.
		 * @param failure the description of the test that failed and the exception thrown
		 */
		function fireTestFailure( failure:Failure ):void;
		
		/**
		 * Invoke to tell listeners that an atomic test flagged that it assumed
		 * something false.
		 * 
		 * @param failure
		 *            the description of the test that failed and the
		 *            <code> AssumptionViolatedException</code> thrown
		 */
		function fireTestAssumptionFailed( failure:Failure ):void;
		
		/**
		 * Invoke to tell listeners that an atomic test was ignored.
		 * @param description the description of the ignored test
		 */
		function fireTestIgnored( description:IDescription ):void;
		
		/**
		 * Invoke to tell listeners that an atomic test finished. Always invoke 
		 * <code> #fireTestFinished(Description)</code> if you invoke <code> #fireTestStarted(Description)</code> 
		 * as listeners are likely to expect them to come in pairs.
		 * @param description the description of the test that finished
		 */
		function fireTestFinished( description:IDescription ):void;
		
		/**
		 * Adds a listener to the list of listeners in the RunNotifier
		 * 
		 * @param listener The <code>IRunListener</code> to add
		 */
		function addListener( listener:IRunListener ):void;
		
		/**
		 * Adds a listener to the begining of the list of listeners in the RunNotifier
		 * 
		 * @param listener The <code>IRunListener</code> to add
		 */
		function addFirstListener( listener:IRunListener ):void;
		
		/**
		 * Removes a listener from the list of listeners in the RunNotifier
		 * 
		 * @param listener The <code>IRunListener</code> to remove
		 */
		function removeListener( listener:IRunListener ):void;
	}
}