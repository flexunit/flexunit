/**
 * Copyright (c) 2010 Digital Primates
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.fluint.uiImpersonation
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class VisualTestEnvironment implements IVisualTestEnvironment
	{
		private var _testEnvironment:Sprite;
		
		/**
		 * Returns the sprite which contains all children added to the test environment.
		 * This should be cast to the type of container specified at creation.
		 * 
		 */
		public function get testEnvironment():Sprite {
			return _testEnvironment
		}
		
		/**
		 * Add a child to test environment.
		 * 
		 * @param child
		 * @return a reference to the added item.
		 * 
		 */ 
		public function addChild(child:DisplayObject):DisplayObject {
			return testEnvironment.addChild(child);
		}
		
		/**
		 * Add a display object at the specified index. The display object at the current index
		 * and any indexes greater will be shifted to accomodate the new object.
		 * 
		 * @param child display object to add
		 * @param index index to add the child at
		 * @return a reference to the added item
		 * 
		 */
		public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return testEnvironment.addChildAt(child, index);
		}
		
		/**
		 * Removes the specified child from the test environment. Any children with a position
		 * greater than the removed child will be shifted to accomodate the change.
		 * 
		 * @param child display object to remove
		 * @return a reference to the removed child
		 * 
		 */
		public function removeChild(child:DisplayObject):DisplayObject {
			return testEnvironment.removeChild(child);
		}
		
		/**
		 * Removes a child at the specified index. Any children with a position greater than the specified
		 * index will be shifted down to accomodate the change.
		 * 
		 * @param index index of the child to remove
		 * @return a reference to the removed child
		 *
		 */
		public function removeChildAt(index:int):DisplayObject {
			return testEnvironment.removeChildAt(index);
		}
		
		/**
		 * Removes all children currently in the test environment
		 * 
		 */
		public function removeAllChildren():void {
			while( numChildren > 0 ) {
				removeChildAt(0);
			}
		}
		
		/**
		 * Retrieves the child at the specified index without removing the child.
		 * 
		 * @param index index of child to retrieve
		 * @return a reference to the child at the specified index
		 *
		 */
		public function getChildAt(index:int):DisplayObject {
			return testEnvironment.getChildAt(index);
		}
		
		/**
		 * Retrieves the child with the specified name without removing the child\
		 * 
		 * @param name name of the child
		 * @return a reference to the retrieved child
		 * 
		 */
		public function getChildByName(name:String):DisplayObject {
			return testEnvironment.getChildByName(name);
		}
		
		/**
		 * Retrieves the index of the specified child in the test environment
		 * 
		 * @param child
		 * @return index of the parameter child
		 * 
		 */
		public function getChildIndex(child:DisplayObject):int {
			return testEnvironment.getChildIndex(child);
		}
		
		/**
		 * Updates the specified child to the new index. This has a similar effect to removing
		 * the child and re-adding it but will not broadcast and add or remove.
		 * 
		 * @param child child to move
		 * @param newIndex the new index to move the child to
		 *
		 */
		public function setChildIndex(child:DisplayObject, newIndex:int):void {
			testEnvironment.setChildIndex(child, newIndex);
		}
		
		/**
		 * Returns the number of children currently in the test environment
		 * 
		 */
		public function get numChildren():int {
			return testEnvironment.numChildren;
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function addElement(element:DisplayObject):DisplayObject	{
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function addElementAt(element:DisplayObject, index:int):DisplayObject {
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function removeElement(element:DisplayObject):DisplayObject {
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function removeElementAt(index:int):DisplayObject {
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function removeAllElements():void {
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function setElementIndex(element:DisplayObject, index:int):void {
			throw new Error("getElementIndex not available in non Flex 4 projects");
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function getElementAt(index:int):DisplayObject {
			throw new Error("getElementIndex not available in non Flex 4 projects");
			
			return null;
		}
		
		/**
		 * Not used in projects prior to Flex 4. Will throw an error if called from a project before Flex 4
		 *
		 */
		public function getElementIndex(element:DisplayObject):int {
			throw new Error("getElementIndex not available in non Flex 4 projects");
			
			return 0;
		}
		
		/**
		 * 
		 * Constructor
		 * 
		 * <p>Creates a new test environment using the <code>baseClass</code> as a base. This base
		 * needs to be a container that implements <code>IVisualElementContainer</code>.</p>
		 * 
		 * @param baseClass A class reference to the container the environment should be built from.
		 * 
		 */
		public function VisualTestEnvironment(baseClass:Class)
		{
			super();
			
			_testEnvironment = new baseClass();
		}
	}
}