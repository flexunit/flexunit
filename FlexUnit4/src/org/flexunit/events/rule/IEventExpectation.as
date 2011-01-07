package org.flexunit.events.rule {
	public interface IEventExpectation {
		function never():IEventExpectation;
		function once():IEventExpectation;
		function twice():IEventExpectation;
		function thrice():IEventExpectation;
		function times( value:Number ):IEventExpectation;
		function atLeast( value:Number ):IEventExpectation;
		function atMost( value:Number ):IEventExpectation;
		function greaterThan( value:Number ):IEventExpectation;
		function greaterThanOrEqualTo( value:Number ):IEventExpectation;
		function lessThan( value:Number ):IEventExpectation;
		function lessThanOrEqualTo( value:Number ):IEventExpectation;
		function instanceOf( eventType:Class ):IEventExpectation;
		function hasType( typeName:String ):IEventExpectation;
		function calls( method:Function ):IEventExpectation;
		function withTimeout( value:Number ):IEventExpectation;

		function hasPropertyWithValue( propertyName:String, valueOrMatcher:* ):IEventExpectation;
		function hasProperties( value:Object ):IEventExpectation;

		function verify():void;
	}
}