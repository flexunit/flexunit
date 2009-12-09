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
package org.flexunit.internals.runners.model {
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunNotifier;
	
	/**
	 * The <code>EachTestNotifier</code> is responsible for instructing a provided
	 * <code>IRunNotifier</code> about the execution of a specific test.  The 
	 * <code>EachTestNotifier</code> is provided with an <code>IRunNotifier</code>
	 * and a corresponding <code>IDescription</code> of the test that is to be
	 * executed.  It will report to the <code>IRunNotifier</code> as it is notified
	 * about the execution of the test, providing the necessary description or failure
	 * to the <code>IRunNotifier</code>.
	 */
	public class EachTestNotifier {
		/**
		 * @private
		 */
		private var notifier:IRunNotifier;
		/**
		 * @private
		 */
		private var description:IDescription;
		
		/** 
		 * Constructor. 
		 * 
		 * @param notifier The <code>IRunNotifier</code> to notify regarding the execution of a specific test.
		 * @param description An <code>IDescription</code> of the current test.
		 */
		public function EachTestNotifier( notifier:IRunNotifier, description:IDescription ) {
			this.notifier = notifier;
			this.description = description;
		}
		
		/** 
		 * Instructs the notifier that the test method has encountered a failure.
		 * 
		 * @param targetException The exception that was thrown when running the test method.
		 */
		public function addFailure( targetException:Error ):void {
			//If the targetException is a MultipleFailureException, notify the notifier for each failure
			if (targetException is MultipleFailureException) {
				var  mfe:MultipleFailureException = MultipleFailureException( targetException );
				var failures:Array = mfe.failures;
				for ( var i:int=0; i<failures.length; i++ ) {
					addFailure( failures[ i ] );
				}
				return;
			}
			notifier.fireTestFailure(new Failure( description, targetException));
		}

		//TODO: THis needs to be an AssumptionViolatedException... but I need to get Hamcrest in there for that...so it needs to wait
		/** 
		 * Instructs the notifier that the test method has failed an assumption.
		 * 
		 * @param error The assumption that was violated when running the test method.
		 */
		public function addFailedAssumption( error:Error ):void {
			notifier.fireTestAssumptionFailed( new Failure( description, error ) );
		}
		
		/** 
		 * Instructs the notifier that the test method has finished running.
		 */
		public function fireTestFinished():void {
			notifier.fireTestFinished(description);
		}
		
		/** 
		 * Instructs the notifier that the test method has started.
		 */
		public function fireTestStarted():void {
			notifier.fireTestStarted(description);
		}
	
		/** 
		 * Instructs the notifier that the test method has been ignored.
		 */
		public function fireTestIgnored():void {
			notifier.fireTestIgnored(description);
		}
	}
}