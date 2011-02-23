/**
 * Copyright (c) 2010 Digital Primates
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
package org.flexunit.token {
	/**
	 * Interface describing viable tokens to be passed between test stages
	 *  
	 * @author mlabriola
	 * 
	 */
	public interface IAsyncTestToken {

		/**
		 * Returns the parentToken of the <code>AsyncTestToken</code>.
		 */		
		function get parentToken():IAsyncTestToken;
		function set parentToken( value:IAsyncTestToken ):void;
		
		/**
		 * Adds a notification <code>method</code> to the <code>AsyncTestToken</code> and returns the token.
		 * 
		 * @param method A <code>Function</code> that will be invoked when results are sent.
		 * @param debugClassName The name of the class.
		 * 
		 * @return this <code>AsyncTestToken</code> with the added <code>method</code>.
		 */
		function addNotificationMethod( method:Function, debugClassName:String=null ):IAsyncTestToken;
		
		/**
		 * If any notification methods exist, invokes the notification methods with a <code>ChildResult</code> that
		 * contains a references to this token and the provided <code>error</code>.
		 * 
		 * @parameter error The error to be provided to the <code>ChildResult</code>.
		 */
		function sendResult( error:Error=null ):void; 
	}
}