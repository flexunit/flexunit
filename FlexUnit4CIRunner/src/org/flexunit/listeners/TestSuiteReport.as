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
		public var methods : Array = new Array()
	}
}