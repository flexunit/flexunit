package org.flexunit.events.rule {
	import org.hamcrest.BaseMatcher;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	import org.hamcrest.TypeSafeMatcher;
	import org.hamcrest.collection.EveryMatcher;
	import org.hamcrest.core.AllOfMatcher;
	
	public class MultiMatcher extends BaseMatcher {
		private var childMatchers:Array;
		private var everyMatcher:Matcher;
		
		public function addChildMatcher( matcher:Matcher ):void {
			childMatchers.push( matcher );
		}
		
		override public function matches( events:Object ):Boolean {
			var allMatcher:Matcher;
			var eventsArray:Array = events as Array;
			var matchee:Object;
			
			//If we have no matchers, just keep going
			if ( childMatchers.length == 0 ) {
				return true;
			}
			
			if ( childMatchers.length > 1 ) {
				allMatcher = new AllOfMatcher( childMatchers ); 
			} else {
				allMatcher = childMatchers[ 0 ];
			}

			if ( eventsArray && eventsArray.length > 1 ) {
				everyMatcher = new EveryMatcher( allMatcher );
				matchee = events;
			} else {
				everyMatcher = allMatcher;
				matchee = eventsArray[ 0 ];
			}
			
			return everyMatcher.matches( matchee );
		}
		
		override public function describeTo(description:Description):void {
			description.appendText("is ").appendDescriptionOf( everyMatcher );
		}
		
		/**
		 * Pass-through to the decorated matcher.
		 */
		override public function describeMismatch(item:Object, mismatchDescription:Description):void {
			everyMatcher.describeMismatch(item, mismatchDescription);
		}
		
		public function MultiMatcher() {
			super();
			this.childMatchers = new Array();
		}
	}
}