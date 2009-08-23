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
	import org.flexunit.reporting.FailureFormatter;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;

	public class TraceListener extends RunListener {

		public function TraceListener() {
			super();
		}
		
		override public function testRunFinished( result:Result ):void {
			printHeader( result.runTime );
			printFailures( result );
			printFooter( result );
		}
	
		override public function testStarted( description:IDescription ):void {
			trace( description.displayName + " ." );
		}
	
		override public function testFailure( failure:Failure ):void {
			if ( FailureFormatter.isError( failure.exception ) ) {
				trace( failure.description.displayName + " E" );
			} else {
				trace( failure.description.displayName + " F" );
			}
		}
	
		override public function testIgnored( description:IDescription ):void {
			trace( description.displayName + " I" );
		}
	
		/*
		 * Internal methods
		 */
		protected function printHeader( runTime:Number ):void {
			trace( "Time: " + elapsedTimeAsString(runTime) );
			//trace( elapsedTimeAsString(runTime) );
		}
	
		protected function printFailures( result:Result ):void {
			var failures:Array = result.failures;
			if (failures.length == 0)
				return;
			if (failures.length == 1)
				trace( "There was " + failures.length + " failure:" );
			else
				trace("There were " + failures.length + " failures:" );
			
			for ( var i:int=0; i<failures.length; i++ ) {
				printFailure( failures[ i ], String( i+1 ) );
			}
		}
	
		protected function printFailure( failure:Failure, prefix:String ):void {
			trace( prefix + " " + failure.testHeader + " " + failure.stackTrace );
		}
	
		protected function printFooter( result:Result ):void {
			if (result.successful ) {
				trace( "OK (" + result.runCount + " test " + (result.runCount == 1 ? "" : "s") + ")" );
			} else {
				trace( "FAILURES!!! Tests run: " + result.runCount + ", " + result.failureCount + " Failures:" );
			}
		}
	
		/**
		 * Returns the formatted string of the elapsed time. Duplicated from
		 * BaseTestRunner. Fix it.
		 */
		protected function elapsedTimeAsString( runTime:Number ):String {
			return String( runTime / 1000 );
		}
	}
}