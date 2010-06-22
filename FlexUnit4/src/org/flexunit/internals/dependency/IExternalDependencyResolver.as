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
package org.flexunit.internals.dependency {
	import flash.events.IEventDispatcher;
	
	import org.flexunit.runner.external.ExternalDependencyToken;
	
	/**
	 * IExternalDependencyResolver are responsible for resolving external dependencies on
	 * a test class
	 * @author mlabriola
	 * 
	 */
	public interface IExternalDependencyResolver extends IEventDispatcher {
		/**
		 * Indicates if the ExternalDependencies managed by this Resolver are
		 * all resolved.
		 *  
		 * @return true if the runner can now begin execution 
		 * 
		 */		
		function get ready():Boolean;
		/**
		 *
		 * Looks for external dependencies in the test class and begins the process of resolving them
		 *  
		 * @return true if there are external dependencies 
		 * 
		 */		
		function resolveDependencies():Boolean;
		/**
		 * Called by an ExternalDependencyToken when an IExternalDependencyLoader has completed resolving the dependency 
		 * and is ready  with data 
		 *  
		 * @param token the token keeping track of this dependency load
		 * @param data the returned data
		 * 
		 */
		function dependencyResolved( token:ExternalDependencyToken, data:Object ):void;			
		/**
		 * Called by an ExternalDependencyToken when an IExternalDependencyLoader has failed to 
		 * resolve a dependency 
		 *  
		 * @param token the token keeping track of this dependency load
		 * @param data the returned data
		 * 
		 */
		function dependencyFailed( token:ExternalDependencyToken, errorMessage:String ):void;
	}
}