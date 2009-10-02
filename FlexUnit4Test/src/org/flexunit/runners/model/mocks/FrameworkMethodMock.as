package org.flexunit.runners.model.mocks
{
	import com.anywebcam.mock.Mock;
	
	import flex.lang.reflect.Method;
	
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	
	public class FrameworkMethodMock extends FrameworkMethod
	{
		public var mock:Mock;
		
		//TODO: How do I return a value of the method property?
		override public function get method():Method {
			return mock.methud;
		}
		
		override public function get name():String {
			return mock.name;
		}
		
		override public function get metadata():XMLList {
			return mock.metadata;
		}
		
		override public function getSpecificMetaDataArg(metaDataTag:String, key:String):String {
			return mock.getSpecificMetaDataArg(metaDataTag, key);
		}
		
		override public function hasMetaData(metaDataTag:String):Boolean {
			return mock.hasMetaData(metaDataTag);
		}
		
		override public function producesType(type:Class):Boolean {
			return mock.producesType(type);
		}
		
		override public function applyExplosivelyAsync(parentToken:AsyncTestToken, target:Object, params:Array):void {
			mock.applyExplosivelyAsync(parentToken, target, params);
		}
		
		override public function invokeExplosivelyAsync(parentToken:AsyncTestToken, target:Object, ...parameters):void {
			mock.invokeMethod( "invokeExplosivelyAsync", [parentToken, target].concat(parameters) );
		}
		
		override public function invokeExplosively(target:Object, ...parameters):Object {
			return mock.invokeMethod( "invokeExplosively", [target].concat(parameters) );
		}
		
		override public function validatePublicVoidNoArg(isStatic:Boolean, errors:Array):void {
			mock.validatePublicVoidNoArg(isStatic, errors);
		}
		
		override public function validatePublicVoid(isStatic:Boolean, errors:Array):void {
			mock.validatePublicVoid(isStatic, errors);	
		}
		
		override public function toString():String {
			return mock.toString();
		}
		
		public function FrameworkMethodMock(method:Method = null)
		{
			mock = new Mock( this );
			
			super(method);
		}
	}
}