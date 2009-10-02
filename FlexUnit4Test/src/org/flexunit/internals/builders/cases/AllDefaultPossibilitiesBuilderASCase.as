package org.flexunit.internals.builders.cases
{
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.builders.FlexUnit1Builder;
	import org.flexunit.internals.builders.FlexUnit4Builder;
	import org.flexunit.internals.builders.IgnoredClassRunner;
	import org.flexunit.internals.builders.MetaDataBuilder;
	import org.flexunit.internals.builders.NullBuilder;
	import org.flexunit.internals.builders.SuiteMethodBuilder;
	import org.flexunit.internals.builders.definitions.FlexUnit1Class;
	import org.flexunit.internals.builders.definitions.FlexUnit4Class;
	import org.flexunit.internals.builders.definitions.Fluint1Class;
	import org.flexunit.internals.builders.definitions.Fluint1Suite;
	import org.flexunit.internals.builders.definitions.IgnoredClass;
	import org.flexunit.internals.runners.FlexUnit1ClassRunner;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	
	public class AllDefaultPossibilitiesBuilderASCase extends AllDefaultPossibilitiesBuilder
	{
		private var flexunit1Class:FlexUnit1Class;
		private var flexunit4Class:FlexUnit4Class;
		private var fluint1Class:Fluint1Class;
		private var fluint1Suite:Fluint1Suite;
		private var ignoredClass:IgnoredClass;
		
		[Test(description="Ensure if a FlexUnit1 style class is passed to runnerForClass a FlexUnit1ClassRunner is returned")]
		public function testIgnoreRunnerForClass() : void {
			var runner:IRunner;
			runner = runnerForClass( FlexUnit1Class );
			Assert.assertTrue( runner is FlexUnit1ClassRunner );
		}
		
		[Test(description="Ensure if a FlexUnit1 style class is passed to runnerForClass a BlockFlexUnit4ClassRunner is returned")]
		public function testFlexUnit4RunnerForClass() : void {
			var runner:IRunner;
			runner = runnerForClass( FlexUnit4Class );
			Assert.assertTrue( runner is BlockFlexUnit4ClassRunner );
		}
		
		[Test(description="Ensure if a class with [Ignore] metadata is passed to runnerForClass an IgnoredClassRunner is returned")]
		public function testIgnoredRunnerForClass() : void {
			var runner:IRunner;
			runner = runnerForClass( IgnoredClass );
			Assert.assertTrue( runner is IgnoredClassRunner );
		}
		
		[Test(description="Ensure that a runner always pulls a new instance")]
		public function testRunnerForClass() : void {
			Assert.assertNotNull( runnerForClass( new Object() as Class ) );
		}
		
		[Test(description="Ensure metaDataBuilder returns a type of MetaDataBuilder")]
		public function testMetaDataBuilder() : void {
			Assert.assertTrue( metaDataBuilder() is MetaDataBuilder );
		}
		
		[Test(description="Ensure suiteMethodBuilder returns the proper type")]
		public function testSuiteMethodBuilder() : void {
			try {
				Assert.assertTrue( suiteMethodBuilder() is SuiteMethodBuilder );
			} catch ( error : AssertionFailedError ) {
				Assert.assertTrue( suiteMethodBuilder() is NullBuilder );
			}
		}
		
		[Test(description="Ensure flexUnit1Builder returns a type of FlexUnit1Builder")]
		public function testFlexUnit1Builder() : void {
			Assert.assertTrue( flexUnit1Builder() is FlexUnit1Builder );
		}

		[Test(description="Ensure flexUnit4Builder returns the proper type")]
		public function testFlexUnit4Builder() : void {
			Assert.assertTrue( flexUnit4Builder() is FlexUnit4Builder );
		}

CONFIG::useFlexClasses
{	
		import org.flexunit.internals.builders.Fluint1Builder;
		import org.flexunit.internals.runners.Fluint1ClassRunner;
		
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
		
		//TODO: How can it be verified that it is currently in an AS only case?  CONFIG::useFlexClasses?
		[Test(description="Ensure fluint1Builder returns the proper type")]
		public function testFluint1Builder() : void {
			try {
				Assert.assertTrue( fluint1Builder() is Fluint1Builder );
			} catch ( error : AssertionFailedError ) {
				Assert.assertTrue( fluint1Builder is NullBuilder );
			}
		}
}		
		public function AllDefaultPossibilitiesBuilderASCase() {
			super( false );
		}
		
	}
}