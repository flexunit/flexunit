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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.internals.builders {
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;

	public class AllDefaultPossibilitiesBuilder extends RunnerBuilderBase {
		private var canUseSuiteMethod:Boolean;

		public function AllDefaultPossibilitiesBuilder( canUseSuiteMethod:Boolean = true ) {
			this.canUseSuiteMethod= canUseSuiteMethod;
			super();
		}

		override public function runnerForClass( testClass:Class ):IRunner {
			var builders:Array = new Array(
					ignoredBuilder(),
					metaDataBuilder(),
					suiteMethodBuilder(),
					flexUnit1Builder(),
					fluint1Builder(),
					flexUnit4Builder());
	
			for ( var i:int=0; i<builders.length; i++ ) {
				var builder:IRunnerBuilder = builders[ i ]; 
				var runner:IRunner = builder.safeRunnerForClass( testClass );
				if (runner != null)
					return runner;
			}
			return null;
		}
	
		protected function ignoredBuilder():IgnoredBuilder {
			return new IgnoredBuilder();
		}

		protected function metaDataBuilder():MetaDataBuilder {
			return new MetaDataBuilder(this);
		}

		protected function suiteMethodBuilder():IRunnerBuilder {
			if (canUseSuiteMethod)
				return new SuiteMethodBuilder();

			return new NullBuilder();
		}		
	
		protected function flexUnit1Builder():FlexUnit1Builder {
			return new FlexUnit1Builder();
		}
	
		protected function fluint1Builder():IRunnerBuilder {
			return new Fluint1Builder();
		}		

		protected function flexUnit4Builder():FlexUnit4Builder {
			return new FlexUnit4Builder();
		}

	}
}