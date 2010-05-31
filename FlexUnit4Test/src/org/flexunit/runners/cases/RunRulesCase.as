package org.flexunit.runners.cases {
	import org.flexunit.runners.cases.stub.SynchronousRule;
	import org.flexunit.runners.cases.stub.AsynchronousRule;

	public class RunRulesCase {
		[Rule]
		public var rule1:SynchronousRule = new SynchronousRule();
		
		[Rule]
		public var rule2:AsynchronousRule = new AsynchronousRule( 5000 );
		
		[Test]
		public function test1():void {
			trace("test1");
		}

		[Test]
		public function test2():void {
			trace("test2");
		}
	}
}