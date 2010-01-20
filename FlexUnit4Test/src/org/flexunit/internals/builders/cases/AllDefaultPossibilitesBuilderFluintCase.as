package org.flexunit.internals.builders.cases
{
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.builders.FlexUnit1Builder;
	import org.flexunit.internals.builders.Fluint1Builder;
	import org.flexunit.internals.builders.definitions.Fluint1Class;
	import org.flexunit.internals.builders.definitions.Fluint1Suite;
	import org.flexunit.internals.runners.Fluint1ClassRunner;
	
	public class AllDefaultPossibilitiesBuilderFluintCase extends AllDefaultPossibilitiesBuilder
	{
		
		private var fluint1Class:Fluint1Class;
		private var fluint1Suite:Fluint1Suite;

		public function AllDefaultPossibilitiesBuilderFluintCase() {
			super( false );
		}
		
		[Test(description="Ensure flexUnit1Builder returns a type of FlexUnit1Builder")]
		public function testFlexUnit1Builder() : void {
			Assert.assertTrue( flexUnit1Builder() is FlexUnit1Builder );
		}
		
		
		[Test(description="Ensure if a Fluint1 style class is passed to runnerForClass a Fluint1ClassRunner is returned")]
		public function testFluint1TestRunnerForClass() : void {
			var runner:IRunner;
			runner = runnerForClass( Fluint1Class );
			Assert.assertTrue( runner is Fluint1ClassRunner );
		}
		
		[Test(description="Ensure if a Fluint1 style suite is passed to runnerForClass a Fluint1ClassRunner is returned")]
		public function testFluint1SuiteRunnerForClass() : void {
			var runner:IRunner;
			runner = runnerForClass( Fluint1Suite );
			Assert.assertTrue( runner is Fluint1ClassRunner );
		}
		
		[Test(description="Ensure fluint1Builder returns the proper type")]
		public function testFluint1Builder() : void {
			try {
				Assert.assertTrue( fluint1Builder() is Fluint1Builder );
			} catch ( error : AssertionFailedError ) {
				Assert.assertTrue( fluint1Builder is NullBuilder );
			}
		}
	}
}