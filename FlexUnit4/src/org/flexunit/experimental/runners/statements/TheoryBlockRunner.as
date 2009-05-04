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
package org.flexunit.experimental.runners.statements {
	import flex.lang.reflect.Klass;
	
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.FrameworkMethod;
	
	use namespace classInternal;

	public class TheoryBlockRunner extends BlockFlexUnit4ClassRunner {
		private var complete:Assignments;
		private var anchor:TheoryAnchor;
		private var klassInfo:Klass;

		public function TheoryBlockRunner( klass:Class, anchor:TheoryAnchor, complete:Assignments ) {
			super(klass);
			this.anchor = anchor;
			this.complete = complete;
			this.klassInfo = new Klass( klass );
		}
	
		override protected function collectInitializationErrors( errors:Array ):void {
			// do nothing
		}		
	
		override protected function methodInvoker( method:FrameworkMethod, test:Object ):IAsyncStatement {
			return new MethodCompleteWithParamsStatement( method, anchor, complete, test );
		}
	
		override protected function createTest():Object {
			return klassInfo.constructor.newInstanceApply( complete.getConstructorArguments( anchor.nullsOk() ) );
		}
		
		public function getMethodBlock( method:FrameworkMethod ):IAsyncStatement {
			return methodBlock( method );
		}
	
		override protected function methodBlock( method:FrameworkMethod ):IAsyncStatement {
			var statement:IAsyncStatement = super.methodBlock( method );
			return new TheoryBlockRunnerStatement( statement, anchor, complete ); 
		}
	
		override protected function withDecoration( method:FrameworkMethod, test:Object ):IAsyncStatement {
			var statement:IAsyncStatement = methodInvoker( method, test );
			statement = withPotentialAsync( method, test, statement );
			//statement = withPotentialTimeout( method, test, statement );
			statement = possiblyExpectingExceptions( method, test, statement );
			statement = withStackManagement( method, test, statement );
			
			return statement;
		}
	}
}