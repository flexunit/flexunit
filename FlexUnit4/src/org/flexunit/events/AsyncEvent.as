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

	/** 
	 * An AsyncEvent is fired by the AsyncHandler when an asynchronous event, registered by
	 * the TestCase, fires. The AsyncEvent contains a referenced, originalEvent, to the 
	 * originalEvent fired for future consumption. TestCase instances listen for this event
	 * on AsyncHandler instances.
	 */
	public class AsyncEvent extends Event {
		/** 
		 * A reference to the original event object fired by the developers test code. 
		 */
		public var originalEvent:Event;

		/** 
		 * Constructor.
		 * 
		 * This class has all of the properties of the event class in addition to the 
		 * originalEvent property.
		 * 
    	 * @param type The event type; indicates the action that triggered the event.
    	 *
    	 * @param bubbles Specifies whether the event can bubble
    	 * up the display list hierarchy.
    	 *
    	 * @param cancelable Specifies whether the behavior
    	 * associated with the event can be prevented.
    	 * 
		 * @param originalEvent Event that originally triggered AsyncEvent.
		 */
		public function AsyncEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, originalEvent:Event=null ) {
			this.originalEvent = originalEvent;
			super(type, bubbles, cancelable);
		}

		/** 
		 * Called by the framework to facilitate any requisite event bubbling 
		 * 
		 * @inheritDoc
		 */
		override public function clone():Event {
		   return new AsyncEvent( type, bubbles, cancelable, originalEvent );
		}
	}
}