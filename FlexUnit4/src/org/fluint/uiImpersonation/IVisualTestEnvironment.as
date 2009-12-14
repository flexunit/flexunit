package org.fluint.uiImpersonation
{
	import flash.display.DisplayObject;

	public interface IVisualTestEnvironment
	{
		function addChild(child:DisplayObject):DisplayObject;
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		
		function removeChild(child:DisplayObject):DisplayObject;
		function removeChildAt(index:int):DisplayObject;

		function removeAllChildren():void;
		function getChildAt(index:int):DisplayObject;
		function getChildByName(name:String):DisplayObject;
		function getChildIndex(child:DisplayObject):int;
		function setChildIndex(child:DisplayObject, newIndex:int):void;
		function get numChildren():int;
	}
}