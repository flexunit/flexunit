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
package org.flexunit.internals.events
{
	import flash.events.Event;
	
	/**
	 * Dispatched when the runner has finished executing tests.
	 */
	public class ExecutionCompleteEvent extends Event {
		
		public static const COMPLETE:String = "complete";
		
		/** 
		 * A potential error that was encountered during execution.
		 */
		public var error:Error;
		
		/**
		 * Constructor.
		 * 
		 * @param error A potential error that was encountered during execution.
		 */
		public function ExecutionCompleteEvent( error:Error=null  ) {
			this.error = error;
			super(COMPLETE, false, false);
		}
		
		/** 
		 * Called by the framework to facilitate any requisite event bubbling.
		 * 
		 * @inheritDoc
		 */
		override public function clone():Event {
			return new ExecutionCompleteEvent( error );
		}
	}
}