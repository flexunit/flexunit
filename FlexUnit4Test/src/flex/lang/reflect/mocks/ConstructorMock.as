package flex.lang.reflect.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Klass;
	
	public class ConstructorMock extends Constructor
	{
		public var mock:Mock;
		
		override public function get name():String {
			return mock.name;
		}
		
		override public function get parameterTypes():Array {
			return mock.parameterTypes;	
		}
		
		override public function get parameterMetaData():Array {
			return mock.parameterMetaData;	
		}
		
		override public function newInstanceApply(params:Array):Object {
			return mock.newIstanceApply(params);
		}
		
		override public function newInstance(...parameters):Object {
			return mock.invokeMethod("newInstance", parameters);
		}
		
		public function ConstructorMock(constructorXML:XML, klass:Klass) {
			mock = new Mock(this);
			
			super(constructorXML, klass);
		}
	}
}