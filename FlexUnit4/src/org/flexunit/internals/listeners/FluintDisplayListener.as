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
package org.flexunit.internals.listeners
{
	import mx.collections.ArrayCollection;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;
	
	/**
	 * Extends RunListender. It defines testFinished, testIgnored, testAssumptionFailure, and testFailure.
	 * The other overrides currently override already empty methods.
	 * 
	 */
	public class FluintDisplayListener extends RunListener
	{
		
		private var lastFailedTest:IDescription;
		
		[Bindable]
		/**
		 * testResults is used to hold the results of the tests.
		 * It is bindable so that it can be used as a data provider for views. 
		 */
		public var testResults:ArrayCollection = new ArrayCollection();
		 
		/**
		 * @inheritDoc 
		 */
		override public function testRunStarted( description:IDescription ):void{
			
		}

		/**
		 * @inheritDoc 
		 */
		override public function testRunFinished( result:Result ):void {
			
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function testStarted( description:IDescription ):void {
		}
	
		/**
		 * Adds the results of the test to the <code>testResults</code> ArrayCollection.
		 * @inheritDoc 
		 */
		override public function testFinished( description:IDescription ):void {
			
		//	if(description.displayName != lastFailedTest.displayName){
				testResults.addItem(description);
		//	}
		}
		
		override public function testIgnored( description:IDescription ):void {
			testResults.addItem(description);
		}
		override public function testAssumptionFailure( failure:Failure ):void {
			testResults.addItem(failure);
		}
	
		override public function testFailure( failure:Failure ):void {
			lastFailedTest = failure.description;
			testResults.addItem(failure);
			
		}
	}
}