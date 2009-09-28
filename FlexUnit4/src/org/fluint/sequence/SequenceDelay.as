/**
 * Copyright (c) 2008 Jurgen Failenschmid
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
 * @author Jurgen Failenschmid
 * @see http://code.google.com/p/fluint/wiki/Sequences Test sequences
 * 
 * @modified Michael Labriola 
 * @purpose changes for FlexUnit 4 integration
 **/ 
package org.fluint.sequence {

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * A sequence step that delays the sequence for a given time period.
	 * 
  	 * @author Jurgen Failenschmid
     * @see http://code.google.com/p/fluint/wiki/Sequences Test sequences 
	 */
	
	public class SequenceDelay extends SequenceWaiter {
		
		private var _waitTimer:Timer;
		
		/**
		 * Creates an instance.
		 * 
		 * @param milliseconds the delay time in ms
		 */ 
		public function SequenceDelay(milliseconds:Number = 1000) {
            _waitTimer = new Timer(milliseconds, 1);
			// the timeout shall never happen
			super(_waitTimer, TimerEvent.TIMER_COMPLETE, milliseconds + 900000);
		}

        /** @inheritDoc */
        public override function setupListeners(testCase:*, sequence:SequenceRunner):void {
        	super.setupListeners(testCase, sequence);
        	_waitTimer.start();
        }
        
        /**
         * Factory method for an instance with a delay expressed in seconds.
         * 
         * @param seconds delay in seconds
         * @return an instance ready to be added to a sequence
         */ 
        public static function forSeconds(seconds:Number):SequenceDelay {
        	return new SequenceDelay(1000 * seconds);
        }
	}
}