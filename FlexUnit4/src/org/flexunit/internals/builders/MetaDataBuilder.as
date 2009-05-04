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
	import flash.utils.getDefinitionByName;
	
	import flex.lang.reflect.Klass;
	
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;

	public class MetaDataBuilder extends RunnerBuilderBase {
		public static const RUN_WITH:String = "RunWith";
		private var suiteBuilder:IRunnerBuilder;

		override public function runnerForClass( testClass:Class ):IRunner {
			var klassInfo:Klass = new Klass( testClass );

			if ( klassInfo.hasMetaData( RUN_WITH ) ) {
				var runWithValue:String = klassInfo.getMetaData( RUN_WITH ); 
				return buildRunner( runWithValue, testClass);
			}
			
			return null;
		}

		public function buildRunner( runnerClassName:String, testClass:Class ):IRunner {
			try {
				//Need to check if it actually implements IRunner
				var runnerClass:Class = getDefinitionByName( runnerClassName ) as Class;
				return new runnerClass( testClass );
			} catch ( e:Error ) {
				try {
					return new runnerClass( testClass, suiteBuilder );
				} catch (e:Error ) {
					throw new InitializationError( "Custom runner class " + runnerClassName + " should be linked into project and implement IRunner. Further it needs to have a constructor which either just accepts the class, or the class and a builder." );
				}
			}
 
 			return null;
		}

		public function MetaDataBuilder( suiteBuilder:IRunnerBuilder ) {
			super();
			this.suiteBuilder = suiteBuilder;
		}
	}
}