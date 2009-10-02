package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.FlexUnit4Builder;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	
	import org.flexunit.internals.builders.definitions.FlexUnit4Class;
	
	public class FlexUnit4BuilderCase extends FlexUnit4Builder
	{
		protected var t1 : FlexUnit4Class;
		
		[Test(description="Ensure that if a FlexUnit4 style class is passed we return a FlexUnit4 Runner")]
		public function testRunnerForClass() : void {
			Assert.assertTrue( runnerForClass( FlexUnit4Class ) is BlockFlexUnit4ClassRunner );
		}
	}
}