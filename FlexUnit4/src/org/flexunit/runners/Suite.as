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
package org.flexunit.runners {
	import flex.lang.reflect.Klass;
	
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.notification.IRunNotifier;
	import org.flexunit.runners.model.IRunnerBuilder;
	import org.flexunit.token.AsyncTestToken;
	
//TODO: How do references to older JUnits compare to older FlexUnits?	
	/**
 	* Using <code>Suite</code> as a runner allows you to manually
 	* build a suite containing tests from many classes. It is the JUnit 4 equivalent of the JUnit 3.8.x
 	* static {@link junit.framework.Test} <code>suite()</code> method. To use it, annotate a class
 	* with <code>@RunWith(Suite.class)</code> and <code>@SuiteClasses(TestClass1.class, ...)</code>.
 	* When you run this class, it will run all the tests in all the suite classes.
 	*/
	public class Suite extends ParentRunner {
		private var _runners:Array;
			
		override protected function get children():Array {
			return _runners;
		}

		override protected function describeChild( child:* ):IDescription {
			return IRunner( child ).description;
		}

		override protected function runChild( child:*, notifier:IRunNotifier, childRunnerToken:AsyncTestToken ):void {
			IRunner( child ).run( notifier, childRunnerToken );
		}


		private static function getSuiteClasses( suite:Class ):Array {
			var klassInfo:Klass = new Klass( suite );
			var classRef:Class;
			var classArray:Array = new Array();

			for ( var i:int=0; i<klassInfo.fields.length; i++ ) {
				if ( !klassInfo.fields[ i ].isStatic ) {
					try {
						classRef = klassInfo.fields[i].type;
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

		/** This will either be passed a builder, followed by an array of classes... (when there is not root class)
		 *  Or it will be passed a root class and a builder.
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
			
			if ( !error ) {
				_runners = builder.runners( testClass, classArray );
			} else {
				throw new Error("Incorrectly formed arguments passed to suite class");
			}
		}
	}
}