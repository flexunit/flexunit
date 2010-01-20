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
package org.flexunit.internals.runners {
	import flash.events.IEventDispatcher;
	
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.StatementSequencer;
	import org.flexunit.runner.notification.IRunNotifier;
	
	/**
	 * The <code>ChildRunnerSequencer</code> is used to sequence children of specific class.  These children are 
	 * evaluted using a function provided to the sequencer in its constructor.  These children can be provided to 
	 * the <code>ChildRunnerSequencer</code> as an array during instantiation or added using the <code>#addStep</code> 
	 * method.<br/>
	 * 
	 * The list of children can be evaluated using the <code>#evaluate</code> method and any errors encountered
	 * during execution will be noted and reported.  Each child will be run in sequence, waiting for the previous 
	 * child to finish running before starting the next.
	 * 
	 * @see org.flexunit.runners.ParentRunner
	 */
	public class ChildRunnerSequencer extends StatementSequencer implements IAsyncStatement {
		
		public static const COMPLETE:String = "complete";
		/**
		 * @private
		 */
		private var runChild:Function;
		/**
		 * @private
		 */
		private var notifier:IRunNotifier;
		/**
		 * @private
		 */
		private var parent:IEventDispatcher;
		
		/**
		 * Constructor.
		 * 
		 * @param children An <code>Array</code> of children.
		 * @param runChild A <code>Function</code> that will be run against each child.
		 * @param notifier An <code>IRunNottifer</code> that will report on a child running in the 
		 * <code>runChild</code> method.
		 */
		public function ChildRunnerSequencer( children:Array, runChild:Function, notifier:IRunNotifier ) {
			super( children );
			this.runChild = runChild;
			this.notifier = notifier;
			this.parent = parent;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function executeStep( child:* ):void {
			runChild( child, notifier, myToken );
		}
		
		/**
		 * @private
		 * @return
		 */
		override public function toString():String {
			return "ChildRunnerSequence";
		}
	}
}