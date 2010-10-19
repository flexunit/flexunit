package org.fluint.uiImpersonation
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
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
		
		/**
		 * Adds a visual element to the test environment
		 * @param element
		 *
		 */
		function addElement(element:DisplayObject):DisplayObject;
		
		/**
		 * Adds a visual element at the specified index to the test environment
		 * @param element
		 *
		 */
		function addElementAt(element:DisplayObject, index:int):DisplayObject;
		
		/**
		 * Removes the specified visual element from the test environment
		 * @param element
		 *
		 */
		function removeElement(element:DisplayObject):DisplayObject;
		
		/**
		 * Removes the visual element at the specified index from the test environment
		 * @param element
		 *
		 */
		function removeElementAt(index:int):DisplayObject;
		
		/**
		 * Removes all visiual element from the test environment
		 *
		 */
		function removeAllElements():void;
		
		/**
		 * Set the specified visual element to the specified index in the test environment
		 *
		 */
		function setElementIndex(element:DisplayObject, index:int):void;
		
		/**
		 * Returns the visual element at the specified index in the test environment
		 *
		 */
		function getElementAt(index:int):DisplayObject;
		
		/**
		 * Returns the index of the specified visual element in the test environment
		 * 
		 */
		function getElementIndex(element:DisplayObject):int;
		
		/**
		 * Returns the current test environment
		 * 
		 */
		function get testEnvironment():Sprite;
	}
}