package org.fluint.sequence.cases
{
	import org.flexunit.Assert;
	import org.flexunit.async.mocks.EventDispatcherMock;
	import org.fluint.sequence.SequenceCaller;

	public class SequenceCallerCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly.
		//The execute method tests need to be correctly written.
		protected var generateArgsArray:Array = [7,2,9];
		protected var generateArgsCalled:int = 0;
		protected var methodCalled:int = 0;
		
		[Test(description="Ensure that the target property is correctly obtained")]
		public function getTargetTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = new Array();
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			Assert.assertEquals( target, sequenceCaller.target );
		}
		
		[Test(description="Ensure that the method property is correctly obtained")]
		public function getMethodTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = new Array();
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			Assert.assertEquals( method, sequenceCaller.method );
		}
		
		[Test(description="Ensure that the args property is correctly obtained")]
		public function getArgsTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = new Array();
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			Assert.assertEquals( args, sequenceCaller.args );
		}
		
		[Test(description="Ensure that the argsFunction property is correctly obtained")]
		public function getArgsFunctionTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = new Array();
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			Assert.assertEquals( argsFunction, sequenceCaller.argsFunction );
		}
		
		[Test(description="Ensure that the execute function works correctly when the args array is null but the argsFunction is not null")]
		public function executeWithNullArgsTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = null;
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			var returnArray:Array = [7,2,9];
			
			//argsFunction.mock.method("call").withAnyArgs.once.returns(returnArray);
			//method.mock.method("apply").withArgs(target, returnArray).once;
				
			sequenceCaller.execute();
			
			//argsFunction.mock.verify();
			//method.mock.verify();
		}
		
		[Ignore]
		[Test(description="Ensure that the execute function works correctly when both the args array and argsFunction are null")]
		public function executeWithNullArgsAndArgsFunctionTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = null;
			var args:Array = null;
			var argsFunction:Function = null;
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			//method.mock.method("apply").withArgs(target).once;
			
			sequenceCaller.execute();
			
			//method.mock.verify();
		}
		
		[Test(description="Ensure that the execute function works correctly when the args array is not empty")]
		public function executeWithNonEmptyArgsTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = [3,4,3];
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			//method.mock.method("apply").withArgs(target, args).once;
			
			sequenceCaller.execute();
			
			//method.mock.verify();
		}
		
		[Test(description="Ensure that the execute function works correctly when the args array is empty")]
		public function executeWithArgsTest():void {
			var target:EventDispatcherMock = new EventDispatcherMock();
			var method:Function = new Function();
			var args:Array = new Array();
			var argsFunction:Function = new Function();
			var sequenceCaller:SequenceCaller = new SequenceCaller(target, method, args, argsFunction);
			
			//method.mock.method("apply").withArgs(target).once;
			
			sequenceCaller.execute();
			
			//method.mock.verify();
		}
		
		protected function generateArgs():Array {
			return [7,2,9];
		}
		
		protected function methodFunctionWithArgs(args:Array):void {
			methodCalled++;
			
			Assert.assertEquals( generateArgsArray, args );
		}
		
		protected function methodFunctionNoArgs(args:Array):void {
			methodCalled++;
			
			//There souldn't be an arg array
			Assert.assertNull(args);
		}
	}
}