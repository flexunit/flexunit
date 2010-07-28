package org.hamcrest.mxml
{
	import flash.events.Event;
	
	import mockolate.runner.MockolateRunner; MockolateRunner;
	import mockolate.stub;
	
	import org.flexunit.async.Async;
	import org.hamcrest.core.anything;

	[RunWith("mockolate.runner.MockolateRunner")]
	public class BaseMXMLMatcherContainerTest
	{		
		public var matcher:BaseMXMLMatcherContainer;
		
		[Mock]
		public var child1:BaseMXMLMatcher;
		
		[Mock]
		public var child2:BaseMXMLMatcher;
		
		[Before]
		public function setup():void
		{
			matcher = new BaseMXMLMatcherContainerForTesting();
			matcher.matchers = [ child1, child2 ];
		}
		
		[Test(async)]
		public function shouldInvalidateItselfWhenAnyChildMatchedPropertyChanges():void 
		{
			stub(child1).asEventDispatcher();
			stub(child1).method("matches").args(anything()).returns(false);
			stub(child2).asEventDispatcher();
			stub(child2).method("matches").args(anything()).returns(true);
			
			Async.proceedOnEvent(this, matcher, "matchedChanged");
			
			child2.dispatchEvent(new Event("matchedChanged"));
		}
	}
}

import org.hamcrest.Matcher;
import org.hamcrest.core.anyOf;
import org.hamcrest.core.describedAs;
import org.hamcrest.mxml.BaseMXMLMatcherContainer;

internal class BaseMXMLMatcherContainerForTesting extends BaseMXMLMatcherContainer
{
	override protected function createMatcher():Matcher
	{
		return describedAs("BaseMXMLMatcherCompositeForTesting", anyOf(matchers));
	}
}
