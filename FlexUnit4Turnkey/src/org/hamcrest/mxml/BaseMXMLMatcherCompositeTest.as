package org.hamcrest.mxml
{
	import flash.events.Event;
	
	import mockolate.runner.MockolateRunner; MockolateRunner;
	import mockolate.stub;
	
	import org.flexunit.async.Async;
	import org.hamcrest.Matcher;
	import org.hamcrest.core.anything;

	[RunWith("mockolate.runner.MockolateRunner")]
	public class BaseMXMLMatcherCompositeTest
	{	
		public var matcher:BaseMXMLMatcherComposite;
		
		[Mock]
		public var child:BaseMXMLMatcher;
		
		[Before]
		public function setup():void 
		{
			matcher = new BaseMXMLMatcherCompositeForTesting();
			matcher.matcher = child;
		}
						
		[Test(async)]
		public function shouldInvalidateItselfWhenChildMatchedPropertyChanges():void 
		{
			stub(child).asEventDispatcher();
			stub(child).method("matches").args(anything()).returns(true);
			
			Async.proceedOnEvent(this, matcher, "matchedChanged");
			
			child.dispatchEvent(new Event("matchedChanged"));
		}
	}
}

import org.hamcrest.Matcher;
import org.hamcrest.core.describedAs;
import org.hamcrest.mxml.BaseMXMLMatcherComposite;

internal class BaseMXMLMatcherCompositeForTesting extends BaseMXMLMatcherComposite
{
	override protected function createMatcher():Matcher
	{
		return describedAs("BaseMXMLMatcherCompositeForTesting", matcher);
	}
}
