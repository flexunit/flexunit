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
package org.flexunit.runners.model {
	import org.flexunit.runner.IRunner;
	
	/**
	 * An <code>IRunnerBuilder</code> is a strategy for constructing <code>IRunner</code>s for classes.<br/>
	 * 
	 * Only writers of custom runners should use <code>IRunnerBuilder</code>s.  A custom runner class with a constructor 
	 * taking an <code>IRunnerBuilder</code> parameter will be passed the instance of <code>IRunnerBuilder</code> used 
	 * to build that runner itself.<br/>
	 *  
	 * For example, imagine a custom <code>IRunner</code> that builds suites based on a list of classes in a text file:
	 * 
	 * <pre>
	 * RunWith(TextFileSuite.as)
	 * SuiteSpecFile("mysuite.txt")
	 * class MySuite {}
	 * </pre>
	 * 
	 * The implementation of TextFileSuite might include:
	 * 
	 * <pre>
	 * public function TextFileSuite(testClass:Class, builder:IRunnerBuilder) {
	 *   // ...
	 *     var runner:IRunner = builder.runnerForClass( testClass );
	 *   // ...
	 * }
	 * </pre>
	 * 
	 * @see org.flexunit.runners.Suite
	 */
	public interface IRunnerBuilder {
		
		/**
		 * Returns a boolean value indicating if this builder will be able to handle the testClass or not
		 * 
		 * @param testClass The class to test to determine an <code>IRunner</code>.
		*/
		function canHandleClass( testClass:Class):Boolean;
		
		/**
		 * Returns an <code>IRunner</code> that can safely run the provided <code>testClass</code>.
		 * 
		 * @param testClass The class to for which to determine an <code>IRunner</code>.
		 * 
		 * @return an <code>IRunner</code> that can run the <code>testClass</code>.
		 */
		function safeRunnerForClass( testClass:Class ):IRunner;
		/**
		 * Constructs and returns a list of <code>IRunner</code>s, one for each child class in
		 * <code>children</code>.  Care is taken to avoid infinite recursion:
		 * this builder will throw an exception if it is requested for another
		 * runner for <code>parent</code> before this call completes.
		 * 
		 * @param parent The parent class that contains the <code>children</code>.
		 * @param children The child classes for which to find <code>IRunner</code>.
		 * 
		 * @return a list of <code>IRunner</code>s, one for each child class.
		 */
		function runners( parent:Class, children:Array ):Array;
		/**
		 * Returns an <code>IRunner</code> for a specific <code>testClass</code>.
		 * 
		 * @param testClass The test class for which to determine an <code>IRunner</code>.
		 * 
		 * @return an <code>IRunner</code> that will run the <code>testClass</code>.
		 */
		function runnerForClass( testClass:Class ):IRunner;
	}
}