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
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.IAsyncTestToken;
	
	/**
	 * An <code>IRunner</code> runs tests and notifies a <code> org.flexunit.runner.notification.RunNotifier</code>
	 * of significant events as it does so. You will need to subclass <code>Runner</code>
	 * to invoke a custom runner. When creating a custom runner, 
	 * in addition to implementing the abstract methods here you must
	 * also provide a constructor that takes as an argument the <code> Class</code> containing
	 * the tests.
	 * <br/>
	 * The default runner implementation guarantees that the instances of the test case
	 * class will be constructed immediately before running the test and that the runner
	 * will retain no reference to the test case instances, generally making them 
	 * available for garbage collection.
	 * 
	 * @see org.flexunit.runner.Description
	 */
	public interface IRunner
	{
		
		/**
		 * Run the tests for this runner.
		 * 
		 * @param notifier will be notified of events while tests are being run--tests being 
		 * started, finishing, and failing
		 */
		function run( notifier:IRunNotifier, previousToken:IAsyncTestToken ):void;
		function get description():IDescription;
	}
}