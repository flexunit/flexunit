/**
 * Copyright (c) 2010 Digital Primates
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
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