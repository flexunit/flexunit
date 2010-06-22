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
	import org.flexunit.token.AsyncCoreStartupToken;

	public interface IExternalRunnerDependencyWatcher {
		/**
		 * Returns the start up <code>AsyncCoreStartupToken</code> that the FlexUnit core 
		 * uses to wait for the resolution of all dependencies
		 * 
		 */
		function get token():AsyncCoreStartupToken;		
		/**
		 * Indicates if there are still unresolved dependencies in any runner
		 *  
		 * @return true is all dependencies have been resolved
		 * 
		 */
		function get allDependenciesResolved():Boolean;
		/**
		 * Tells an implementing watcher to monitor an additional IExternalDependencyResolver
		 * 
		 * @param dr IExternalDependencyResolver
		 * 
		 */
		function watchDependencyResolver( dr:IExternalDependencyResolver ):void;
	}
}