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
package org.flexunit.runner.notification {
	import flash.utils.*;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	
	/** 
	 * The <code>RunNotifier</code> is a class that FlexUnit4 uses to notify registered <code>IRunListeners</code> 
	 * of an event that occurred during testing.  There is generally only one <code>RunNotifier</code>
	 * used in a test run at a time.  <code>RunNotifier</code> is used by the <code>IRunner</code> 
	 * classes to notify others of the following conditions:
	 * 
	 * <ul>
	 * <li>For the Test Run: Started/Finished</li>
	 * <li>For an Individual Test: Started/Failed/Ignored/Finished/AssumptionFailures</li>
	 * </ul><br/>
	 * 
	 * Each <code>IRunListener</code> that is to be registered or unregistered to the <code>RunNotifier</code> needs 
	 * to call either the <code>#addRunListener()</code> or the <code>#removeRunListener()</code> method.  When
	 * the <code>RunNotifier</code> encounters one of the conditions stated above, all registered 
	 * <code>IRunListeners</code> will be notified.<br/>
	 * 
	 * The <code>RunNotifier</code> also contains a <code>#pleaseStop()</code> method.  This method is responsible for
	 * halting the execution of the test run.  It seems a little odd to put this functionality in this class, but the 
	 * <code>RunNotifier</code> is the only object guaranteed to be shared amongst the many <code>IRunners</code>
	 * in the test run.<br/>
	 * 
	 * If one writes an <code>IRunner</code>, they may need to notify FlexUnit4 of their progress while 
	 * running tests.  This is accomplished by invoking the <code>IRunNotifier</code> passed to the
	 * implementation of <code>org.flexunit.runner.IRunner#run(RunNotifier)</code>.
	 * 
	 * @see org.flexunit.runner.IRunner#run()
	 * @see org.flexunit.runner.notification.IRunListener
	 */
	public class RunNotifier implements IRunNotifier {
		private var listeners:Array = new Array();
		private var pleaseStopBool:Boolean = false;
		private var startTime:Number;

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
		 * 
		 * @param description The description of the atomic test (generally a class and method name).
		 * 
		 * @throws org.flexunit.runner.notification.StoppedByUserException Thrown if a user has 
		 * requested that the test run stop.
		 */
		public function fireTestStarted( description:IDescription ):void {
			if (pleaseStopBool)
				throw new StoppedByUserException();

			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				item.testStarted( description );
			}

			notifier.run();
			
			//Capture start time
			startTime = getTimer();
		}

		/**
		 * Invoke to tell listeners that an atomic test failed.
		 * 
		 * @param failure The description of the test that failed and the exception thrown.
		 */
		public function fireTestFailure( failure:Failure ):void {
			//capture end time
			var endTime:Number = getTimer() - startTime;
			
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				if ( item is ITemporalRunListener ) {
					( item as ITemporalRunListener ).testTimed( failure.description, endTime );
				}

				item.testFailure(failure);
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test flagged that it assumed
		 * something false.
		 * 
		 * @param failure The description of the test that failed and the
		 * <code>AssumptionViolatedException</code> thrown.
		 */
		public function fireTestAssumptionFailed( failure:Failure ):void {
			//capture end time
			var endTime:Number = getTimer() - startTime;

			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				if ( item is ITemporalRunListener ) {
					( item as ITemporalRunListener ).testTimed( failure.description, endTime );
				}

				item.testAssumptionFailure(failure);
			}

			notifier.run();
		}

		/**
		 * Invoke to tell listeners that an atomic test was ignored.
		 * 
		 * @param description The description of the ignored test.
		 */
		public function fireTestIgnored( description:IDescription ):void {
			//capture end time
			var endTime:Number = getTimer() - startTime;
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				if ( item is ITemporalRunListener ) {
					( item as ITemporalRunListener ).testTimed( description, endTime );
				}

				item.testIgnored(description);
			}

			notifier.run();
		}
		/**
		 * Invoke to tell listeners that an atomic test finished. Always invoke 
		 * <code>#fireTestFinished(IDescription)</code> if you invoke <code>#fireTestStarted(Description)</code> 
		 * as listeners are likely to expect them to come in pairs.
		 * 
		 * @param description The description of the test that finished.
		 * 
		 * @see #fireTestStarted()
		 */
		public function fireTestFinished( description:IDescription ):void {
			var endTime:Number = getTimer() - startTime;
			var notifier:SafeNotifier = new SafeNotifier( this, listeners );
			
			notifier.notifyListener = function( item:IRunListener ):void {
				if ( item is ITemporalRunListener ) {
					( item as ITemporalRunListener ).testTimed( description, endTime );
				}

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

		/** 
		 * Internal use only.
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

		/** Internal use only.
		 */
		public function removeListener( listener:IRunListener ):void {
			for ( var i:int=0; i<listeners.length; i++ ) {
				if ( listeners[ i ] == listener ) {
					listeners.splice( i, 1 );
					break;
				}
			}
		}
		
		/**
		 * Constructor.
		 */
		public function RunNotifier() {
		}
	}
}

import org.flexunit.runner.Description;
import org.flexunit.runner.Result;
import org.flexunit.runner.notification.Failure;
import org.flexunit.runner.notification.IRunListener;
import org.flexunit.runner.notification.IRunNotifier;
import org.flexunit.runner.notification.RunListener;
import org.flexunit.runner.notification.RunNotifier;

class SafeNotifier {
	protected var notifier:IRunNotifier;
	protected var listeners:Array;
	
	public function SafeNotifier( notifier:IRunNotifier, listeners:Array ) {
		this.notifier = notifier;
		this.listeners = listeners;
	}
	
	/**
	 * This method attempts to notify each listener.
	 * Should a listener throw an error for any reason, it is assumed that the listener
	 * is bad and should no longer be called.  The listener will be removed and will
	 * no longer recieve any callbacks for any future notfications.  A "Test mechanism"
	 * failure will be thrown should be a listener fail.
	 * 
	 * If a listener needs to be able to throw errors and continue to recieve callbacks,
	 * it's up to the listener to use try/catch statements to handle the error.
	 **/
	public function run():void {
		for ( var i:int=0; i<listeners.length; i++ ) {
			try {
				notifyListener( listeners[ i ] as IRunListener );
			} catch ( e:Error ) {
				listeners.splice( i, 1 );
				notifier.fireTestFailure( new Failure( Description.TEST_MECHANISM, e));
				//since we have deleted, we might need to repeat
				i--;
			}			
		}
	}
	
	public var notifyListener:Function;
}
