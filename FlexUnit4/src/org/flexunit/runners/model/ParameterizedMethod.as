package org.flexunit.runners.model {
	import flex.lang.reflect.Method;
	
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
			var paramName:String = _arguments.join ( "_" );
			return method.name + '_' + paramName;
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
		 * 
		 * Constructor
		 * 
		 */
		public function ParameterizedMethod(method:Method, arguments:Array ) {
			super(method);
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