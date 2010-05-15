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
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.internals.runners.FlexUnit1ClassRunner;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * The <code>FlexUnit1Builder</code> potentially builds a <code>FlexUnit1ClassRunner</code> for
	 * a provided testClass.  It is determined whether the testClass descends from a FlexUnit1 
	 * <code>flexunit.framework.TestCase</code> in the FlexUnit .9 library.  If it does, a 
	 * <code>FlexUnit1ClassRunner</code> is created for the test class; however, if it does not fulfill 
	 * this criteria, no <code>IRunner</code> will be generated.
	 */
	public class FlexUnit1Builder extends RunnerBuilderBase {
		
		
		
		override public function canHandleClass(testClass:Class):Boolean {
			var klassInfo:Klass = new Klass( testClass );
			
			return isPre4Test(klassInfo);
		}
		
		/**
		 * Returns a <code>FlexUnit1ClassRunner</code> if the <code>testClass</code> is a test class prior to FlexUnit4.
		 * 
		 * @param testClass The class to check.
		 * 
		 * @return a <code>FlexUnit1ClassRunner</code> if the class is a test class prior to FlexUnit4; otherwise, a
		 * value of <code>null</code> is returned.
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			return new FlexUnit1ClassRunner(testClass);
		}
		
		/**
		 * Determine if the provided <code>klassInfo</code> is a test class prior to FlexUnit4.
		 * 
		 * @param klassInfo The klass to check.
		 * 
		 * @return a Boolean value indicating whether the <code>klassInfo</code> is a test class prior to FlexUnit4.
		 */
		public function isPre4Test( klassInfo:Klass ):Boolean {
			return klassInfo.descendsFrom( flexunit.framework.TestCase );
		}		
	}
}