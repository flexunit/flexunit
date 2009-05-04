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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.runners.model {
	import org.flexunit.runner.IRunner;
	
	/**
	 * An IRunnerBuilder is a strategy for constructing IRunners for classes. 
	 * 
	 * Only writers of custom runners should use <code>IRunnerBuilder</code>s.  A custom runner class with a constructor taking
	 * an <code>IRunnerBuilder</code> parameter will be passed the instance of <code>IRunnerBuilder</code> used to build that runner itself.  
	 * For example,
	 * imagine a custom IRunner that builds suites based on a list of classes in a text file:
	 * 
	 * <pre>
	 * \@RunWith(TextFileSuite.class)
	 * \@SuiteSpecFile("mysuite.txt")
	 * class MySuite {}
	 * </pre>
	 * 
	 * The implementation of TextFileSuite might include:
	 * 
	 * <pre>
	 * public TextFileSuite(Class testClass, IRunnerBuilder builder) {
	 *   // ...
	 *   for (String className : readClassNames())
	 *     addRunner(builder.runnerForClass(Class.forName(className)));
	 *   // ...
	 * }
	 * </pre>
	 * 
	 * @see org.flexunit.runners.Suite
	 */
	public interface IRunnerBuilder {
		function safeRunnerForClass( testClass:Class ):IRunner;
		function runners( parent:Class, children:Array ):Array;
		function runnerForClass( testClass:Class ):IRunner;
	}
}