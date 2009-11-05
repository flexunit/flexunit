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
package org.flexunit.experimental.theories {
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.FrameworkMethod;
	
	/**
	 * The <code>Theories</code> runner is a runner that will run theory test methods.  In order for a theory to properly run,
	 * a test class must have a method marked as a theory method that contains one or more parameters.  The type of each parameter
	 * must have a static data point or an array of data points that correspond that correspond to that type.
	 * 
	 * <pre>
	 * 
	 * [DataPoints]
	 * [ArrayElementType("String")]
	 * public static var stringValues:Array = ["one","two","three","four","five"];
	 * 
	 * [DataPoint]
	 * public static var values1:int = 2;
	 * 
	 * 
	 * [Theory]
	 * public function testTheory(name:String, value:int):void {
	 * 	//Do something
	 * }
	 * 
	 * </pre>
	 */
	public class Theories extends BlockFlexUnit4ClassRunner {
		
		/**
		 * Constructor.
		 * 
		 * @param klass The test class that is to be executed by the runner.
		 */
		public function Theories( klass:Class ) {
			super( klass );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function collectInitializationErrors( errors:Array ):void {
			super.collectInitializationErrors(errors);
	
			validateDataPointFields(errors);
		}
		
		/**
		 * Validates all fields in a test class an ensure that they are all static.
		 * 
		 * @param errors An array of errors that has been encountered during the initialization process.  If
		 * a field is not static, an error will be added to this array.
		 */
		private function validateDataPointFields( errors:Array ):void {
			var klassInfo:Klass = new Klass( testClass.asClass );

			for ( var i:int=0; i<klassInfo.fields.length; i++ ) {
				if ( !( klassInfo.fields[ i ] as Field ).isStatic ) {
					errors.push( new Error("DataPoint field " + ( klassInfo.fields[ i ] as Field ).name + " must be static") );
				}
			}
		}
		
		/**
		 * Adds to <code>errors</code> for each method annotated with <code>Test</code> or
		 * <code>Theory</code> that is not a public, void instance method.
		 */
		override protected function validateTestMethods( errors:Array ):void {
			var method:FrameworkMethod;
			var methods:Array = computeTestMethods();

			for ( var i:int=0; i<methods.length; i++ ) {
				method = methods[ i ];
				method.validatePublicVoid( false, errors );
			}
		}
		
		/**
		 * If an element is contained in the removeElements array and the other array, remove
		 * that element from the other array.
		 * 
		 * @param array The array that will have elements removed from it if a match is found.
		 * @param removeElements The array that contains elements to remove from the other array.
		 */
		private function removeFromArray( array:Array, removeElements:Array ):void {
			for ( var i:int=0; i<array.length; i++ ) {
				for ( var j:int=0; j<removeElements.length; j++ ) {
					if ( array[ i ] == removeElements[ j ] ) {
						array.splice( i, 1 );
					}
				}
			}
		}
		
		/**
		 * Returns the methods that run tests and theories.  The tests
		 * will be located at the begining of the returned array while 
		 * the theories will be present at the end of the array.
		 */
		override protected function computeTestMethods():Array {
			var testMethods:Array = super.computeTestMethods();
			var theoryMethods:Array = testClass.getMetaDataMethods( "Theory" );
			
			removeFromArray( testMethods, theoryMethods );
			testMethods = testMethods.concat( theoryMethods );

			return testMethods;
		}
		
		/**
		 * Returns a <code>TheoryAnchor</code> for the given theory method in the test class.
		 * 
		 * @param method The theory method that is to be tested.
		 * 
		 * @return a <code>TheoryAnchor</code> for the provided <code>FrameworkMethod</code>.
		 */
		override protected function methodBlock( method:FrameworkMethod ):IAsyncStatement {
			return new TheoryAnchor( method, testClass );
		}
	}
}