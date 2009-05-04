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
package org.flexunit.runner.notification {
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	
	/**
	 * If you write custom runners, you may need to notify FlexUnit of your progress running tests.
	 * Do this by invoking the <code>RunNotifier</code> passed to your implementation of
	 * {@link org.flexunit.runner.Runner#run(RunNotifier)}. Future evolution of this class is likely to 
	 * move {@link #fireTestRunStarted(Description)} and {@link #fireTestRunFinished(Result)}
	 * to a separate class since they should only be called once per run.
	 */
	public class RunNotifier implements IRunNotifier {
		private var listeners:Array = new Array();
		private var pleaseStopBool:Boolean = false;

		/**
		 * Do not invoke. 
		 */
		public function fireTestRunStarted( description:IDescription ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testRunStarted( description );
			}

			notifier.run();
		}

		/**
		 * Do not invoke. 
		 */
		public function fireTestRunFinished( result:Result ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testRunFinished( result );
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test is about to start.
		 * @param description the description of the atomic test (generally a class and method name)
		 * @throws StoppedByUserException thrown if a user has requested that the test run stop
		 */
		public function fireTestStarted( description:IDescription ):void {
			if (pleaseStopBool)
				throw new StoppedByUserException();

			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testStarted( description );
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test failed.
		 * @param failure the description of the test that failed and the exception thrown
		 */
		public function fireTestFailure( failure:Failure ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testFailure(failure);
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test flagged that it assumed
		 * something false.
		 * 
		 * @param failure
		 *            the description of the test that failed and the
		 *            {@link AssumptionViolatedException} thrown
		 */
		public function fireTestAssumptionFailed( failure:Failure ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testAssumptionFailure(failure);
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test was ignored.
		 * @param description the description of the ignored test
		 */
		public function fireTestIgnored( description:IDescription ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testIgnored(description);
			}

			notifier.run();
		}
		/**
		 * Invoke to tell listeners that an atomic test finished. Always invoke 
		 * {@link #fireTestFinished(Description)} if you invoke {@link #fireTestStarted(Description)} 
		 * as listeners are likely to expect them to come in pairs.
		 * @param description the description of the test that finished
		 */
		public function fireTestFinished( description:IDescription ):void {
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testFinished(description);
			}

			notifier.run();
		}

		/**
		 * Ask that the tests run stop before starting the next test. Phrased politely because
		 * the test currently running will not be interrupted. It seems a little odd to put this
		 * functionality here, but the <code>RunNotifier</code> is the only object guaranteed 
		 * to be shared amongst the many runners involved.
		 */
		public function pleaseStop():void {
			pleaseStopBool = true;
		}

		/** Internal use only
		 */
		public function addListener( listener:IRunListener ):void {
			listeners.push( listener );
		}

		/**
		 * Internal use only. The Result's listener must be first.
		 */
		public function addFirstListener( listener:IRunListener ):void {
			listeners.unshift( listener );
		}

		/** Internal use only
		 */
		public function removeListener( listener:IRunListener ):void {
			for ( var i:int=0; i<listeners.length; i++ ) {
				if ( listeners[ i ] == listener ) {
					listeners.splice( i, 1 );
					break;
				}
			}
		}

		public function RunNotifier() {
		}
	}
}

import org.flexunit.runner.notification.RunListener;
import mx.collections.ArrayCollection;
import mx.collections.IViewCursor;
import mx.collections.Sort;
import org.flexunit.runner.notification.Failure;
import org.flexunit.runner.Description;
import org.flexunit.runner.notification.RunNotifier;
import org.flexunit.runner.Result;
import org.flexunit.runner.notification.IRunNotifier;
import org.flexunit.runner.notification.IRunListener;

class SafeNotifier {
	protected var notifier:IRunNotifier;
	protected var listenerCollection:ArrayCollection;
	protected var iterator:IViewCursor;
	
	public function SafeNotifier( notifier:IRunNotifier, listeners:Array ) {
		this.notifier = notifier;
		listenerCollection = new ArrayCollection( listeners );
		iterator = listenerCollection.createCursor();
	}
	
	public function run():void {
		while ( !iterator.afterLast ) {
			try {
				notifyListener( iterator.current as IRunListener );
				iterator.moveNext();
			} catch ( e:Error ) {
				iterator.remove();
				notifier.fireTestFailure( new Failure( Description.TEST_MECHANISM, e));
			}			
		}
	}
	
	public var notifyListener:Function;
}
