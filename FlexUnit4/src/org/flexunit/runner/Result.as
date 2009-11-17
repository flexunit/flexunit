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
package org.flexunit.runner {
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.runner.notification.RunListener;
	
	use namespace classInternal;

	/**
	 * A <code>Result</code> collects and summarizes information from running multiple
	 * tests. Since tests are expected to run correctly, successful tests are only noted in
	 * the count of tests that ran.
	 */
	public class Result {
		/**
		 * The number of tests run.
		 */
		classInternal var _runCount:int = 0;
		/**
		 * The number of tests ignored.
		 */
		classInternal var _ignoreCount:int = 0;
		/**
		 * The number of milliseconds it took to run the entire set of tests.
		 */
		classInternal var _runTime:Number = 0;
		/**
		 * The time when the test run started.
		 */
		classInternal var _startTime:Number;
		
		/**
		 * @private
		 */
		private var _failures:Array = new Array()
		
		/**
		 * Returns the number of tests that failed over the course of the run.
		 */
		public function get failureCount():int {
			return failures.length;
		}

		/**
		 * Returns the <code>Failure</code>s describing tests that failed and the problems they encountered.
		 */
		public function get failures():Array {
			return _failures;
		}

		/**
		 * Returns the number of tests ignored over the course of the run.
		 */
		public function get ignoreCount():int {
			return _ignoreCount;
		}

		/**
		 * Returns the number of tests that have run.
		 */
		public function get runCount():int {
			return _runCount;
		}

		/**
		 * Returns the number of milliseconds it took to run the entire set of tests.
		 */
		public function get runTime():Number {
			return _runTime;
		}

		/**
		 * Returns a Boolean value of <code>true</code> if all tests succeeded.
		 */
		public function get successful():Boolean {
			return ( failureCount == 0 );
		}
		
		/**
		 * Internal use only.
		 */
		public function createListener():RunListener {
			var listener:Listener = new Listener();;
			listener.result = this;
			return listener;
		}
		
		/**
		 * Constructor.
		 */
		public function Result() {
		}
	}
}

import flash.utils.getTimer;
import org.flexunit.runner.notification.RunListener;
import org.flexunit.runner.Description;
import org.flexunit.runner.Result;
import org.flexunit.runner.notification.Failure;
import org.flexunit.internals.namespaces.classInternal;
import org.flexunit.runner.IDescription;

use namespace classInternal;

class Listener extends RunListener {
	protected var ignoreDuringExecution:Boolean = false;
	
	override public function testRunStarted( description:IDescription ):void {
		result._startTime = getTimer();
	}

	override public function testRunFinished( result:Result ):void {
		var endTime:Number = getTimer();
		result._runTime += endTime - result._startTime;
	}

	override public function testFinished( description:IDescription ):void {
		if (!ignoreDuringExecution) {
			result._runCount++;
		}
		
		ignoreDuringExecution = false;
	}

	override public function testFailure( failure:Failure ):void {
		result.failures.push( failure );
	}

	override public function testIgnored( description:IDescription ):void {
		result._ignoreCount++;
		ignoreDuringExecution = false;
	}
}