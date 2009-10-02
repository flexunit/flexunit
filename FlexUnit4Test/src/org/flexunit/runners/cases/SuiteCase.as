package org.flexunit.runners.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.FlexUnit4Builder;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runners.Suite;

	public class SuiteCase
	{
		// TODO: Is this good enough?
		[Test]
		public function testRunnerClassesCreation():void {
			var s:Suite = new Suite( new FlexUnit4Builder(), [SuiteCase,SuiteCase] );
			var d:IDescription = s.description;
			Assert.assertNotNull( d );
		}
		
		// TODO: Is this good enough?
		// TODO: This is throwing an error do to being an empty test suite.
		[Ignore]
		[Test]
		public function testClassRunnerCreation():void {
			var s:Suite = new Suite( SuiteCase, new FlexUnit4Builder() );
			var d:IDescription = s.description;
			Assert.assertNotNull( d );
		}
		
		[Test(expects="org.flexunit.internals.runners.InitializationError")]
		public function testEmptySuite():void {
			var s:Suite = new Suite( new FlexUnit4Builder(), [] );
		}
		
		[Test(expects="Error")]
		public function testParamsError():void {
			var s:Suite = new Suite( [], [] );
		}
		
		// TODO: Do we test these here?
		
		[Test]
		public function testRun():void {
			// TODO: How do we test this?
		}
		
		[Test]
		public function testFilter():void {
			// TODO: How do we test this?
		}
		
		[Test]
		public function testFilterFails():void {
			// TODO: How do we test this?
		}
		
		[Test]
		public function testSort():void {
			// TODO: How do we test this?
		}
		
		[Test]
		public function testSortFails():void {
			// TODO: How do we test this?
		}
	}
}