/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/
package org.flexunit.events {
	import flash.events.Event;
	
	import mx.rpc.IResponder;
	
	/**
	 * An AsyncResponseEvent is event that is fired when an asynchronous test has recieved a response
	 * from an <code>IAsyncTestTresponder</code>.
	 */
	public class AsyncResponseEvent extends Event {
		public static var RESPONDER_FIRED:String = "responderFired";
		
		public var originalResponder:*;
		public var methodHandler : Function;
		public var status:String;
		public var data:Object;
		
		/**
		 * Constructor.
		 *
		 * This class has all of the properties of the event class in addition to the
		 * originalResponder, status, and data properties.
		 *
		 * @param type The event type; indicates the action that triggered the event.
		 *
		 * @param bubbles Specifies whether the event can bubble
		 * up the display list hierarchy.
		 *
		 * @param cancelable Specifies whether the behavior
		 * associated with the event can be prevented.
		 *
		 * @param originalResponder The responder that originally responded to the async event.
		 *
		 * @param status The status of the asyncronous response.
		 *
		 * @param data The data that was returned from the async event, usually the data or the info from the fault.
		 *
		 */
		public function AsyncResponseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, originalResponder:*=null, status:String=null, data:Object=null ) {
			this.originalResponder = originalResponder;
			this.status = status;
			this.data = data;
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Called by the framework to facilitate any requisite event bubbling
		 *
		 * @inheritDoc
		 */
		override public function clone():Event {
			return new AsyncResponseEvent( type, bubbles, cancelable, originalResponder, status, data );
		}
	}
}