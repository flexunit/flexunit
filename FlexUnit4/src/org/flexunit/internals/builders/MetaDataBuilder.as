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
	import flash.utils.getDefinitionByName;
	
	import flex.lang.reflect.Klass;
	
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * Builds a runner that is specificed in the metadata for a specific test class.
	 * 
	 * Example: Suite, Theory, ect.
	 */
	public class MetaDataBuilder extends RunnerBuilderBase {
		public static const RUN_WITH:String = "RunWith";
		private static const CLASS_NOT_FOUND:String = "classNotFound";
		private static const INVALID_CONSTRUCTOR_ARGS:String = "invalidConstructorArguments";
		private static const UNSPECIFIED:String = "unspecified";
		
		private var suiteBuilder:IRunnerBuilder;
		
		/**
		 * Returns an <code>IRunner</code> for the given test class based on the test class' metadata
		 * 
		 * @param testClass The test class that includes the runner metadata
		 * 
		 * @return an <code>IRunner</code> for the given test class if it has proper metadata and is successfully built; otherwise,
		 * returns a null value
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			var klassInfo:Klass = new Klass( testClass );
			
			//Determine if the testClass references a runner in its metadata
			if ( klassInfo.hasMetaData( RUN_WITH ) ) {
				//Get the definition for the runner class
				var runWithValue:String = klassInfo.getMetaData( RUN_WITH ); 
				return buildRunner( runWithValue, testClass);
			}
			
			return null;
		}
		
		/**
		 * Builds an <code>IRunner</code> based on a runner class name for the provided test class
		 * 
		 * @param runnerClassName The name of the runner to be used for the provided test class
		 * @param testClass The test class to provide to the builder
		 * 
		 * @return an <code>IRunner</code> for the given test class if it has proper metadata and is successfully built; otherwise,
		 * returns a null value
		 */
		public function buildRunner( runnerClassName:String, testClass:Class ):IRunner {
			try {
				//Need to check if it actually implements IRunner
				var runnerClass:Class = getDefinitionByName( runnerClassName ) as Class;
				return new runnerClass( testClass );
			} catch ( e:Error ) {
				if ( e is InitializationError ) {
					throw e;
				} else if ( e is ReferenceError ) {
					throw createInitializationError( CLASS_NOT_FOUND, runnerClassName );
				} else if ( ( e is TypeError ) || ( e is ArgumentError ) ) {
					if ( ( e.errorID == 1007 ) || ( e.errorID == 1063 ) ) {
						//our constructor params may be different, give it one more whirl
						return buildWithSecondSignature( runnerClass, testClass, runnerClassName );
					} else {
						throw createInitializationError( INVALID_CONSTRUCTOR_ARGS, runnerClassName );
					}
				}
				
				throw createInitializationError( UNSPECIFIED, runnerClassName );
			}
 
 			return null;
		}
		
		private function buildWithSecondSignature( runnerClass:Class, testClass:Class, runnerClassName:String ):IRunner {
			try {
				return new runnerClass( testClass, suiteBuilder );
			} catch ( e:Error ) {
				if ( e is InitializationError ) {
					throw e
				} else {
					throw createInitializationError( UNSPECIFIED, runnerClassName );
				}
			}
			
			return null;
		}
		
		/**
		 * Creates an <code>InitializationError</code> for a specific reason cause by a potential runner class
		 * 
		 * @param reason The reason that the initialization error occured
		 * @param runnerClassName The name of the runner class that caused the initialization issue
		 * 
		 * @return an <code>InitializationError</code>
		 */
		private function createInitializationError( reason:String, runnerClassName:String ):InitializationError {
			var error:InitializationError;
			
			//Determine why the runner failed to correctly build
			switch ( reason ) {
				case CLASS_NOT_FOUND: 
					error = new InitializationError( "Custom runner class " + runnerClassName + " should be linked into project and implement IRunner. Further it needs to have a constructor which either just accepts the class, or the class and a builder." );
				break;
				
				case INVALID_CONSTRUCTOR_ARGS:
					error = new InitializationError( "Custom runner class " + runnerClassName + " cannot be built with the specified constructor arguments." );
				break;

				default:
					error = new InitializationError( "Custom runner class " + runnerClassName + " cannot be instantiated" );
				break;
			}

			return error;	
		}
		
		/** 
		 * Constructor. 
		 * 
		 * @param suiteBuilder An <code>IRunnerBuilder</code>
		 */
		public function MetaDataBuilder( suiteBuilder:IRunnerBuilder ) {
			super();
			this.suiteBuilder = suiteBuilder;
		}
	}
}