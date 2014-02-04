package org.flexunit.runners.cases {
	import org.flexunit.runners.cases.stub.AsynchronousRule;
	import org.flexunit.runners.cases.stub.SynchronousRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class RunRulesCase {
		
		[Rule]
		public static var classRule1:SynchronousRule = new SynchronousRule();
		
		[Rule]
		public static var classRule2:AsynchronousRule = new AsynchronousRule( 50 );
		
		[Rule(order=12)]
		public var rule1:SynchronousRule = new SynchronousRule();

		[Rule]
		public var rule3:SynchronousRule = new SynchronousRule();

		[Rule(order=3)]
		public var rule2:AsynchronousRule = new AsynchronousRule( 50 );
		
		private static var rule1RunCount:int = 0;
		private static var rule2RunCount:int = 0;
		private static var rule3RunCount:int = 0;
		
		[AfterClass]
		public static function tearDownClass():void {
			assertThat( classRule1.counter, equalTo( 1 ) );
			assertThat( classRule2.counter, equalTo( 1 ) );
			assertThat( rule1RunCount, equalTo( 3 ) );
			assertThat( rule2RunCount, equalTo( 3 ) );
			assertThat( rule3RunCount, equalTo( 3 ) );
		}
		
		[Test]
		public function test1():void {
			validateTestRules();
			updateRunCounts();
		}

		[Test]
		public function test2():void {
			validateTestRules();
			updateRunCounts();
		}
		
		[Test]
		public function test3():void {
			validateTestRules();
			updateRunCounts();
		}
		
		private function updateRunCounts():void {
			rule1RunCount += rule1.counter;
			rule2RunCount += rule2.counter;
			rule3RunCount += rule3.counter;
		}
		
		private function validateTestRules():void {
			assertThat( rule1.counter, equalTo( 1 ) );
			assertThat( rule2.counter, equalTo( 1 ) );
			assertThat( rule3.counter, equalTo( 1 ) );
		}
	}
}