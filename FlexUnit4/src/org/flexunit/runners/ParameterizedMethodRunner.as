/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.runners.model.ParameterizedMethod;
	import org.flexunit.token.AsyncTestToken;

	public class ParameterizedMethodRunner extends BlockFlexUnit4ClassRunner {
		private var klassInfo:Klass;
		private var expandedTestList:Array;
		private var parameterSetNumber:int;
		private var parameterList:Array;
		private var constructorParameterized:Boolean = false;

		private function buildExpandedTestList():Array {
			var testMethods:Array = testClass.getMetaDataMethods( "Test" );
			var finalArray:Array = new Array();
			
			for ( var i:int=0; i<testMethods.length; i++ ) {
				var fwMethod:FrameworkMethod = testMethods[ i ];
				var argument:MetaDataArgument = fwMethod.method.getMetaData( "Test" ).getArgument( "dataProvider" );
				var classMethod:Method;
				var results:Array;
				var paramMethod:ParameterizedMethod;

				if ( argument ) {
					classMethod = klassInfo.getMethod( argument.value ); 
					results = classMethod.invoke( testClass ) as Array;
					
					for ( var j:int=0; j<results.length; j++ ) {
						paramMethod = new ParameterizedMethod( fwMethod.method, results[ j ] );
						finalArray.push( paramMethod ); 	
					}
				} else {
					finalArray.push( fwMethod );
				}
			}
			
			return finalArray;
		}
		
		override protected function computeTestMethods():Array {
			//OPTIMIZATION POINT
			
			if ( !expandedTestList ) {
				expandedTestList = buildExpandedTestList();
			}
			return expandedTestList; 
		}
		
		override protected function validatePublicVoidNoArgMethods( metaDataTag:String, isStatic:Boolean, errors:Array ):void {
			
			//Only validate the ones that do not have a dataProvider attribute for these rules
			var methods:Array = testClass.getMetaDataMethods( metaDataTag  );
			var argument:MetaDataArgument;

			var eachTestMethod:FrameworkMethod;
			for ( var i:int=0; i<methods.length; i++ ) {
				eachTestMethod = methods[ i ] as FrameworkMethod;

				//Does it have a dataProvider?
				argument = eachTestMethod.method.getMetaData( "Test" ).getArgument( "dataProvider" );
				
				//If there is an argument, we need to punt on verification of arguments until later when we know how many there actually are
				if ( !argument ) {
					eachTestMethod.validatePublicVoidNoArg( isStatic, errors );
				} 
			}
		}

		override protected function describeChild( child:* ):IDescription {
			if ( ( !constructorParameterized ) || ( child is ParameterizedMethod ) ) {
				return super.describeChild( child );
			}
			
			var params:Array = computeParams();
			var paramName:String = params.join ( "_" );
			var method:FrameworkMethod = FrameworkMethod( child );
			return Description.createTestDescription( testClass.asClass, method.name + '_' + paramName, method.metadata );
		}

		private function computeParams():Array {
			return parameterList?parameterList[parameterSetNumber]:null;
		}

		override protected function createTest():Object {
			var args:Array = computeParams();
			
			if ( args && args.length > 0 ) {
				return testClass.klassInfo.constructor.newInstanceApply( args );	
			} else {
				return testClass.klassInfo.constructor.newInstance();
			}
		}

		public function ParameterizedMethodRunner(klass:Class, parameterList:Array=null, i:int=0) {
			klassInfo = new Klass( klass );
			super(klass);

			this.parameterList = parameterList;
			this.parameterSetNumber = i;
			
			if ( parameterList && parameterList.length > 0 ) {
				constructorParameterized = true;
			}
		}
	}
}