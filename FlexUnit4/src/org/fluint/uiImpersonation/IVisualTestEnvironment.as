package org.fluint.uiImpersonation
{
	import flash.display.DisplayObject;

	/**
	 * Implemented by visual test environment facades
	 *  
	 * @author mlabriola
	 * 
	 */
	public interface IVisualTestEnvironment
	{
		/**
		 * Adds a display object to the visual test environment 
		 * @param child
		 * @return 
		 * 
		 */		
		function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a display object to the visual test environment at a given position
		 * @param child
		 * @param index
		 * @return 
		 * 
		 */		
		function addChildAt(child:DisplayObject, index:int):DisplayObject;

		/**
		 * removes a display object from the visual test environment  
		 * @param child
		 * @return 
		 * 
		 */		
		function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes a display object from the visual test environment at an index 
		 * @param index
		 * @return 
		 * 
		 */		
		function removeChildAt(index:int):DisplayObject;

		/**
		 * Removes all children from visual test environment 
		 * 
		 */		
		function removeAllChildren():void;
		/**
		 * Returns a child in the visual test environment at a given index
		 * @param index
		 * @return 
		 * 
		 */
		function getChildAt(index:int):DisplayObject;
		/**
		 * 
		 * Returns a child in the visual test environment with a given name
		 * @param name
		 * @return 
		 * 
		 */
		function getChildByName(name:String):DisplayObject;
		/**
		 * 
		 * Returns the index of a child in the visual test environment 
		 * @param child
		 * @return 
		 * 
		 */
		function getChildIndex(child:DisplayObject):int;
		/**
		 * 
		 * Sets the index of a child in the visual test environment
		 * @param child
		 * @param newIndex
		 * 
		 */
		function setChildIndex(child:DisplayObject, newIndex:int):void;
		/**
		 * Returns the number of children in the visual test environment 
		 * @return 
		 * 
		 */
		function get numChildren():int;
	}
}