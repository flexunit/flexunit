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
package org.fluint.sequence {
	import flash.events.IEventDispatcher;
	
	/** 
	 * The sequence setter class tells the TestCase instance to set properties on 
	 * the target.
	 */	 
	public class SequenceSetter implements ISequenceAction {
        /**
         * @private
         */
		protected var _target:IEventDispatcher;

        /**
         * @private
         */
		protected var _props:Object;

		/** 
		 * The event dispatcher where the properties/value pairs defined 
		 * in the props object will be set. 
		 */
		public function get target():IEventDispatcher {
			return _target;	
		}

		/** 
		 * <p>
		 * A generic object that contains name/value pairs that should be set on the target.</p>
		 * 
		 * <p>
		 * For example, if the target were a TextInput, a props defined like this: </p>
		 * 
		 * <p><code>{text:'blah',enabled:false}</code></p>
		 * 
		 * <p>
		 * Would set the text property to 'blah' and the enabled property to false.</p>
		 */
		public function get props():Object {
			return _props;
		}

		/**
		 * Sets the name/value pairs defined in the props object to the target.
		 */
		public function execute():void {
			if ( props ) {
				for ( var prop:String in props ) {
					if ( target ) {
						//Set all requested values on this object
						target[ prop ] = props[ prop ];
					}
				}  
			}
		}

		/**
		 * Constructor.
		 *  
		 * @param target The target where properties will be set.
		 * @param props Contains the property/value pairs to be set on the target.
		 */
		public function SequenceSetter( target:IEventDispatcher, props:Object ) {
			_target = target;
			_props = props;
		}
	}
}