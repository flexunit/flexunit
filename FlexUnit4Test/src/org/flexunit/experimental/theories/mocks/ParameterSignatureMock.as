package org.flexunit.experimental.theories.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Field;
	
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.runners.model.FrameworkMethod;
	
	public class ParameterSignatureMock extends ParameterSignature
	{
		//TODO: How are static functions mocked?
		public var mock:Mock;
		
		override public function canAcceptType(candidate:Class):Boolean {
			return mock.canAcceptType(candidate);
		}
		
		override public function get type():Class {
			return mock.type;
		}
		
		override public function canAcceptArrayType(field:Field):Boolean {
			return mock.canAcceptArrayType(field);
		}
		
		override public function canAcceptArrayTypeMethod(frameworkMethod:FrameworkMethod):Boolean {
			return mock.canAcceptArrayTypeMethod(frameworkMethod);
		}
		
		override public function hasMetadata(type:String):Boolean {
			return mock.hasMetadata(type);
		}
		
		override public function findDeepAnnotation(type:String):XML {
			return mock.findDeepAnnotation(type);
		}
		
		override public function getAnnotation(type:String):XML {
			return mock.getAnnotation(type);
		}
		
		override public function toString():String {
			return mock.toString();
		}
		
		public function ParameterSignatureMock(type:Class = null, metaDataList:XMLList = null) {
			mock = new Mock(this);
			
			super(type, metaDataList);
		}
	}
}