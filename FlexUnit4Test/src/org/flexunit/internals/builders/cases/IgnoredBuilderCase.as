package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.IgnoredBuilder;
	import org.flexunit.internals.builders.IgnoredClassRunner;
	import org.flexunit.internals.builders.definitions.FlexUnit4Class;
	import org.flexunit.internals.builders.definitions.IgnoredClass;
	
	public class IgnoredBuilderCase
	{
		protected var ignoredClass : IgnoredClass;
		protected var ignoredBuilder : IgnoredBuilder;
		
		[Before]
		public function setUp() : void {
			ignoredBuilder = new IgnoredBuilder();
		}
		
		[After]
		public function tearDown() : void {
			ignoredBuilder = null;
		}
		
		[Test]
		public function testRunnerForClassIgnore() : void {
			Assert.assertTrue( ignoredBuilder.runnerForClass( IgnoredClass ) is IgnoredClassRunner );
		}
		
		[Ignore("Need to rework this test")]
		[Test]
		public function testRunnerForClassNull() : void {
			Assert.assertNull( ignoredBuilder.runnerForClass( Object ) );
		}
	}
}