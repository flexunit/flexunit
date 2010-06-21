package org.flexunit.internals.builders {
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 *
	 * Unlike the<code>AllDefaultPossibilitiesBuilder</code> which always returns a test runner
	 * for a test by choosing the FlexUnit 4 builder as the default, this Builder only returns
	 * builders for recognized tests types.
	 * 
	 * @author mlabriola
	 * 
	 */
	public class OnlyRecognizedTestClassBuilder extends AllDefaultPossibilitiesBuilder {
		/**
		 * @private
		 */
		private var builders:Array;
		
		/**
		 * @inheritDoc
		 *  
		 */
		public function OnlyRecognizedTestClassBuilder(canUseSuiteMethod:Boolean = true ) {
			super(canUseSuiteMethod);
			builders = buildBuilders();
		}

		/**
		 *
		 * Determines if we can handle the class in this environment. In other words, is it a
		 * recognized type of test
		 *  
		 * @param testClass
		 * @return true if it is a test we can handle
		 * 
		 */
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
		
		/**
		 * @inheritDoc
		 *  
		 */
		override protected function flexUnit4Builder():FlexUnit4Builder {
			return new FlexUnit4QualifiedBuilder();
		}
	}
}