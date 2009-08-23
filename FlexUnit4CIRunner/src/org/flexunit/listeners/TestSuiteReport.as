package org.flexunit.listeners
{
	public class TestSuiteReport
	{
		public var name : String;
		public var errors : uint = 0;
		public var failures : uint = 0;
		public var tests : uint = 0;
		public var time : Number = 0;
		
		// TODO: [XB] this can be refactored to Vector
		// Vector< TextCaseReport >
		//Let's not do that, we don't want an FP10 dependency
		public var methods : Array = new Array()
	}
}