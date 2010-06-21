/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
package org.flexunit.runner.external {
	import flex.lang.reflect.Field;
	
	import org.flexunit.internals.dependency.ExternalDependencyResolver;
	import org.flexunit.internals.dependency.IExternalDependencyResolver;

	/**
	 * ExternalDependencyToken follows a pattern similar to the AsyncToken in Flex
	 * to notify interested resolvers when a dependency has been resolved.
	 * 
	 * @author mlabriola
	 * 
	 */
	public class ExternalDependencyToken {
		/**
		 * @private 
		 */
		private var resolver:IExternalDependencyResolver;
		/**
		 * @private 
		 */
		private var _targetField:Field;

		/**
		 * The field where the final data loaded from this external dependency will reside
		 * 
		 * @return a Field instance 
		 * 
		 */
		public function get targetField():Field
		{
			return _targetField;
		}

		public function set targetField(value:Field):void
		{
			_targetField = value;
		}

		/**
		 * Adds a IExternalDependencyResolver to this token to be notified when success or failure occurs
		 * 
		 * @param adr an IExternalDependencyResolver
		 * 
		 */
		public function addResolver( adr:IExternalDependencyResolver ):void {
			resolver = adr;	
		}

		/**
		 * Removes a IExternalDependencyResolver so that it will no longer be notified of future success or failure
		 *  
		 * @param adr IExternalDependencyResolver
		 * 
		 */
		public function removeResolver( adr:IExternalDependencyResolver ):void {
			if ( resolver == adr ) {
				resolver = null;
			}
		}

		/**
		 * Notifies the resolver of successful data retrieval
		 *  
		 * @param data Only needed when using an IExternalDependencyLoader and not an IExternalDependencyValue
		 * 
		 */
		public function notifyResult( data:Object=null ):void {
			resolver.dependencyResolved( this, data );			
		}

		/**
		 * Notifies the resolver of a failure
		 *  
		 * @param errorMessage is a string with a description of the fault
		 * 
		 */
		public function notifyFault( errorMessage:String ):void {
			resolver.dependencyFailed( this, errorMessage );
		}

		/**
		 * Constructor 
		 * 
		 */
		public function ExternalDependencyToken( ) {
		}
	}
}
