package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.MetaDataBuilder;
	import org.flexunit.internals.builders.cases.helper.ChildClassNoRunWith;
	import org.flexunit.internals.builders.definitions.FlexUnit4SuiteClass;
	import org.flexunit.internals.builders.definitions.FlexUnit4SuiteClassFail;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.ParentRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;
	import org.flexunit.runners.model.mocks.RunnerBuilderMock;
	
	public class MetaDataBuilderCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var metaDataBuilder:MetaDataBuilder;
		protected var runnerBuilderMock:RunnerBuilderMock;
		
		[Before(description="Create an instance of the MetaDataBuilder class")]
		public function createMetaDataBuilder():void {
			runnerBuilderMock = new RunnerBuilderMock();
			metaDataBuilder = new MetaDataBuilder(runnerBuilderMock);
		}
		
		[After(description="Remove the reference to the instance of the MetaDataBuilder class")]
		public function destroyMetaDataBuilder():void {
			metaDataBuilder = null;
			runnerBuilderMock = null;
		}

		[Test(description="Ensure the runner can handle a real runWith class")]
		public function canHandleClassRight() : void {
			Assert.assertTrue( metaDataBuilder.canHandleClass( FlexUnit4SuiteClass ) );
		}
		
		[Test(description="Ensure the runner doesn't handle a non runWith class")]
		public function canHandleClassWrong() : void {
			Assert.assertFalse( metaDataBuilder.canHandleClass( Object ) );
		}

		[Ignore]
		[Test(description="Ensure that the runnerForClass function returns an IRunner if the klass has 'RunWith' metadata")]
		public function runnerForClassIRunnerTest():void {
			Assert.assertTrue( metaDataBuilder.runnerForClass(FlexUnit4SuiteClass) is IRunner );
		}
		
		[Ignore(description="This will need to be moved elsewhere, since it should actually be testing for no class path as the first argument to the annotation.")]
		[Test(description="Ensure that the runnerForClass function fails if the klass has 'RunWith' metadata and the class path for the runner is not included as the first argument to the annotation.",
			expects="org.flexunit.internals.runners.InitializationError")]
		public function runnerForClassIRunnerTestFail():void {
			metaDataBuilder.runnerForClass(FlexUnit4SuiteClassFail);
		}

		[Test(description="Ensure that runner can be found if it is only on a parent class")]
		public function runnerForClassWhereTagDefinedOnParent():void {
			var myBuilder:IRunnerBuilder = new MetaDataBuilder( new RunnerBuilderBase() );
			Assert.assertTrue( myBuilder.runnerForClass(ChildClassNoRunWith) is IRunner );
		}

		//TODO: How would a successful series of tests be created for this function
		[Ignore (description="This test is not completed.")]
		[Test]
		public function buildRunnerTest():void {
			
		}
	}
}