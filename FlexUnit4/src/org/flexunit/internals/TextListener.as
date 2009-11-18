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
package org.flexunit.internals {
	import mx.formatters.NumberFormatter;
	import mx.logging.ILogger;
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	
	import org.flexunit.reporting.FailureFormatter;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;
	
	/**
	 * A <code>TextListener</code> will record the events encountered during the course of a test run in a logger.
	 */
	public class TextListener extends RunListener {
		/**
		 * @private
		 */
		private var logger:ILogger;
		/**
		 * @private
		 */
		private static var nf:NumberFormatter;
		
		/**
		 * Creates an <code>ILoggingTarget</code>
		 * 
		 * @param level The level to set on the <code>ILoggingTarget</code>
		 * 
		 * @return an <code>ILoggingTarget</code>
		 */
		protected static function buildILoggingTarget( level:int ):ILoggingTarget {
			var traceTarget:TraceTarget = new TraceTarget();
			traceTarget.level = level; //LogEventLevel.DEBUG;
			
			traceTarget.includeDate = true;
			traceTarget.includeTime = true;
			traceTarget.includeCategory = true;
			traceTarget.includeLevel = true;
			
			return traceTarget;
		}
		
		/** 
		 * Returns a default instance of the TextListener.
		 * 
		 * @param logLevel The target level to set on the <code>ILoggingTarget</code>
		 * 
		 * @return the default <code>TextListener</code>
		 */
		public static function getDefaultTextListener( logLevel:int ):TextListener {
			Log.addTarget( buildILoggingTarget( logLevel ) );
			
			return new TextListener( Log.getLogger("FlexUnit4") );
		}
		
		/** 
		 * Constructor. 
		 * 
		 * @param logger The logger used to log the events during a test run.
		 */
		public function TextListener( logger:ILogger ) {
			super();
			this.logger = logger;
			
			//Determine if the number formatter has been created
			if ( !nf ) {
				nf = new NumberFormatter();
			}
		}
	
		/**
		 * @inheritDoc
		 */
		override public function testRunStarted( description:IDescription ):void {
			logger.info( "Running {0} Tests", description.testCount );			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function testRunFinished( result:Result ):void {
			printHeader( result.runTime );
			printFailures( result );
			printFooter( result );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function testStarted( description:IDescription ):void {
			logger.info( description.displayName + " ." );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function testFailure( failure:Failure ):void {
			//Determine if the exception in the failure is considered an error
			if ( FailureFormatter.isError( failure.exception ) ) {
				logger.error( failure.description.displayName + " E" );
			} else {
				logger.warn( failure.description.displayName + " F" );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function testIgnored( description:IDescription ):void {
			logger.info( description.displayName + " I" );
		}
	
		/*
		 * Internal methods
		 */
		
		/**
		 * Logs a header that provides the total run time
		 * 
		 * @param runTime The total run time of all tests in milliseconds
		 */
		protected function printHeader( runTime:Number ):void {
			logger.info( "Time: {0}", elapsedTimeAsString(runTime) );
			//trace( elapsedTimeAsString(runTime) );
		}
		
		/**
		 * Logs all failures that were received in the result
		 * 
		 * @param result The result that contains potential failures
		 */
		protected function printFailures( result:Result ):void {
			var failures:Array = result.failures;
			//Determine if there are any failures to print
			if (failures.length == 0)
				return;
			if (failures.length == 1)
				logger.warn( "There was {0} failure:", failures.length );
			else
				logger.warn("There were {0} failures:", failures.length );
			
			//Print each failure
			for ( var i:int=0; i<failures.length; i++ ) {
				printFailure( failures[ i ], String( i+1 ) );
			}
		}
		
		/**
		 * Logs a provided failure with a certain prefix
		 * 
		 * @param failure The provided failure
		 * @param prefix A String prefix for the failure
		 */
		protected function printFailure( failure:Failure, prefix:String ):void {
			//logger.warn( "{0} {1} {2}", prefix, failure.testHeader, failure.stackTrace );
		}
		
		/**
		 * Logs a footer for the provided result
		 * 
		 * @param result The result that contains the total run count
		 */
		protected function printFooter( result:Result ):void {
			//Determine if the result was a success
			if (result.successful ) {
				logger.info( "OK ({0} test{1})", result.runCount, (result.runCount == 1 ? "" : "s") );
			} else {
				logger.warn( "FAILURES!!! Tests run: {0}, {1} Failures:", result.runCount, result.failureCount );
			}
		}
	
		/**
		 * Returns the formatted string of the elapsed time. Duplicated from
		 * BaseTestRunner. Fix it.
		 */
		protected function elapsedTimeAsString( runTime:Number ):String {
			return nf.format( ( runTime / 1000 ) );
		}
	}
}