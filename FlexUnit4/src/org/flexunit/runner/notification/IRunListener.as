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
	 * responding to events that occur during a test run.
	 */
	public interface IRunListener
	{	
		/**
		 * Called before any tests have been run.
		 * 
		 * @param description Describes the tests to be run
		 */
		function testRunStarted( description:IDescription ):void;
		
		/**
		 * Called when all tests have finished.
		 * 
		 * @param result The summary of the test run, including all the tests that have failed.
		 */
		function testRunFinished( result:Result ):void;
		
		/**
		 * Called when an atomic test is about to be started.
		 * 
		 * @param description The description of the test that is about to be run 
		 * (generally a class and method name).
		 */
		function testStarted( description:IDescription ):void;
		
		/**
		 * Called when an atomic test has finished, whether the test succeeds or fails.
		 * 
		 * @param description The description of the test that just ran.
		 */
		function testFinished( description:IDescription ):void;
		
		/** 
		 * Called when an atomic test fails.
		 * 
		 * @param failure Describes the test that failed and the exception that was thrown.
		 */
		function testFailure( failure:Failure ):void;
		
		/**
		 * Called when an atomic test flags that it assumes a condition that is
		 * false.
		 * 
		 * @param failure Describes the test that failed and the 
		 * <code>AssumptionViolatedException</code> that was thrown.
		 */
		function testAssumptionFailure( failure:Failure ):void;
		
		/**
		 * Called when a test will not be run, generally because a test method is annotated 
		 * with <code>Ignore</code>.
		 * 
		 * @param description Describes the test that will not be run.
		 */
		function testIgnored( description:IDescription ):void;
	}
}