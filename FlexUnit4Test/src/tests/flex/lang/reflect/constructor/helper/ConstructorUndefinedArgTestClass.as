package tests.flex.lang.reflect.constructor.helper {
	/** This class is separate from the others and is only ever instantiated in one class.
	 *  We need to ensure that is true so we can attempt to resolve the constructor arguments.
	 * 
	 * I would make this an internal class, unfortunately flash has problems every resolving params
	 * on those classes
	 */
	public class ConstructorUndefinedArgTestClass {
		public var arg1:int;
		public var arg2:String;
		public var arg3:Number;
		
		public function ConstructorUndefinedArgTestClass( arg1:int=0, arg2:String="testMe", arg3:Number=3.5 ) {
			this.arg1 = arg1;
			this.arg2 = arg2;
			this.arg3 = arg3;
		}
	}
}