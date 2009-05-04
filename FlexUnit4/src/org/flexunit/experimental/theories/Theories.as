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
package org.flexunit.experimental.theories {
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.FrameworkMethod;
	
	public class Theories extends BlockFlexUnit4ClassRunner {
		public function Theories( klass:Class ) {
			super( klass );
		}

		override protected function collectInitializationErrors( errors:Array ):void {
			super.collectInitializationErrors(errors);
	
			validateDataPointFields(errors);
		}

		private function validateDataPointFields( errors:Array ):void {
			var klassInfo:Klass = new Klass( testClass.asClass );

			for ( var i:int=0; i<klassInfo.fields.length; i++ ) {
				if ( !( klassInfo.fields[ i ] as Field ).isStatic ) {
					errors.push( new Error("DataPoint field " + ( klassInfo.fields[ i ] as Field ).name + " must be static") );
				}
			}
		}
		
		override protected function validateTestMethods( errors:Array ):void {
			var method:FrameworkMethod;
			var methods:Array = computeTestMethods();

			for ( var i:int=0; i<methods.length; i++ ) {
				method = methods[ i ];
				method.validatePublicVoid( false, errors );
			}
		}
		
		private function removeFromArray( array:Array, removeElements:Array ):void {
			for ( var i:int=0; i<array.length; i++ ) {
				for ( var j:int=0; j<removeElements.length; j++ ) {
					if ( array[ i ] == removeElements[ j ] ) {
						array.splice( i, 1 );
					}
				}
			}
		}
	
		override protected function computeTestMethods():Array {
			var testMethods:Array = super.computeTestMethods();
			var theoryMethods:Array = testClass.getMetaDataMethods( "Theory" );
			
			removeFromArray( testMethods, theoryMethods );
			testMethods = testMethods.concat( theoryMethods );

			return testMethods;
		}

		override protected function methodBlock( method:FrameworkMethod ):IAsyncStatement {
			return new TheoryAnchor( method, testClass );
		}
	}
}