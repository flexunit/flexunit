package org.flexunit.runners.model {
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.constants.AnnotationArgumentConstants;
	import org.flexunit.constants.AnnotationConstants;
	import org.flexunit.token.AsyncTestToken;

	/**
	 * Used to expand on the number of methods in a class in the presence of a TestNG style
	 * Parameterized runner where a Test is provided a dataProvider. One of these classes is
	 * constructed for each dataset 
	 *  
	 * @author mlabriola
	 * 
	 */	
	public class ParameterizedMethod extends FrameworkMethod {
		/**
		 * @private 
		 */
		private var _arguments:Array;

		/**
		 * Arguments to be passed to the test 
		 * @return an array of arguments to be applied
		 * 
		 */
		public function get arguments():Array {
			return _arguments;
		}

		/**
		 * 
		 * @inheritDoc
		 * 
		 */
		override public function get name():String {
			var paramName:String = _arguments.join ( "," );
			return method.name + ' (' + paramName + ')';
		}

		/**
		 * 
		 * @inheritDoc
		 * 
		 */
		override public function invokeExplosively( target:Object, ...params ):Object {
			applyExplosively( target, arguments );
			return null;
		}
		
		/**
		 * Produces a new method with modified order metadata to ensure a consistent order of
		 * execution as compared to the data set order
		 * 
		 * @param method the existing method which needs expansion
		 * @param methodIndex Current Index into the data set of this ParameterizedMethod
		 * @param totalMethods total number of methods needed by the data set
		 * @return a new Method
		 * 
		 */
		protected function methodWithGuaranteedOrderMetaData( method : Method, methodIndex : int, totalMethods : int ) : Method {
			var newMethod:Method = method.clone();

			// CJP: If the method doesn't contain a "TEST" metadata tag, we probably shouldn't be in  here anyway... throw Error?
			var annotation:MetaDataAnnotation = newMethod.getMetaData( AnnotationConstants.TEST );
			var arg:MetaDataArgument;
			var arguments:Array;

			var orderValueDec : Number = ( methodIndex + 1) / ( Math.pow( 10, totalMethods ) );

			if ( annotation ) {
				arg = annotation.getArgument( AnnotationArgumentConstants.ORDER, true );

				var orderArg:XML = <arg key="order" value="0"/>;
				
				if ( arg ) {
					orderArg.@value = orderValueDec + Number( arg.value );

					arguments = annotation.arguments;
					for ( var i:int=0; i<arguments.length; i++ ) {
						if ( arguments[ i ] === arg ) {
							//replace the argument with a new one with better ordering
							arguments.splice( i, 1, new MetaDataArgument( orderArg ) );
							break;
						}
					}
				} else {
					orderArg.@value = orderValueDec;
					annotation.arguments.push( new MetaDataArgument( orderArg ) ); 
				}
			}
			
/*			if ( annotation.getArgument( AnnotationArgumentConstants.ORDER, true ).value == "0" ) {
				trace( "New Order " + annotation.getArgument( AnnotationArgumentConstants.ORDER ).value );	
			}
*/			

			return newMethod;
		}
		
		/**
		 * 
		 * Constructor
		 * 
		 */
		public function ParameterizedMethod(method:Method, arguments:Array, methodIndex:uint, totalMethods:uint ) {
			var newMethod : Method = methodWithGuaranteedOrderMetaData( method, methodIndex, totalMethods );

			super( newMethod );

			_arguments = arguments;
		}
		
		/**
		 * 
		 * Indicates that this is a ParameterizedMethod
		 * 
		 */
		override public function toString():String {
			return "ParameterizedMethod " + this.name;
		}		
	}
}