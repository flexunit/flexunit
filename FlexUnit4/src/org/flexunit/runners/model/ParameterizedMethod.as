package org.flexunit.runners.model {
	import flex.lang.reflect.Method;
	
	import org.flexunit.token.AsyncTestToken;
	
	public class ParameterizedMethod extends FrameworkMethod {
		private var _arguments:Array;

		public function get arguments():Array {
			return _arguments;
		}

		override public function get name():String {
			var paramName:String = _arguments.join ( "_" );
			return method.name + '_' + paramName;
		}

		override public function invokeExplosively( target:Object, ...params ):Object {
			applyExplosively( target, arguments );
			return null;
		}

		public function ParameterizedMethod(method:Method, arguments:Array ) {
			super(method);
			_arguments = arguments;
		}
		
		override public function toString():String {
			return "ParameterizedMethod " + this.name;
		}		
	}
}