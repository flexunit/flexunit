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
package org.flexunit.internals.runners {
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.token.AsyncTestToken;
	
	public class ErrorReportingRunner implements IRunner {
		private var _causes:Array;
		private var _testClass:Class;

		public function ErrorReportingRunner( testClass:Class, cause:Error ) {
			_testClass = testClass;
			_causes = getCauses(cause);
		}

		public function get description():IDescription {
			var description:IDescription = Description.createSuiteDescription( _testClass );

			for ( var i:int=0; i<_causes.length; i++ ) {
				description.addChild( describeCause( _causes[ i ] ) );
			}

			return description;
		}

		public function run( notifier:IRunNotifier, token:AsyncTestToken ):void {
			for ( var i:int=0; i<_causes.length; i++ ) {
				description.addChild( describeCause( _causes[ i ] ) );
				runCause( _causes[ i ], notifier );
			}
		}

		private function getCauses( cause:Error ):Array {
			/*
			TODO: Figure this whole mess out
			if (cause instanceof InvocationTargetException)
				return getCauses(cause.getCause());
			if (cause instanceof InitializationError)
				return ((InitializationError) cause).getCauses();
			if (cause instanceof org.junit.internal.runners.InitializationError)
				return ((org.junit.internal.runners.InitializationError) cause)
						.getCauses();
			return Arrays.asList(cause);
			*/
			
			if ( cause is InitializationError ) {
				return InitializationError(cause).getCauses();
			}
			
			return [ cause ];
		}

		private function describeCause( child:Error ):IDescription {
			return Description.createTestDescription( _testClass, "initializationError");
		}
	
		private function runCause( child:Error, notifier:IRunNotifier ):void {
			var description:IDescription = describeCause(child);
			notifier.fireTestStarted( description );
			notifier.fireTestFailure( new Failure(description, child) );
			notifier.fireTestFinished( description );
		}
	}
}