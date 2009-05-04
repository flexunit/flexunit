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
package org.flexunit.internals.runners.model {
	public class MultipleFailureException extends Error {
		private var errors:Array;

		public function areAllErrorsType( type:Class ):Boolean {
			
			if ( !errors ) {
				return false;
			}

			var allOfType:Boolean = true;
			for ( var i:int=0; i<errors.length; i++ ) {
				allOfType &&= ( errors[ i ] is type );
				
				if ( !allOfType ) {
					break;
				}
			} 
			
			return allOfType;
		}

		public function get failures():Array {
			return errors;
		}
		
		public function addFailure( error:Error ):MultipleFailureException {
			if ( !errors ) {
				errors = new Array();
			}

			errors.push( error );
			
			return this;
		}

		public function MultipleFailureException( errors:Array ) {
			this.errors = errors;
			super("MultipleFailureException");
		}
		
	}
}