package org.fluint.sequence.cases
{
	import org.fluint.sequence.SequenceRunner;
	
	import org.flexunit.Assert;
	import org.fluint.sequence.mocks.SequenceStepMock;

	public class SequenceRunnerCase
	{
		//TODO: Additional tests need to be written for this class
		
		protected var sequenceRunner:SequenceRunner;
		protected var testCase:Object;
		
		[Before(description="Create an instance of the SequenceRunner class")]
		public function createSequenceRunner():void {
			testCase = new Object();
			sequenceRunner = new SequenceRunner(testCase);
		}
		
		[After(description="Remove the reference to the instance of the SequenceRunner class")]
		public function destroySequenceRunner():void {
			sequenceRunner = null;
			testCase = null;
		}
		
		[Test(description="Ensure that the numberOfSteps property is correctly obtained")]
		public function getNumberOfStepsTest():void {
			var sequenceStepMockOne:SequenceStepMock = new SequenceStepMock();
			var sequenceStepMockTwo:SequenceStepMock = new SequenceStepMock();
			
			sequenceRunner.addStep(sequenceStepMockOne);
			sequenceRunner.addStep(sequenceStepMockTwo);
			
			Assert.assertEquals( 2, sequenceRunner.numberOfSteps );
		}
		
		[Test(description="Ensure that the getStep function retruns the correct step for the provided index parameter")]
		public function getStepTest():void {
			var sequenceStepMockOne:SequenceStepMock = new SequenceStepMock();
			var sequenceStepMockTwo:SequenceStepMock = new SequenceStepMock();
			
			sequenceRunner.addStep(sequenceStepMockOne);
			sequenceRunner.addStep(sequenceStepMockTwo);
			
			Assert.assertEquals( sequenceStepMockTwo, sequenceRunner.getStep(1) );
		}
		
		[Test(description="")]
		public function test():void {
			
		}
	}
}