package org.flexunit.events.rule {
	import org.hamcrest.BaseMatcher;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.number.IsGreaterThanMatcher;
	import org.hamcrest.number.IsLessThanMatcher;
	import org.hamcrest.object.IsEqualMatcher;
	
	public class QuantityMatcher extends BaseMatcher {

		private var passOnGoodMatch:Boolean = false;
		private var failOnBadMatch:Boolean = false;
		private var resolvedState:int = 0;

		private var delegateMatcher:Matcher;
		private var immediatePassMatcher:Matcher;
		private var immediateFailMatcher:Matcher;
		
		public function get resolved():Boolean {
			return ( resolvedState != 0 );
		}

		public function get passed():Boolean {
			return ( resolvedState == 1 );
		}

		public function get failed():Boolean {
			return ( resolvedState == -1 );
		}

		private function potentiallyResolve( matched:Boolean, item:Object ):void {
			if ( matched && immediatePassMatcher ) {
				if ( immediatePassMatcher.matches( item ) ) {
					resolvedState = 1;
				}				
			} else if ( ( !matched ) && immediateFailMatcher ) {
				if ( immediateFailMatcher.matches( item ) ) {
					resolvedState = -1;
				}				
			}
		}

		private function setDelegateMatcher( matcher:Matcher, immediatePassMatcher:Matcher, immediateFailMatcher:Matcher ):void {
			delegateMatcher = matcher;

			this.immediatePassMatcher = immediatePassMatcher;
			this.immediateFailMatcher = immediateFailMatcher;
		}
		
		public function never():void {
			setDelegateMatcher( new IsEqualMatcher( 0 ), null, new IsGreaterThanMatcher( 0, false ) );
		} 
		
		public function once():void {
			setDelegateMatcher( new IsEqualMatcher( 1 ), null, new IsGreaterThanMatcher( 1, false ) );
		} 
		
		public function twice():void {
			setDelegateMatcher( new IsEqualMatcher( 2 ), null, new IsGreaterThanMatcher( 2, false ) );
		} 
		
		public function thrice():void {
			setDelegateMatcher( new IsEqualMatcher( 3 ), null, new IsGreaterThanMatcher( 3, false ) );
		} 
		
		public function times( value:Number ):void {
			setDelegateMatcher( new IsEqualMatcher( value ), null, new IsGreaterThanMatcher( value, false ) );
		} 
		
		public function atLeast( value:Number ):void {
			var matcher:Matcher = new IsGreaterThanMatcher( value, true );
			setDelegateMatcher( matcher, matcher, null );
		} 
		
		public function atMost( value:Number ):void {
			setDelegateMatcher( new IsLessThanMatcher( value, true ), null, new IsGreaterThanMatcher( value, false ) );
		} 
		
		public function greaterThan( value:Number ):void {
			var matcher:Matcher = new IsGreaterThanMatcher( value, false );
			setDelegateMatcher( matcher, matcher, null );
		} 
		
		public function greaterThanOrEqualTo( value:Number ):void {
			var matcher:Matcher = new IsGreaterThanMatcher( value, true );
			setDelegateMatcher( matcher, matcher, null );
		} 
		
		public function lessThan( value:Number ):void {
			setDelegateMatcher( new IsLessThanMatcher( value ), null, new IsGreaterThanMatcher( value, true ) );
		} 
		
		public function lessThanOrEqualTo ( value:Number ):void {
			setDelegateMatcher( new IsLessThanMatcher( value, true ), null, new IsGreaterThanMatcher( value, false ) );
		} 
		
		override public function matches(item:Object):Boolean {
			var matched:Boolean = true;

			if ( delegateMatcher ) {
				matched = delegateMatcher.matches( item );
				
				potentiallyResolve( matched, item );
			} 
			
			return matched;
		}
		
		/**
		 * When <code>matches</code> returns <code>false</code>, then <code>describeMismatch</code> should append to the given Description a description for why the match failed.
		 */
		override public function describeMismatch(item:Object, mismatchDescription:Description ):void {
			delegateMatcher.describeMismatch( item, mismatchDescription );
		}

		override public function describeTo(description:Description):void {
			delegateMatcher.describeTo( description );
		}

		/**
		 * Returns a description of this Matcher
		 */
		override public function toString():String {
			return String( delegateMatcher );
		}

		public function QuantityMatcher() {
			super();
		}
	}
}
