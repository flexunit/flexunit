package org.flexunit.runners.model.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Klass;
	
	import org.flexunit.runners.model.TestClass;
	
	public class TestClassMock extends TestClass
	{
		public var mock:Mock;
		
		override public function get klassInfo():Klass {
			return mock.klassInfo;
		}
		
		override public function get asClass():Class {
			return mock.asClass;
		}
		
		override public function get name():String {
			return mock.name;
		}
		
		override public function get metadata():XMLList {
			return mock.metedata;
		}
		
		override public function getMetaDataMethods(metaTag:String):Array {
			return mock.getMetaDataMethods(metaTag);
		}
		
		override public function toString():String {
			return mock.toString();
		}
		
		public function TestClassMock(klass:Class = null)
		{
			mock = new Mock(this);
			
			super(klass);
		}
	}
}