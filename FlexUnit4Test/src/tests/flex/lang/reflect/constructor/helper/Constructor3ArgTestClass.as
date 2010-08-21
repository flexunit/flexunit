package tests.flex.lang.reflect.constructor.helper {
	public class Constructor3ArgTestClass {
		public var arg1:int;
		public var arg2:String;
		public var arg3:Number;
		
		public function Constructor3ArgTestClass( arg1:int=0, arg2:String="testMe", arg3:Number=3.5 ) {
			this.arg1 = arg1;
			this.arg2 = arg2;
			this.arg3 = arg3;
		}
	}
}