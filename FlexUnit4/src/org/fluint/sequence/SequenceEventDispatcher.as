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
package org.fluint.sequence
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/** 
	 * The sequencer event dispatcher class is used by the TestCase sequence 
	 * code to broadcast an event from a target. 
	 * 
	 * It is generally used to simulate a user gesture, such as clicking on 
	 * a button. 
	 */
	public class SequenceEventDispatcher implements ISequenceAction {
        /**
         * @private
         */
		protected var _target:IEventDispatcher;
        /**
         * @private
         */
		protected var _eventToBroadcast:Event;

		/** 
		 * The target event dispatcher where the eventToBroadcast will be 
		 * broadcast from.
		 */
		public function get target():IEventDispatcher {
			return _target;	
		}

		/** 
		 * An event object which will be broadcast on the target. 
		 */
		public function get eventToBroadcast():Event {
			return _eventToBroadcast;	
		}

		/**
		 * Dispatches the specified event on the target IEventDispatcher.
		 */
		public function execute():void {
			target.dispatchEvent( eventToBroadcast );
		}

		/** 
		 * Constructor.
		 * 
		 * @param target EventDispatcher, from which the event will be broadcast.
		 * @param eventToBrodcast An actual event, which will be broadcast from the target.
		 */
		public function SequenceEventDispatcher( target:EventDispatcher, eventToBroadcast:Event ) {
			_target = target;
			_eventToBroadcast = eventToBroadcast;
		}
	}
}