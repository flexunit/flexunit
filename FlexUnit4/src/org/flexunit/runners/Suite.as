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
package org.flexunit.runners {
	import flex.lang.reflect.Klass;
	
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.manipulation.IFilterable;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.token.AsyncTestToken;
	
	/**
 	 * A <code>Suite</code> is an <code>IRunner</code> that contains test cases and other
	 * <code>Suites</code> to be run during the course of a test run.  The <code>Suite</code> is
	 * responsible for locating all non-static classes that it contains and obtaining an array of
	 * <code>IRunner</code>s for each child that was found in this manner.  The 
	 * <code>IRunnerBuilder</code> to be used to determine the runner for the child classes is
	 * provided to the <code>Suite</code> during its instantiation.<br/>
	 * 
	 * When a <code>Suite</code> goes to run a child, it is telling another <code>IRunner</code> to
	 * begin running, supplying the <code>IRunner</code> with an <code>IRunNotifier</code> in
	 * order to keep track of the test run.  An <code>AsyncTestToken</code> is also provided to
	 * the child <code>IRunner</code> in order to notify the <code>Suite</code> when the child has
	 * finished.<br/>
	 * 
	 * In order to declare a class as a suite class, the class must include a <code>[Suite]</code>
	 * and <code>[RunWith("org.flexunit.runners.Suite")]</code> metadata tag.  The 
	 * <code>[RunWith]</code> tag will instruct an <code>IRunnerBuilder</code> to use the
	 * <code>Suite</code> <code>IRunner</code> for the class.<br/>
	 * 
	 * <pre><code>
	 * [Suite]
	 * [RunWith("org.flexunit.runners.Suite")]
	 * public class SuiteToRun
	 * {
	 * 	public var oneTest:OneTest; //A Test
	 * 	public var anotherTest:AnotherTest; //Another Test
	 * 	public var differentSuite:DifferentSuite; //A Suite
	 * }
	 * </code></pre>
	 */
	public class Suite extends ParentRunner implements IFilterable {
		/**
		 * @private
		 */
		private var _runners:Array;
		
		/**
		 * @inheritDoc
		 */
		override protected function get children():Array {
			return _runners;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function describeChild( child:* ):IDescription {
			return IRunner( child ).description;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
			IRunner( child ).run( notifier, childRunnerToken );
		}
		
		/**
		 * Returns an array of non-static class feilds in the provided <code>suite</code> class.
		 * 
		 * @param suite The class to check for non-static class fields.
		 * 
		 * @return an array of non-static class feilds in the provided <code>suite</code> class.
		 */
		private static function getSuiteClasses( suite:Class ):Array {
			var klassInfo:Klass = new Klass( suite );
			var classRef:Class;
			var classArray:Array = new Array();
			
			var fields:Array = klassInfo.fields; 

			for ( var i:int=0; i<fields.length; i++ ) {
				if ( !fields[ i ].isStatic ) {
					try {
						classRef = fields[i].type;
						classArray.push( classRef ); 
					} catch ( e:Error ) {
						//Not sure who we should inform here yet. We will need someway of capturing the idea that this
						//is a missing class, but not sure where or how to promote that up the chain....if it is even possible
						//that we could have a missing class, given the way we are linking it
					}
				}
			}
			
			
			/***
			  <variable name="two" type="suite.cases::TestTwo"/>
			  <variable name="one" type="suite.cases::TestOne"/>

  			SuiteClasses annotation= klass.getAnnotation(SuiteClasses.class);
			if (annotation == null)
				throw new InitializationError(String.format("class '%s' must have a SuiteClasses annotation", klass.getName()));
			return annotation.value();
			 **/
			 //this needs to return the suiteclasses
			 return classArray;
		}

		/** 
		 * This will either be passed a builder, followed by an array of classes... (when there is not root class)
		 * Or it will be passed a root class and a builder.
		 * 
		 * So, the two signatures we are supporting are:
		 * 
		 * Suite( builder:IRunnerBuilder, classes:Array )
		 * Suite( testClass:Class, builder:IRunnerBuilder )
		 ***/ 
		public function Suite( arg1:*, arg2:* ) {
			var builder:IRunnerBuilder;
			var testClass:Class;
			var classArray:Array;
			var runnners:Array;
			var error:Boolean = false;
			
			if ( arg1 is IRunnerBuilder && arg2 is Array ) {
				builder = arg1 as IRunnerBuilder;
				classArray = arg2 as Array;
			} else if ( arg1 is Class && arg2 is IRunnerBuilder ) {
				testClass = arg1 as Class;
				builder = arg2 as IRunnerBuilder;
				classArray = getSuiteClasses(testClass);
			} else {
				error = true;
			}

			super( testClass );
			
			//Fix for FXU-51
			//Tests to see if suite actually has viable children. If it does not, it is considered an
			//initialization error
			if ( !error && classArray.length > 0) { //a class is specified as a Suite, and has children
				_runners = builder.runners( testClass, classArray );
			} else if ( !error && classArray.length == 0 ) {
				 throw new InitializationError("Empty test Suite!");
			} else {
				throw new Error("Incorrectly formed arguments passed to suite class");
			}
		}
	}
}