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
package org.flexunit.async {
	import flash.events.EventDispatcher;
	
	import org.flexunit.events.AsyncResponseEvent;
	
	/** 
	 * The 'responderFired' event is fired when either a result or
	 * fault is dispatched.
	 */
	[Event(name="responderFired",type="net.digitalprimates.fluint.events.AsyncResponseEvent")]
	
	/**
	 * A respoder for asynchronous tests that contains result and fault handlers for the test succeeding or the test 
	 * failing to succeed.
	 */
	public class AsyncTestResponder extends EventDispatcher implements IAsyncTestResponder {
		/**
		 * @private
		 */
		private var originalResponder:*;		
		
		/**
		 * Dispatches an AsyncResponseEvent with the orignalResponder, a "fault" status, and the provided info object.
		 * 
		 * @inheritDoc
		 *
		 */
		public function fault( info:Object ):void {
			dispatchEvent( new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, originalResponder, 'fault', info ) );
		}
		
		/**
		 * Dispatches an AsyncResponseEvent with the orignalResponder, a "result" status, and the provided info object.
		 * 
		 * @inheritDoc
		 */
		public function result( data:Object ):void {
			dispatchEvent( new AsyncResponseEvent( AsyncResponseEvent.RESPONDER_FIRED, false, false, originalResponder, 'result', data ) );
		}
		
		/**
		 * Constructor.
		 * 
		 * @param originalResponder The responder to be passed when the AsyncResponseEvent is dispatched.
		 */
		public function AsyncTestResponder( originalResponder:* ) {
			this.originalResponder = originalResponder;
		}
	}
}