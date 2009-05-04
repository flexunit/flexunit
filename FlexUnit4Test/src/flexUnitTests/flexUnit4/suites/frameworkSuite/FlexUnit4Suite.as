/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/ 
package flexUnitTests.flexUnit4.suites.frameworkSuite
{
	import flexUnitTests.flexUnit1.framework.AllFrameworkTests;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestASComponentUse;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestAssert;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestAsynchronous;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestAsynchronousSetUpTearDown;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBeforeAfterClassOrder;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBeforeAfterClassOrderAsync;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBeforeAfterOrder;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBeforeAfterOrderAsync;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestBindingUse;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestIgnore;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestMXMLComponentUse;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestMethodOrder;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.TestSynchronousSetUpTearDown;
	import flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite.TheorySuite;
	import flexUnitTests.hamcrest.HamcrestSuite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
    /**
     * @private
     */
	public class FlexUnit4Suite {
		public var testAssert:TestAssert;
		public var testIgnore:TestIgnore;
		public var testMethodOrder:TestMethodOrder;
		public var testBeforeAfterOrder:TestBeforeAfterOrder;
		public var testBeforeAfterClassOrder:TestBeforeAfterClassOrder;
		public var testBeforeAfterOrderAsync:TestBeforeAfterOrderAsync;
		public var testBeforeAfterClassOrderAsync:TestBeforeAfterClassOrderAsync;
		public var testAsynchronous:TestAsynchronous;
		public var testSynchronousSetUpTearDown:TestSynchronousSetUpTearDown;
		public var testAsynchronousSetUpTearDown:TestAsynchronousSetUpTearDown;
		public var testASComponentUse:TestASComponentUse;
		public var testMXMLComponentUse:TestMXMLComponentUse;
		public var testBindingUse:TestBindingUse;
		public var theory:TheorySuite;
		
		public var hamcrest:HamcrestSuite;
		public var flexUnit1Tests:AllFrameworkTests;
	}
}