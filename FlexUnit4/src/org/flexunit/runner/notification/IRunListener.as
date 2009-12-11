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
package org.flexunit.runner.notification
{
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	
	/**
	 * The <code>IRunListener</code> is an interface used be classes that want to act as a run listener,
	 * responding to events that occur during a test run.  If the <code>IRunListener</code> is registered
	 * to an <code>IRunNotifier</code> it will be notified of the following eventts:
	 * 
	 * <ul>
	 * <li>A test run has started</li>
	 * <li>A test run has finished</li>
	 * <li>A test has started</li>
	 * <li>A test has finished</li>
	 * <li>A test has failed</li>
	 * <li>A test has violated an assumption</li>
	 * <li>A test has been ignored</li>
	 * </ul>
	 * <br/>
	 * 
	 * While there is generally only one <code>IRunNotifier</code> present in the system at any given time, 
	 * there can be multiple <code>IRunListener</code>s.  <code>IRunListener</code>s listen to these 
	 * messages from the <code>IRunNotifier</code> and optionally perform some action.<br/> 
	 * 
	 * Examples of some <code>IRunNotifier</code>s built into FlexUnit4 include the 
	 * <code>TraceListener</code> and <code>TextListener</code>.
	 * 
	 * @see org.flexunit.internals.TraceListener
	 * @see org.flexunit.internals.TextListener
	 */
	public interface IRunListener
	{	
		/**
		 * Called before any tests have been run and the test run is starting.
		 * 
		 * @param description The <code>IDescription</code> of the top most 
		 * <code>IRunner</code>.
		 */
		function testRunStarted( description:IDescription ):void;
		
		/**
		 * Called when all tests have finished and the test run is done.
		 * 
		 * @param result The <code>Result</code> of the test run, including all the tests 
		 * that have failed.
		 */
		function testRunFinished( result:Result ):void;
		
		/**
		 * Called when an atomic test is about to be begin.
		 * 
		 * @param description The <code>IDescription</code> of the test that is about 
		 * to be run (generally a class and method name).
		 */
		function testStarted( description:IDescription ):void;
		
		/**
		 * Called when an atomic test has finished, whether the test succeeds or fails.
		 * 
		 * @param description The <code>IDescription</code> of the test that finished.
		 */
		function testFinished( description:IDescription ):void;
		
		/** 
		 * Called when an atomic test fails.
		 * 
		 * @param failure The <code>Failure</code> indicating why the test has failed.
		 */
		function testFailure( failure:Failure ):void;
		
		/**
		 * Called when an atomic test flags that it assumes a condition that is false.
		 * 
		 * @param failure The <code>Failure</code> indicating the 
		 * <code>AssumptionViolatedException</code> that was thrown.
		 */
		function testAssumptionFailure( failure:Failure ):void;
		
		/**
		 * Called when a test will not be run, generally because a test method is annotated 
		 * with the <code>Ignore</code> tag.
		 * 
		 * @param description The <code>IDescription</code> of the test that will be
		 * ignored.
		 */
		function testIgnored( description:IDescription ):void;
	}
}