package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.MetaDataBuilder;
	import org.flexunit.internals.builders.definitions.FlexUnit4SuiteClass;
	import org.flexunit.internals.builders.definitions.FlexUnit4SuiteClassFail;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.ParentRunner;
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
		
		[Test(description="Ensure that the runnerForClass function returns null if the klass does not have 'RunWith' metadata")]
		public function runnerForClassNullTest():void {
			Assert.assertNull( metaDataBuilder.runnerForClass(Object) );
		}
		
		[Test(description="Ensure that the runnerForClass function returns an IRunner if the klass has 'RunWith' metadata")]
		public function runnerForClassIRunnerTest():void {
			runnerBuilderMock.mock.method("runners").withArgs( FlexUnit4SuiteClass, Array ).returns( [ new ParentRunner( null ) ] );
			Assert.assertTrue( metaDataBuilder.runnerForClass(FlexUnit4SuiteClass) is IRunner );
			runnerBuilderMock.mock.verify();
		}
		
		[Ignore(description="This will need to be moved elsewhere, since it should actually be testing for no class path as the first argument to the annotation.")]
		[Test(description="Ensure that the runnerForClass function fails if the klass has 'RunWith' metadata and the class path for the runner is not included as the first argument to the annotation.",
			expects="org.flexunit.internals.runners.InitializationError")]
		public function runnerForClassIRunnerTestFail():void {
			metaDataBuilder.runnerForClass(FlexUnit4SuiteClassFail);
		}
		
		//TODO: How would a successful series of tests be created for this function
		[Ignore (description="This test is not completed.")]
		[Test]
		public function buildRunnerTest():void {
			
		}
	}
}