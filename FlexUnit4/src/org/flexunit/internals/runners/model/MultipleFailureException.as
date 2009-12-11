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
package org.flexunit.internals.runners.model {
	/**
	 * The <code>MultipleFailureExecption</code> is used to store information on multiple errors
	 * that were encountered during the execution of a task.  It is used to package multiple
	 * errors into a single error, which could be stored in a <code>ChildResult</code>.  The
	 * <code>MultipleFailureExecption</code> initially takes an array of errors during
	 * instantiation; however, additional errors can be added using the <code>#addFailure()</code>
	 * method.
	 */
	public class MultipleFailureException extends Error {
		/**
		 * @private
		 */
		private var errors:Array;

/*		public function areAllErrorsType( type:Class ):Boolean {
			
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
		}*/
		
		/** 
		 * Returns the array of all of the failures.
		 */
		public function get failures():Array {
			return errors;
		}
		
		/** 
		 * Returns the MultipleFailureException after adding the additional failure to array of failures.
		 * 
		 * @param error The failure to add to the array of failures.
		 */
		public function addFailure( error:Error ):MultipleFailureException {
			//Create an error array if no errors were initially provided
			if ( !errors ) {
				errors = new Array();
			}

			errors.push( error );
			
			return this;
		}
		
		/** 
		 * Constructor. 
		 * 
		 * @param errors An initial array of encountered failures.
		 */
		public function MultipleFailureException( errors:Array ) {
			this.errors = errors;
			super("MultipleFailureException");
		}
		
	}
}