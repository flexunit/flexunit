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
package org.flexunit.experimental.runners.statements {
	import flex.lang.reflect.Klass;
	
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.FrameworkMethod;
	
	use namespace classInternal;
	
	/**
	 * The <code>TheoryBlockRunner</code> is a runner used for running an indiviudal theory method that 
	 * has had all of its parameters assigned values.  Like the <code>BlockFlexUnit4ClassRunner</code> 
	 * from which it extends, the <code>TheoryBlockRunner</code> is based on <code>Statement</code>s.
	 */
	public class TheoryBlockRunner extends BlockFlexUnit4ClassRunner {
		/**
		 * @private
		 */
		private var complete:Assignments;
		/**
		 * @private
		 */
		private var anchor:TheoryAnchor;
		/**
		 * @private
		 */
		private var klassInfo:Klass;
		
		/**
		 * Constructor.
		 * 
		 * @param klass The class that contains the theory.
		 * @param anchor The anchor associated with the theory method.
		 * @param complete Contains the parameters used for the theory method.
		 */
		public function TheoryBlockRunner( klass:Class, anchor:TheoryAnchor, complete:Assignments ) {
			super(klass);
			this.anchor = anchor;
			this.complete = complete;
			this.klassInfo = new Klass( klass );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function collectInitializationErrors( errors:Array ):void {
			// do nothing
		}		
		
		/**
		 * Creates a <code>MethodCompleteWithParamsStatement</code> that is used to execute the theory method for
		 * a specific set of <code>Assignments</code>.
		 * 
		 * @inheritDoc
		 */
		override protected function methodInvoker( method:FrameworkMethod, test:Object ):IAsyncStatement {
			return new MethodCompleteWithParamsStatement( method, anchor, complete, test );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createTest():Object {
			return klassInfo.constructor.newInstanceApply( complete.getConstructorArguments( anchor.nullsOk() ) );
		}
		
		/**
		 * Retrieves an object that implements a <code>IAsyncStatement</code> for a specific theory test method that will run
		 * a theory with a subset of potential parameters that the theory can be run with.
		 * 
		 * @param method The <code>FrameworkMethod</code> theory to test.
		 * 
		 * @return an object that implements a <code>IAsyncStatement</code> for a specific theory test.
		 */
		public function getMethodBlock( method:FrameworkMethod ):IAsyncStatement {
			return methodBlock( method );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function methodBlock( method:FrameworkMethod ):IAsyncStatement {
			var statement:IAsyncStatement = super.methodBlock( method );
			return new TheoryBlockRunnerStatement( statement, anchor, complete ); 
		}
		
		/**
		 * @inheritDoc
		 */
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