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
package org.flexunit.internals.runners.statements
{
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.SequencerWithDecoration;
	import org.flexunit.runners.model.FrameworkMethod;
	
	/**
	 * The <code>RunAfters</code> is a <code>SequencerWithDecoration</code> for potential methods that have
	 * <code>After</code> metadata and should be run after a test has finished.  This class also determines
	 * whether methods tagged as after methods are asynchronous.
	 */
	public class RunAfters extends SequencerWithDecoration implements IAsyncStatement {
		
		/**
		 * @inheritDoc
		 */
		override protected function withPotentialAsync( method:FrameworkMethod, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var async:Boolean = ExpectAsync.hasAsync( method, "After" );
			return async ? new ExpectAsync( test, statement ) : statement;
		}
		
		/**
		 * Constructor.
		 * 
		 * @param afters An array containing all statements that need to be executed after a test method has finished.
		 * @param target The test class.
		 */
		public function RunAfters( afters:Array, target:Object ) {
			super( afters, target );
		}

		/**
		 * @private 
		 * @return 
		 */
		override public function toString():String {
			return "RunAfters";
		}
	}
}