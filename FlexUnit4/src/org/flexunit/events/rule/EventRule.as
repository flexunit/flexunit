package org.flexunit.events.rule
{
	import flash.events.IEventDispatcher;
	
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.AssertionError;
	import org.flexunit.internals.events.ExecutionCompleteEvent;
	import org.flexunit.internals.runners.model.MultipleFailureException;
	import org.flexunit.internals.runners.statements.MethodRuleBase;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;

	/**
	 * 
	 * User stories
	 * 
	 * User sets a complex expectation on an event without a timeout
	 * User sets a complex expectations on two different events without a timeout
	 * User sets two different expectations on the same event without a timeout
	 * 		For example, the first time it has property A set
	 * 			the second time it has property B set
	 * 
	 * User sets a complex expectation on an event with a timeout
	 * User sets a complex expectations on two different events with a timeout
	 * User sets two different expectations on the same event with a timeout
	 * 
	 * 
	 * 
	 * 
	 * **/
	public class EventRule extends MethodRuleBase implements IMethodRule {
		private var expectedEvents:Array;
		private var complete:Boolean = false;
		
		private function handleFailEvent( event:ExpectationEvent ):void {
			/**
			 * 
			 * Just because we get here is not automaticly mean that we fail the test
			 * Suppose we have seemingly mutual exclusive failures... for example, if
			 * we have (n) different EventExpectation instance all listening to the same
			 * event. Then there is little chance all of them will succeed together. 
			 * 
			 * So, each time we have a failure, we need to 
			 *
			 *  
			 * 
			 * **/
			
			if ( !complete ) {
				complete = true;
				super.handleStatementComplete( new ChildResult( myToken, new AssertionFailedError( event.reason ) ) );
			}
		}
		
		private function handlePassEvent( event:ExpectationEvent ):void {
			var eventExpectation:EventExpectations;
			var eventsComplete:Boolean = true;
			for ( var i:int=0; i<expectedEvents.length; i++ ) {
				eventExpectation = expectedEvents[ i ] as EventExpectations;
				eventsComplete &&= eventExpectation.complete;
				if (!eventsComplete) {
					break;
				}
			}
			
			if ( eventsComplete ) {
				if ( !complete ) {
					complete = true;				
					sendComplete( null );
				}
			}
		}

		public function from( dispatcher:IEventDispatcher ):IEventExpectation {
			var expectedEvent:EventExpectations = new EventExpectations( dispatcher, this );
			expectedEvent.addEventListener( ExpectationEvent.PASS_EXPECTATION, handlePassEvent );
			expectedEvent.addEventListener( ExpectationEvent.FAIL_EXPECTATION, handleFailEvent );
			expectedEvents.push( expectedEvent );

			return expectedEvent;
		}
		
		override public function evaluate( parentToken:AsyncTestToken ):void {
			super.evaluate( parentToken );
			proceedToNextStatement();
		}
		
		override protected function handleStatementComplete( result:ChildResult ):void {
			var expectedEvent:EventExpectations;
			var error:Error;
			var errors:Array = [];
			var childResult:ChildResult;
			
			if ( complete ) {
				return;
			}

			//We are already in an error state, just pass it along and do no more
			if ( result.error ) {
				complete = true;
				super.handleStatementComplete( result );
				return;
			}

			//Do we have any pending async events? If so, we cannot evaluate this statement right now
			var pendingAsync:Boolean = false;
			for ( var i:int=0; i<expectedEvents.length; i++ ) {
				expectedEvent = ( expectedEvents[ i ] as EventExpectations );
				expectedEvent.startMonitor();
				pendingAsync ||= expectedEvent.pendingAsync;
				
				if ( pendingAsync ) {
					return;
				}
			}
			
			for ( var j:int=0; j<expectedEvents.length; j++ ) {
				expectedEvent = ( expectedEvents[ j ] as EventExpectations );

				try { 
					expectedEvent.verify();
				}
				
				catch ( e:Error ) {
					errors.push( e );
				}
			}

			if ( !complete ) {
				complete = true;
				
				if ( errors.length == 0 ) {
					super.handleStatementComplete( result );	
				} else if ( errors.length == 1 ) {
					super.handleStatementComplete( new ChildResult( myToken, errors[ 0 ] ) );
				} else {
					//This one needs work....
					super.handleStatementComplete( new ChildResult( myToken, new MultipleFailureException( errors ) ) );
				}
			}
		}

		public function EventRule() {
			super();
			expectedEvents = new Array();
		}
	}
}