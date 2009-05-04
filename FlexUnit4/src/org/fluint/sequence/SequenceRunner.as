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
	import flash.events.Event;
	
	/**
     * Allows developer to add a series of steps, execute those steps 
	 * in order, until the sequence is complete.
     */	
	public class SequenceRunner	{
		/**
		 * @private
		 */
		protected var testCase:*;

		/**
		 * @private
		 */
		protected var steps:Array;

		/**
		 * @private
		 */
		protected var assertHandlers:Array;
		
		/**
		 * @private
		 */
		protected var currentStep:int = 0;
		
		/**
		 * @private
		 */
		protected var _executingStep:ISequenceStep;

		/**
		 * @private
		 */
		protected var _pendingStep:ISequencePend;

		/**
		 * Returns number of steps in the sequence.
		 */
		public function get numberOfSteps():int {
			return steps.length;
		}

		/**
		 * Returns the ISequenceStep at a specified index.
		 */
		public function getStep( stepIndex:int ):ISequenceStep {
			return steps[ stepIndex ];
		}

		/**
		 * Returns the ISequenceStep currently executing.
		 */
		public function getExecutingStep():ISequenceStep {
			return _executingStep;
		}

		/**
		 * Returns the ISequenceStep currently executing.
		 */
		public function getPendingStep():ISequencePend {
			return _pendingStep;
		}

		/**
		 * Adds an ISequenceStep to the sequence.
		 * 
		 * @param step Step to be added.
		 */
		public function addStep( step:ISequenceStep ):void {
			steps.push( step );
		}

		/** 
	 	 * <p>
	 	 * Add a reference to the event handler that should be called if the sequence completes 
	 	 * sucessfully.</p>
	 	 * 
	 	 * <p>
	 	 * The handler is expected to have the follow signature:</p>
	 	 * 
	 	 * <p>
	 	 * <code>public function handleEvent( event:Event, passThroughData:Object ):void {
	 	 * }</code></p>
	 	 * 
		 * @param assertHandler The original event object from the previous step.
		 * @param passThroughData A generic object that can optionally be provided by 
	 	 * the developer when creating a new sequence.
		 */
		public function addAssertHandler( assertHandler:Function, passThroughData:Object ):void {
			assertHandlers.push( new AssertHandler( assertHandler, passThroughData ) );
		}

		/**
		 * Begins the execution of a sequence.
		 */
		public function run():void {
			continueSequence( null );
		}

		/**
		 * @private
		 */
		protected function applyActions( actions:Array ):void {
			for ( var i:int=0;i<actions.length; i++ ) {
				_executingStep = actions[ i ] as ISequenceStep; 
				( actions[ i ] as ISequenceAction ).execute();
			}
		}
		
		/**
		 * @private
		 */
		protected function applyHandlers( event:Event ):void {
			var handler:AssertHandler;

			for ( var i:int=0;i<assertHandlers.length; i++ ) {
				handler = ( assertHandlers[ i ] as AssertHandler ); 
				handler.assertHandler( event, handler.passThroughData ); 
			}
			
			//sequenceComplete = true;
		}

		/**
		 * Called by the testCase when the next step in the sequence should begin.
		 * 
		 * @param event Event broadcast by the last step in the sequence.
		 */
		public function continueSequence( event:Event ):void {
			var actionArray:Array = new Array();
			var nextPend:ISequencePend;
			var scheduledNewAsync:Boolean = false;


			//Look forward into the sequence until we find the next time we need to pend
			while( currentStep < numberOfSteps ) {
				if ( steps[ currentStep ] is ISequencePend ) {
					nextPend = steps[ currentStep ] as ISequencePend;
					currentStep++; 
					break;
				} else {
					//Keep an array of the actions we need to take
					actionArray.push( steps[ currentStep ] );
					currentStep++; 
				}
			}

			if ( nextPend ) {
				_pendingStep = nextPend; 
				nextPend.setupListeners( testCase, this );
				scheduledNewAsync = true;
			}
			
			applyActions( actionArray );
			
			
			if ( ( currentStep >= numberOfSteps ) && ( !scheduledNewAsync ) ) {
				applyHandlers( event );
			}
		}

		/**
		 * Constructor.
		 *  
		 * @param testCase testCase within which is sequence is being run.
		 */
		public function SequenceRunner( testCase:* ) {
			steps = new Array();
			assertHandlers = new Array();

			this.testCase = testCase;
		}		
	}
}

////////////////////////////////////////////////////////////////////////////////
//
//  Helper class: AssertHandler
//
////////////////////////////////////////////////////////////////////////////////
class AssertHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
	public function AssertHandler( assertHandler:Function, passThroughData:Object=null )
    {
		super();

		this.assertHandler = assertHandler;
		this.passThroughData = passThroughData;
    }

	/** 
	 * <p>
	 * A reference to the event handler that should be called if the sequence completes 
	 * sucessfully.</p>
	 * 
	 * <p>
	 * The handler is expected to have the follow signature:</p>
	 * 
	 * <p>
	 * <code>public function handleEvent( event:Event, passThroughData:Object ):void {
	 * }</code></p>
	 * 
	 * <p>
	 * The first parameter is the original event object from the previous step.
	 * The second parameter is a generic object that can optionally be provided by 
	 * the developer when creating a new sequence.</p>
	 */
    public var assertHandler:Function;
    /**
    * Description of variable
    */
    public var passThroughData:Object ;
}
