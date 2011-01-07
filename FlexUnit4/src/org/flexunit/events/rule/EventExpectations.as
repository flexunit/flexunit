package org.flexunit.events.rule {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.flexunit.asserts.fail;
	import org.flexunit.rules.IMethodRule;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.StringDescription;
	import org.hamcrest.number.IsGreaterThanMatcher;
	import org.hamcrest.number.IsLessThanMatcher;
	import org.hamcrest.object.IsEqualMatcher;
	import org.hamcrest.object.IsInstanceOfMatcher;
	import org.hamcrest.object.hasProperties;
	import org.hamcrest.object.hasPropertyWithValue;

	[Event(name="failEventExpectation", type="org.flexunit.events.rule.ExpectationEvent")]
	[Event(name="passEventExpectation", type="org.flexunit.events.rule.ExpectationEvent")]
	public class EventExpectations extends EventDispatcher implements IEventExpectation {

		private var evaluateWithAsync:Boolean = false;
		
		private var target:IEventDispatcher;
		private var rule:IMethodRule;
		
		private var quantityMatcher:QuantityMatcher;
		private var multiMatcher:MultiMatcher;
		private var actualEvents:Array;

		private var typeName:String;
		private var timeoutMonitor:TimeoutMonitor;

		private var methodToCallStack:Array;
		
		private var _complete:Boolean = false;
		
		public function get complete():Boolean {
			return _complete;
		}
		
		/**
				mock(core).ordered();
**/
		public function get pendingAsync():Boolean {
			if (!timeoutMonitor) {
				return false;
			}
			
			return timeoutMonitor.pending;
		}

		public function startMonitor():void {
			if (timeoutMonitor) {
				timeoutMonitor.start();
			}
		}

		public function never():IEventExpectation {
			quantityMatcher.never();
			return this;
		} 

		public function once():IEventExpectation {
			quantityMatcher.once();
			return this;
		} 

		public function twice():IEventExpectation {
			quantityMatcher.twice();
			return this;
		} 

		public function thrice():IEventExpectation {
			quantityMatcher.thrice();
			return this;
		} 

		public function times( value:Number ):IEventExpectation {
			quantityMatcher.times( value );
			return this;
		} 

		public function atLeast( value:Number ):IEventExpectation {
			quantityMatcher.atLeast( value );
			return this;
		} 

		public function atMost( value:Number ):IEventExpectation {
			quantityMatcher.atMost( value );
			return this;
		} 

		public function greaterThan( value:Number ):IEventExpectation {
			quantityMatcher.greaterThan( value );
			return this;
		} 

		public function greaterThanOrEqualTo( value:Number ):IEventExpectation {
			quantityMatcher.greaterThanOrEqualTo( value );
			return this;
		} 

		public function lessThan( value:Number ):IEventExpectation {
			quantityMatcher.lessThan( value );
			return this;
		} 

		public function lessThanOrEqualTo( value:Number ):IEventExpectation {
			quantityMatcher.lessThanOrEqualTo( value );
			return this;
		} 

		public function instanceOf( eventType:Class ):IEventExpectation {
			multiMatcher.addChildMatcher( new IsInstanceOfMatcher( eventType ) );
			return this;
		} 
		
		public function hasType( typeName:String ):IEventExpectation {
			this.typeName = typeName;
			this.target.addEventListener( typeName, handleEvent );
			return this;
		} 
		
		public function calls( method:Function ):IEventExpectation {
			if ( !methodToCallStack ) {
				methodToCallStack = [];
			}
			
			methodToCallStack.push( method );

			return this;
		}

		public function withTimeout( value:Number ):IEventExpectation {

			if ( value > 0 ) {
				evaluateWithAsync = true;
				quantityMatcher.deferEvaluation = true;
	
				//Just in case someone tries to set multiple timeouts
				if ( timeoutMonitor ) {
					timeoutMonitor.removeEventListener( TimeoutMonitor.TIME_OUT_EXPIRED, handleTimeout );
				}
	
				timeoutMonitor = new TimeoutMonitor( value );
				timeoutMonitor.addEventListener( TimeoutMonitor.TIME_OUT_EXPIRED, handleTimeout );
			}

			return this;
		}

		private function handleTimeout( event:Event ):void {
			notifyFailure( "Timeout occurred before event" );
		}
		
		private function notifyFailure( message:String ):void {
			clearTimeout();
			_complete = true;

			var event:Event = new ExpectationEvent( ExpectationEvent.FAIL_EXPECTATION, message );
			dispatchEvent( event );
		}

		private function notifyPass():void {
			clearTimeout();
			_complete = true;
			
			var event:Event = new ExpectationEvent( ExpectationEvent.PASS_EXPECTATION, "" );
			dispatchEvent( event );
		}

		public function hasPropertyWithValue( propertyName:String, valueOrMatcher:* ):IEventExpectation {
			multiMatcher.addChildMatcher( org.hamcrest.object.hasPropertyWithValue( propertyName, valueOrMatcher ) );
			return this;
		}

		public function hasProperties( value:Object ):IEventExpectation {
			multiMatcher.addChildMatcher( org.hamcrest.object.hasProperties( value ) );
			return this;
		}
		
		private function clearTimeout():void {
			if ( timeoutMonitor ) {
				timeoutMonitor.finished();
			}
		}

		private function handleEvent( event:Event ):void {
			actualEvents.push( event );

			//Think this is wrong... probably need to know we got the right amount
			//first???
			clearTimeout();

			if ( !multiMatcher.matches( actualEvents ) ) {
				notifyFailure( describeMismatch( actualEvents, multiMatcher ) );
			} else {
				if ( methodToCallStack ) {
					for ( var i:int=0; i<methodToCallStack.length; i++ ) {
						methodToCallStack[ i ]( event );
					}
				}
				performAggressiveVerification();
			}
			
		}
		
		private function cleanUp():void {
			if ( timeoutMonitor ) {
				timeoutMonitor.finished();
			}

			if ( typeName && ( typeName.length > 0 ) ) {
				this.target.removeEventListener( typeName, handleEvent );
			}
		}

		private function performAggressiveVerification():void {
			quantityMatcher.matches( actualEvents.length );
			
			if ( quantityMatcher.resolved ) {
				if ( quantityMatcher.passed ) {
					notifyPass();
				} else if ( quantityMatcher.failed ) {
					notifyFailure( describeMismatch( actualEvents.length, quantityMatcher ) );
				}
			}
		}

		public function verify():void {
			var failureString:String;
			
			if ( timeoutMonitor && timeoutMonitor.expired ) {
				fail( "Timeout Ocurred before event(s)" );
			} else {
				if ( timeoutMonitor ) {
					timeoutMonitor.finished();
				}

				if ( !quantityMatcher.matches( actualEvents.length ) ) {
					fail( describeMismatch( actualEvents.length, quantityMatcher ) );
				} else if ( !multiMatcher.matches( actualEvents ) ) {
					fail( describeMismatch( actualEvents, multiMatcher ) );
				}
			}

			cleanUp();
		}
		
		private function describeMismatch( actual:Object, matcher:Matcher ):String {
			var descriptionStr:String = "";

			if (!matcher.matches(actual)) {
				var description:Description = new StringDescription();
				
				description.appendText("Expected: ")
					.appendDescriptionOf(matcher)
					.appendText("\n     but: ")
				
				matcher.describeMismatch(actual, description);
				
				descriptionStr = description.toString();
			}
			
			return descriptionStr;
		}

		public function EventExpectations( target:IEventDispatcher, rule:IMethodRule ) {
			this.target = target;
			this.rule = rule;
			this.multiMatcher = new MultiMatcher();
			
			//Create a default matcher which is expecting the event to occur any number of times.
			this.quantityMatcher = new QuantityMatcher();
			this.quantityMatcher.atLeast(1);
			
			this.actualEvents = new Array();
		}
	}
}