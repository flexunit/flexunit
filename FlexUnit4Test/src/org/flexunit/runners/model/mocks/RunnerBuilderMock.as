package org.flexunit.runners.model.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	
	public class RunnerBuilderMock implements IRunnerBuilder
	{
		public var mock:Mock;
		
		public function canHandleClass( testClass:Class):Boolean {
			return mock.canHandleClass( testClass );
		}

		public function safeRunnerForClass(testClass:Class):IRunner
		{
			return mock.safeRunnerForClass(testClass);
		}
		
		public function runners(parent:Class, children:Array):Array
		{
			return mock.runners(parent, children);
		}
		
		public function runnerForClass(testClass:Class):IRunner
		{
			return mock.runnerForClass(testClass);
		}
		
		public function RunnerBuilderMock()
		{
			mock = new Mock(this);
		}
	}
}