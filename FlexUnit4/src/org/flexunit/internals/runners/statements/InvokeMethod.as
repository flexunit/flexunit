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
package org.flexunit.internals.runners.statements {
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;

	public class InvokeMethod extends AsyncStatementBase implements IAsyncStatement {
		private var testMethod:FrameworkMethod;
		private var target:Object;
		
		public function InvokeMethod( testMethod:FrameworkMethod, target:Object ) {
			this.testMethod = testMethod;
			this.target = target;

			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleMethodExecuteComplete );
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;

			try {
				testMethod.invokeExplosivelyAsync( myToken, target );
			} catch ( error:Error ) {
				parentToken.sendResult( error );
			}
		}
		
 		protected function handleMethodExecuteComplete( result:ChildResult ):void {
			parentToken.sendResult( null );
		}
		
		override public function toString():String {
			return "InvokeMethod " + testMethod.name;
		}
 	}
}
