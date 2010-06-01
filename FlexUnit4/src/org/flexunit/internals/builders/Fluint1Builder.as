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
	import flash.utils.*;
	
	import flex.lang.reflect.Klass;
	
	import net.digitalprimates.fluint.tests.TestCase;
	import net.digitalprimates.fluint.tests.TestSuite;
	
	import org.flexunit.internals.runners.Fluint1ClassRunner;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * The <code>Fluint1Builder</code> potentially builds a <code>Fluint1ClassRunner</code> for
	 * a provided testClass.  It is determined whether the testClass is a Fluint suite or test case.
	 * It accomplishes this by determining whether the given testClass descends from 
	 * <code>net.digitalprimates.fluint.tests.TestCase</code> or 
	 * <code>net.digitalprimates.fluint.tests.TestSuite</code> in the Fluint (presently 1.2) library.
	 * If this is the case, a <code>Fluint1ClassRunner</code> is created for the test class; however, 
	 * if it does not fulfill this criteria, no <code>IRunner</code> will be generated.
	 */
	public class Fluint1Builder extends RunnerBuilderBase {

		
		override public function canHandleClass(testClass:Class):Boolean {
			var klassInfo:Klass = new Klass( testClass );
			return isFluintSuiteOrCase(klassInfo);
		}
		
		/**
		 * Returns a <code>Fluint1ClassRunner</code> if the <code>testClass</code> is a Fluint suite or test case.
		 * 
		 * @param testClass The class to check.
		 * 
		 * @return a <code>Fluint1ClassRunner</code> if the <code>testClass</code> is a Fluint suite or test case; 
		 * otherwise, a value of <code>null</code> is returned.
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			return new Fluint1ClassRunner(testClass);
		}
		
		/**
		 * Determine if the provided <code>klassInfo</code> is a Fluint suite or test case.
		 * 
		 * @param klassInfo The klass to check.
		 * 
		 * @return a Boolean value indicating whether the <code>klassInfo</code> is a Fluint suite or test case.
		 */
		public function isFluintSuiteOrCase( klassInfo:Klass ):Boolean {
 			var testCase:Boolean = klassInfo.descendsFrom( net.digitalprimates.fluint.tests.TestCase );
			var testSuite:Boolean = klassInfo.descendsFrom( net.digitalprimates.fluint.tests.TestSuite );
			return ( testCase || testSuite );  
		}		
	}
}