/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
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
	
	import mx.core.FlexVersion;
	
	import org.flexunit.Assert;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	/**
	 *
	 * Provides access to the visual test environment through static methods 
	 * @author mlabriola
	 * 
	 */
	public class UIImpersonator extends Assert
	{
		/** 
		 * Returns the test environment for visual testing. 
		 */
		private static function get testEnvironment():IVisualTestEnvironment {
			var testEnvironment:IVisualEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance();
			var environment:IVisualTestEnvironment = testEnvironment.buildVisualTestEnvironment();
			return environment;
		}
		
		/**
		 * Returns the base display component for all components added to the impersonator. In the case of
		 * an ActionScript project, this will be a Sprite. For a Flex 3 and earlier project, this will be a
		 * Container. For a Flex 4 and beyond project, this will be a Group. The testDisplay should typically be
		 * type cast depending on the developers intent.
		 * 
		 */
		public static function get testDisplay():Sprite {
			var testEnvironment:IVisualEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance();
			var environment:IVisualTestEnvironment = testEnvironment.buildVisualTestEnvironment();
			return environment.testEnvironment;
		}

	    /**
	     *  Adds a child DisplayObject to the TestEnvironment.
	     *  The child is added after other existing children,
	     *  so that the first child added has index 0,
	     *  the next has index 1, an so on.
	     *
	     *  <p><b>Note: </b>While the <code>child</code> argument to the method
	     *  is specified as of type DisplayObject, the argument must implement
	     *  the IUIComponent interface to be added as a child of a container.
	     *  All Flex components implement this interface.</p>
	     *
	     *  @param child The DisplayObject to add as a child of the TestEnvironment.
	     *  It must implement the IUIComponent interface.
	     *
	     *  @return The added child as an object of type DisplayObject. 
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of the added component.
	     *
	     *  @see mx.core.Container
	     *
	     *  @tiptext Adds a child object to this container.
	     */
		public static function addChild(child:DisplayObject):DisplayObject {
			return testEnvironment.addChild( child );
		}

	    /**
	     *  Adds a child DisplayObject to the TestEnvironment.
	     *  The child is added at the index specified.
	     *
	     *  <p><b>Note: </b>While the <code>child</code> argument to the method
	     *  is specified as of type DisplayObject, the argument must implement
	     *  the IUIComponent interface to be added as a child of TestEnvironment.
	     *  All Flex components implement this interface.</p>
	     *
	     *  @param child The DisplayObject to add as a child of the TestEnvironment.
	     *  It must implement the IUIComponent interface.
	     *
	     *  @param index The index to add the child at.
	     *
	     *  @return The added child as an object of type DisplayObject. 
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of the added component.
	     *
	     *  @see mx.core.Container
	     */
		public static function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return testEnvironment.addChildAt( child, index );
		}  

	    /**
	     *  Removes a child DisplayObject from the child list of the TestEnviroment.
	     *  The removed child will have its <code>parent</code>
	     *  property set to null. 
	     *  The child will still exist unless explicitly destroyed.
	     *  If you add it to another container,
	     *  it will retain its last known state.
	     *
	     *  @param child The DisplayObject to remove.
	     *
	     *  @return The removed child as an object of type DisplayObject. 
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of the removed component.
	     */
		public static function removeChild(child:DisplayObject):DisplayObject {
			return testEnvironment.removeChild( child );
		} 

	    /**
	     *  Removes a child DisplayObject from the child list of the TestEnvironment
	     *  at the specified index.
	     *  The removed child will have its <code>parent</code>
	     *  property set to null. 
	     *  The child will still exist unless explicitly destroyed.
	     *  If you add it to another container,
	     *  it will retain its last known state.
	     *
	     *  @param index The child index of the DisplayObject to remove.
	     *
	     *  @return The removed child as an object of type DisplayObject. 
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of the removed component.
	     */
		public static function removeChildAt(index:int):DisplayObject {
			return testEnvironment.removeChildAt( index );
		} 

	    /**
	     *  Removes all children from the child list of this container.
	     */
		public static function removeAllChildren():void {
			return testEnvironment.removeAllChildren();
		} 

	    /**
	     *  Gets the <i>n</i>th child component object.
	     *
	     *  <p>The children returned from this method include children that are
	     *  declared in MXML and children that are added using the
	     *  <code>addChild()</code> or <code>addChildAt()</code> method.</p>
	     *
	     *  @param childIndex Number from 0 to (numChildren - 1).
	     *
	     *  @return Reference to the child as an object of type DisplayObject. 
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of a specific Flex control, such as ComboBox or TextArea.
	     */
	    public static function getChildAt(index:int):DisplayObject {
	    	return testEnvironment.getChildAt( index );
	    }

	    /**
	     *  Returns the child whose <code>name</code> property is the specified String.
	     *
	     *  @param name The identifier of the child.
	     *
	     *  @return The DisplayObject representing the child as an object of type DisplayObject.
	     *  You typically cast the return value to UIComponent, 
	     *  or to the type of a specific Flex control, such as ComboBox or TextArea.
	     */
	    public static function getChildByName(name:String):DisplayObject {
	    	return testEnvironment.getChildByName( name );
	    }

	    /**
	     *  Gets the zero-based index of a specific child.
	     *
	     *  <p>The first child of the Test Environment (i.e.: the first child tag
	     *  that appears in the MXML declaration) has an index of 0,
	     *  the second child has an index of 1, and so on.
	     *  The indexes of the test environemnt children determine
	     *  the order in which they get laid out.
	     *  For example, in a VBox the child with index 0 is at the top,
	     *  the child with index 1 is below it, etc.</p>
	     *
	     *  <p>If you add a child by calling the <code>addChild()</code> method,
	     *  the new child's index is equal to the largest index among existing
	     *  children plus one.
	     *  You can insert a child at a specified index by using the
	     *  <code>addChildAt()</code> method; in that case the indices of the
	     *  child previously at that index, and the children at higher indices,
	     *  all have their index increased by 1 so that all indices fall in the
	     *  range from 0 to <code>(numChildren - 1)</code>.</p>
	     *
	     *  <p>If you remove a child by calling <code>removeChild()</code>
	     *  or <code>removeChildAt()</code> method, then the indices of the
	     *  remaining children are adjusted so that all indices fall in the
	     *  range from 0 to <code>(numChildren - 1)</code>.</p>
	     *
	     *  <p>If <code>myView.getChildIndex(myChild)</code> returns 5,
	     *  then <code>myView.getChildAt(5)</code> returns myChild.</p>
	     *
	     *  <p>The index of a child may be changed by calling the
	     *  <code>setChildIndex()</code> method.</p>
	     *
	     *  @param child Reference to child whose index to get.
	     *
	     *  @return Number between 0 and (numChildren - 1).
	     */
	    public static function getChildIndex(child:DisplayObject):int {
	    	return testEnvironment.getChildIndex( child );
	    }

	    /**
	     *  Sets the index of a particular child.
	     *  See the <code>getChildIndex()</code> method for a
	     *  description of the child's index.
	     *
	     *  @param child Reference to child whose index to set.
	     *
	     *  @param newIndex Number that indicates the new index.
	     *  Must be an integer between 0 and (numChildren - 1).
	     */
		public static function setChildIndex(child:DisplayObject, newIndex:int):void {
			testEnvironment.setChildIndex( child, newIndex );
		} 

	    /**
	     *  Number of child components in the TestEnvironment.
	     *
	     *  <p>The number of children is initially equal
	     *  to the number of children declared in MXML.
	     *  At runtime, new children may be added by calling
	     *  <code>addChild()</code> or <code>addChildAt()</code>,
	     *  and existing children may be removed by calling
	     *  <code>removeChild()</code>, <code>removeChildAt()</code>,
	     *  or <code>removeAllChildren()</code>.</p>
	     */
		public static function get numChildren():int {
			return testEnvironment.numChildren;
		}
		
		/**
		 *  Used for Flex 4 components since addChild is not used on these
		 * 	components. Adds an element DisplayObject to the TestEnvironment.
		 *  The element is added after other existing children,
		 *  so that the first element added has index 0,
		 *  the next has index 1, an so on.
		 *
		 *  <p><b>Note: </b>While the <code>element</code> argument to the method
		 *  is specified as of type DisplayObject, the argument must implement
		 *  the IVisualElement interface to be added as an element of a Flex 4 group.
		 *  All Flex 4 components implement this interface.</p>
		 *
		 *  @param element The DisplayObject to add as a element of the TestEnvironment.
		 *  It must implement the IVisualElement interface.
		 *
		 *  @return The added element as an object of type DisplayObject. 
		 *  You typically cast the return value to IVisualElement, 
		 *  or to the type of the added component.
		 *
		 *  @see spark.components.Group
		 *
		 *  @tiptext Adds an element object to this container.
		 *  @version Flex 4
		 */
		public static function addElement(element:DisplayObject):DisplayObject {
			return testEnvironment.addElement( element )
		}
		
		/**
		 *  Adds an element DisplayObject to the TestEnvironment.
		 *  The element is added at the index specified.
		 *
		 *  <p><b>Note: </b>While the <code>element</code> argument to the method
		 *  is specified as of type DisplayObject, the argument must implement
		 *  the IVisualElement interface to be added as an element of TestEnvironment.
		 *  All Flex 4 components implement this interface.</p>
		 *
		 *  @param element The DisplayObject to add as an element of the TestEnvironment.
		 *  It must implement the IVisualElement interface.
		 *
		 *  @param index The index to add the element at.
		 *
		 *  @return The added element as an object of type DisplayObject. 
		 *  You typically cast the return value to IVisualElement, 
		 *  or to the type of the added component.
		 *
		 *  @see spark.components.Group
		 */
		public static function addElementAt(element:DisplayObject, index:int):DisplayObject {
			return testEnvironment.addElementAt( element, index );
		}
		
		/**
		 *  Removes an element DisplayObject from the child list of the TestEnviroment.
		 *  The removed element will have its <code>parent</code>
		 *  property set to null. 
		 *  The element will still exist unless explicitly destroyed.
		 *  If you add it to another container,
		 *  it will retain its last known state.
		 *
		 *  @param element The DisplayObject to remove.
		 *
		 *  @return The removed element as an object of type DisplayObject. 
		 *  You typically cast the return value to UIComponent, 
		 *  or to the type of the removed component.
		 */
		public static function removeElement(element:DisplayObject):DisplayObject {
			return testEnvironment.removeElement( element );
		} 
		
		/**
		 *  Removes an element DisplayObject from the child list of the TestEnvironment
		 *  at the specified index.
		 *  The removed element will have its <code>parent</code>
		 *  property set to null. 
		 *  The element will still exist unless explicitly destroyed.
		 *  If you add it to another container,
		 *  it will retain its last known state.
		 *
		 *  @param index The element index of the DisplayObject to remove.
		 *
		 *  @return The removed element as an object of type DisplayObject. 
		 *  You typically cast the return value to UIComponent, 
		 *  or to the type of the removed component.
		 */
		public static function removeElementAt(index:int):DisplayObject {
			return testEnvironment.removeElementAt( index );
		} 
		
		/**
		 *  Removes all elements from the child list of this container.
		 */
		public static function removeAllElements():void {
			return testEnvironment.removeAllElements();
		} 
		
		/**
		 *  Gets the <i>n</i>th element component object.
		 *
		 *  <p>The element returned from this method includes elements that are
		 *  declared in MXML and elements that are added using the
		 *  <code>addElement()</code> or <code>addElementAt()</code> method.</p>
		 *
		 *  @param elementIndex Number from 0 to (numChildren - 1).
		 *
		 *  @return Reference to the element as an object of type DisplayObject. 
		 *  You typically cast the return value to UIComponent, 
		 *  or to the type of a specific Flex control, such as ComboBox or TextArea.
		 */
		public static function getElementAt(elementIndex:int):DisplayObject {
			return testEnvironment.getElementAt( elementIndex );
		}
		
		/**
		 *  Gets the zero-based index of a specific child.
		 *
		 *  <p>The first element of the Test Environment (i.e.: the first element tag
		 *  that appears in the MXML declaration) has an index of 0,
		 *  the second element has an index of 1, and so on.
		 *  The indexes of the test environemnt elements determine
		 *  the order in which they get laid out.
		 *  For example, in a VGroup the element with index 0 is at the top,
		 *  the element with index 1 is below it, etc.</p>
		 *
		 *  <p>If you add a element by calling the <code>addElement()</code> method,
		 *  the new element's index is equal to the largest index among existing
		 *  elements plus one.
		 *  You can insert an element at a specified index by using the
		 *  <code>addElementAt()</code> method; in that case the indices of the
		 *  element previously at that index, and the elements at higher indices,
		 *  all have their index increased by 1 so that all indices fall in the
		 *  range from 0 to <code>(numChildren - 1)</code>.</p>
		 *
		 *  <p>If you remove an element by calling <code>removeElement()</code>
		 *  or <code>removeelementAt()</code> method, then the indices of the
		 *  remaining elements are adjusted so that all indices fall in the
		 *  range from 0 to <code>(numChildren - 1)</code>.</p>
		 *
		 *  <p>If <code>myView.getElementIndex(myChild)</code> returns 5,
		 *  then <code>myView.getElementAt(5)</code> returns myElement.</p>
		 *
		 *  @param element Reference to element whose index to get.
		 *
		 *  @return Number between 0 and (numChildren - 1).
		 */
		public static function getElementIndex(element:DisplayObject):int {
			return testEnvironment.getElementIndex( element );
		}
	}
}