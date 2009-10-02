package org.flexunit.internals.runners.statements.cases
{
	import org.flexunit.internals.runners.statements.SequencerWithDecoration;

	public class SequencerWithDecorationCase
	{
		//TODO: This entire test case needs to be created.  Does the handleChildExecuteComplete method need to be called in order to
		//test the overriden function?  Since myToken is created, how do we test the catch part of the try catch statment of executeStep?
		
		protected var sequencerWithDecoration:SequencerWithDecoration;
		protected var afters:Array;
		protected var target:Object;
		
		[Before(description="Create an instance of the SequncerWithDecoration class")]
		public function createSequencerWithDecoration():void {
			afters = new Array();
			target = new Object();
			sequencerWithDecoration = new SequencerWithDecoration(afters, target);
		}
		
		[After(description="Remove the reference to the SequncerWithDecoration class")]
		public function destroySequencerWithDecoration():void {
			sequencerWithDecoration = null;
			target= null;
			afters = null;
		}
		
		[Test(description="Ensure that teh executeStep function correctly works when no exception is thrown")]
		public function executeStepNoErrorTest():void {
			
		}
		
		[Test(description="Ensure that teh executeStep function correctly works when an exception is thrown")]
		public function executeStepErrorTest():void {
			
		}
	}
}