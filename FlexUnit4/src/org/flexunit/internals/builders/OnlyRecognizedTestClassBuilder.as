package org.flexunit.internals.builders {
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	public class OnlyRecognizedTestClassBuilder extends AllDefaultPossibilitiesBuilder {
		private var builders:Array;
		
		public function OnlyRecognizedTestClassBuilder(canUseSuiteMethod:Boolean = true ) {
			super(canUseSuiteMethod);
			builders = buildBuilders();
		}

		public function qualify(testClass:Class):Boolean {
			
			//loop through the builders testing against the testClass passed in
			//If a builder is found return true(so it will then stay in the array
			//in QualifyingRequest
			//otherwise return false so we can remove it.
			for ( var i:int=0; i<builders.length; i++ ) {
				var builder:IRunnerBuilder = builders[ i ];		
				
				if (builder.canHandleClass( testClass ) )
					return true;
			}
			
			return false;
		}
		
		override protected function flexUnit4Builder():FlexUnit4Builder {
			return new FlexUnit4QualifiedBuilder();
		}
	}
}