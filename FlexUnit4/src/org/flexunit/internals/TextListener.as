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
package org.flexunit.internals {
	import mx.formatters.NumberFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;

	public class TextListener extends RunListener {
		private var logger:ILogger;
		private static var nf:NumberFormatter;

		public function TextListener( logger:ILogger ) {
			super();
			this.logger = logger;
			
			if ( !nf ) {
				nf = new NumberFormatter();
			}
		}
		
		override public function testRunFinished( result:Result ):void {
			printHeader( result.runTime );
			printFailures( result );
			printFooter( result );
		}
	
		override public function testStarted( description:IDescription ):void {
			logger.info( description.displayName + " ." );
		}
	
		override public function testFailure( failure:Failure ):void {
			logger.warn( failure.description.displayName + " E" );
		}
	
		override public function testIgnored( description:IDescription ):void {
			logger.info( description.displayName + " I" );
		}
	
		/*
		 * Internal methods
		 */
		protected function printHeader( runTime:Number ):void {
			logger.info( "Time: {0}", elapsedTimeAsString(runTime) );
			//trace( elapsedTimeAsString(runTime) );
		}
	
		protected function printFailures( result:Result ):void {
			var failures:Array = result.failures;
			if (failures.length == 0)
				return;
			if (failures.length == 1)
				logger.warn( "There was {0} failure:", failures.length );
			else
				logger.warn("There were {0} failures:", failures.length );
			
			for ( var i:int=0; i<failures.length; i++ ) {
				printFailure( failures[ i ], String( i+1 ) );
			}
		}
	
		protected function printFailure( failure:Failure, prefix:String ):void {
			logger.warn( "{0} {1} {2}", prefix, failure.testHeader, failure.stackTrace );
		}
	
		protected function printFooter( result:Result ):void {
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