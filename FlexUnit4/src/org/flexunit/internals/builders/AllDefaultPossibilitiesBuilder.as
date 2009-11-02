/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
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
	 * Used to determine what type of <code>IRunner</code> can be used to run a specific testClass.
	 * Each testClass will be compared to an array of <code>IRunner</code>s.  The first <code>IRunner</code>
	 * that can be used to run the testClass will be the <code>IRunner</code> that is selected.
	 */
	public class AllDefaultPossibilitiesBuilder extends RunnerBuilderBase {
		private var canUseSuiteMethod:Boolean;
		
		/**
		 * Constructor.
		 * 
		 * @param canUseSuiteMethod A Boolean value indicating whether a <code>SuiteMethodBuilder</code> can be used.
		 */
		public function AllDefaultPossibilitiesBuilder( canUseSuiteMethod:Boolean = true ) {
			this.canUseSuiteMethod= canUseSuiteMethod;
			super();
		}
		
		/**
		 * Returns an <code>IRunner</code> that can be used by a specific testClass.
		 * 
		 * @param testClass The test class that needs a runner.
		 * 
		 * @return a runner that can run the testClass, a null value will be returned if no suitable runner is found.
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			//Construct an array of potential builders, the array is ordered so that each potential testClass
			//will check against the appropriate builder in the correct order.
			var builders:Array = new Array(
					ignoredBuilder(),
					metaDataBuilder(),
					suiteMethodBuilder(),
					flexUnit1Builder(),
					fluint1Builder(),
					flexUnit4Builder());
			
			//Get a runner for the specific type of class
			for ( var i:int=0; i<builders.length; i++ ) {
				var builder:IRunnerBuilder = builders[ i ]; 
				var runner:IRunner = builder.safeRunnerForClass( testClass );
				//A suitable runner has been found, we are done
				if (runner != null)
					return runner;
			}
			return null;
		}
		
		/**
		 * Returns an <code>IgnoredBuilder</code>.
		 */
		protected function ignoredBuilder():IgnoredBuilder {
			return new IgnoredBuilder();
		}
		
		/**
		 * Returns a <code>MetaDataBuilder</code>.
		 */
		protected function metaDataBuilder():MetaDataBuilder {
			return new MetaDataBuilder(this);
		}
		
		/**
		 * If suite methods can be used, returns a <code>SuiteMethodBuilder</code>;
		 * otherwise, returns a <code>NullBuilder</code>.
		 */
		protected function suiteMethodBuilder():IRunnerBuilder {
			if (canUseSuiteMethod)
				return new SuiteMethodBuilder();

			return new NullBuilder();
		}		
		
		/**
		 * Returns a <code>FlexUnit1Builder</code>.
		 */
		protected function flexUnit1Builder():FlexUnit1Builder {
			return new FlexUnit1Builder();
		}
		
		/**
		 * If Flex classes are compiled into the swc, returns a <code>Fluint1Builder</code>;
		 * otherwise, returns a <code>NullBuilder</code>.
		 */
		protected function fluint1Builder():IRunnerBuilder {
			var runner:IRunnerBuilder;
			
			// We have a toggle in the compiler arguments so that we can choose whether or not the flex classes should
			// be compiled into the FlexUnit swc.  For actionscript only projects we do not want to compile the
			// flex classes since it will cause errors.
			CONFIG::useFlexClasses {
				runner = new Fluint1Builder();
			}
			
			//If the runner has not be set to a Fluint1Builder, set the runner to a NullBuilder
			if ( !runner ) {
				runner = new NullBuilder();
			}
			
			return runner;
		}		
		
		/**
		 * Returns a <code>FlexUnit4Builder</code>.
		 */
		protected function flexUnit4Builder():FlexUnit4Builder {
			return new FlexUnit4Builder();
		}

	}
}