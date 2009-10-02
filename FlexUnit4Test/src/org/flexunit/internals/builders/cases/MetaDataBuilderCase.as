package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.MetaDataBuilder;
	import org.flexunit.internals.builders.definitions.FlexUnit4SuiteClass;
	import org.flexunit.runner.IRunner;
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
			Assert.assertTrue( metaDataBuilder.runnerForClass(FlexUnit4SuiteClass) is IRunner );
		}
		
		//TODO: How would a successful series of tests be created for this function
		[Test]
		public function buildRunnerTest():void {
			
		}
	}
}