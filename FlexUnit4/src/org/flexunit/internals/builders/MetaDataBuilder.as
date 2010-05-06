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
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * The <code>MetaDataBuilder</code> potentially builds an <code>IRunner</code> runner that is specificed
	 * in the metadata tag for a specific test class.  If no metadata tag is present or the <code>IRunner</code>
	 * fails to build, no <code>IRunner</code> will be generated.  If a test class wants to use a defined
	 * <code>IRunner</code>, it should include the [RunWith] tag that lists the full class name of
	 * the <code>IRunner</code>.<br/>
	 * 
	 * The <code>MetaDataBuilder</code> provides a hug hook for extensibility, allowing many different types of
	 * <code>IRunner</code>s to be created and used to run tests.<br/>
	 * 
	 * <pre><code>
	 * [RunWith("org.flexunit.runners.Suite")]
	 * public class testSuite {
	 * 	[Test]
	 * 	public function testMe():void { ...
	 * 	}
	 * }</code></pre><br/>
	 * 
	 * The <code>IRunner</code> that is to be built by the <code>MetaDataBuilder</code> should have a constructor 
	 * implemented in one of the two following manners:<br/>
	 * 
	 * <pre><code>
	 * public function RunnerClass( testClass:Object ) { ...
	 * }
	 * </code></pre><br/>
	 * 
	 * Where testClass is the class to be run.<br/>
	 * 
	 * <pre><code>
	 * public function RunnerClass( testClass:Object, suiteBuilder:IRunnerBuilder ) { ...
	 * }
	 * </code></pre><br/>
	 * 
	 * Where testClass is the class to be run and suiteBuilder is an <code>IRunnerBuilder</code>.
	 */
	public class MetaDataBuilder extends RunnerBuilderBase {
		public static const RUN_WITH:String = "RunWith";
		/**
		 * @private
		 */
		private static const CLASS_NOT_FOUND:String = "classNotFound";
		/**
		 * @private
		 */
		private static const INVALID_CONSTRUCTOR_ARGS:String = "invalidConstructorArguments";
		/**
		 * @private
		 */
		private static const UNSPECIFIED:String = "unspecified";
		
		/**
		 * @private
		 */
		private var suiteBuilder:IRunnerBuilder;
		
		private function lookForMetaDataThroughInheritance( testClass:Class, metadata:String ):MetaDataAnnotation {
			var klassInfo:Klass = new Klass( testClass );
			var ancestorInfo:Klass;
			var annotation:MetaDataAnnotation;

			annotation = klassInfo.getMetaData( metadata );
			
			if ( !annotation ) {
				var inheritance:Array = klassInfo.classInheritance;

				for ( var i:int=0; i<inheritance.length; i++ ) {
					ancestorInfo = new Klass( inheritance[ i ] );
					annotation = ancestorInfo.getMetaData( metadata );
					
					if ( annotation ) {
						break;
					}
				}
			}
			
			return annotation;
		}
		
		override public function canHandleClass( testClass:Class ):Boolean {
			var annotation:MetaDataAnnotation = lookForMetaDataThroughInheritance( testClass, RUN_WITH );
			
			return ( annotation != null );
		}
		
		/**
		 * Returns an <code>IRunner</code> based on the metadata of the provided <code>testClass</code>.
		 * 
		 * @param testClass The test class for which to find an <code>IRunner</code>.
		 * 
		 * @return an <code>IRunner</code> for the provided <code>testClass</code> if it has proper metadata and is 
		 * successfully built; otherwise, returns a value of <code>null</code>.
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			var klassInfo:Klass = new Klass( testClass );
			
			//Determine if the testClass references a runner in its metadata
			//Get the definition for the runner class
			var runWithValue:String = ""; 
			var runWithAnnotation:MetaDataAnnotation = lookForMetaDataThroughInheritance( testClass, RUN_WITH );
				
			if ( runWithAnnotation && runWithAnnotation.defaultArgument ) {
				runWithValue = runWithAnnotation.defaultArgument.key;
			}

			return buildRunner( runWithValue, testClass);
		}
		
		/**
		 * Builds an <code>IRunner</code> based on a <code>runnerClassName</code> for the provided <code>testClass</code>.
		 * 
		 * @param runnerClassName The name of the runner to be used for the provided <code>testClass</code>.
		 * @param testClass The test class to provide to the builder.
		 * 
		 * @return an <code>IRunner</code> for the provided <code>testClass</code> if it has proper metadata and is 
		 * successfully built; otherwise, returns a value of <code>null</code>.
		 * 
		 * @throws org.flexunit.internals.runners.InitializationError Thrown if there is an issue when building the 
		 * <code>IRunner</code>.
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
		
		/**
		 * Builds an <code>IRunner</code> based on a <code>runnerClass</code> for the provided <code>testClass</code>.  
		 * This method is typically called if the runner did not successfully build with its first signature.
		 * 
		 * @param runnerClass The runner class used to run the provided <code>testClass</code>.
		 * @param testClass The test class to provide to the builder.
		 * @param runnerClassName The name of the runner to be used for the provided <code>testClass</code>.
		 * 
		 * @return an <code>IRunner</code> for the provided <code>testClass</code> if it has proper metadata and is 
		 * successfully built; otherwise, returns a value of <code>null</code>.
		 * 
		 * @throws org.flexunit.internals.runners.InitializationError Thrown if there is an issue when building the 
		 * <code>IRunner</code>.
		 */
		private function buildWithSecondSignature( runnerClass:Class, testClass:Class, runnerClassName:String ):IRunner {
			try {
				return new runnerClass( testClass, suiteBuilder );
			} catch ( e:Error ) {
				if ( e is InitializationError ) {
					throw e;
				} else {
					throw createInitializationError( UNSPECIFIED, runnerClassName );
				}
			}
			
			return null;
		}
		
		/**
		 * Creates an <code>InitializationError</code> for a specific <code>reason</code> caused by the attempted initialization
		 * of an <code>IRunner</code> that is named <code>runnerClassName</code>.
		 * 
		 * @param reason The reason that the initialization error occured.
		 * @param runnerClassName The name of the runner class that caused the initialization issue.
		 * 
		 * @return an <code>InitializationError</code>.
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
		 * @param suiteBuilder An <code>IRunnerBuilder</code> to use to build the runner if the runner expects
		 * the test class as its first argument and a <code>IRunnerBuilder</code> as its second argument.
		 */
		public function MetaDataBuilder( suiteBuilder:IRunnerBuilder ) {
			super();
			this.suiteBuilder = suiteBuilder;
		}
	}
}