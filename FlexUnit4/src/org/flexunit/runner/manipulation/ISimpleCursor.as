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
package org.flexunit.runner.manipulation
{
	public interface ISimpleCursor
	{
	    /**
	     *  If the cursor is located after the last item in the view, 
	     *  this property is <code>true</code> .
	     *  If the ICollectionView is empty (length == 0),
	     *  this property is <code>true</code>.
	     */
	    function get afterLast():Boolean;
	
	    //----------------------------------
	    //  beforeFirst
	    //----------------------------------
	
	    /**
	     *  If the cursor is located before the first item in the view,
	     *  this property is <code>true</code>.
	     *  If the ICollectionView is empty (length == 0),
	     *  this property is <code>true</code>.
	     */
	    function get beforeFirst():Boolean;
	
	    //----------------------------------
	    //  current
	    //----------------------------------	    
	    /**
	     *  Provides access the object at the location
	     *  in the source collection referenced by this cursor.
	     *  If the cursor is beyond the ends of the collection
	     *  (<code>beforeFirst</code>, <code>afterLast</code>)
	     *  this will return <code>null</code>.
	     *
	     *  @see #moveNext()
	     *  @see #movePrevious()
	     *  @see #seek()
	     *  @see #beforeFirst
	     *  @see #afterLast
	     */
	    function get current():Object;
	
	    /**
	     *  Moves the cursor to the next item within the collection.
	     *  On success the <code>current</code> property is updated
	     *  to reference the object at this new location.
	     *  Returns <code>true</code> if the resulting <code>current</code> 
	     *  property is valid, or <code>false</code> if not 
	     *  (the property value is <code>afterLast</code>).
	     *
	     *  <p>If the data is not local and an asynchronous operation must be performed,
	     *  an ItemPendingError is thrown.
	     *  See the ItemPendingError documentation and  the collections
	     *  documentation for more information on using the ItemPendingError.</p>
	     *
	     *  @return <code>true</code> if still in the list,
	     *  <code>false</code> if the <code>current</code> value initially was
	     *  or now is <code>afterLast</code>.
	     *
	     *  @see #current
	     *  @see #movePrevious()
	     *
	     *  @example
	     *  <pre>
	     *  var myArrayCollection:ICollectionView = new ArrayCollection([ "Bobby", "Mark", "Trevor", "Jacey", "Tyler" ]);
	     *  var cursor:IViewCursor = myArrayCollection.createCursor();
	     *  while (!cursor.afterLast)
	     *  {
	     *      trace(cursor.current);
	     *      cursor.moveNext();
	     *  }
	     *  </pre>
	     */
	    function moveNext():Boolean;
	
	    /**
	     *  Moves the cursor to the previous item within the collection.
	     *  On success the <code>current</code> property is updated
	     *  to reference the object at this new location.
	     *  Returns <code>true</code> if the resulting <code>current</code> 
	     *  property is valid, or <code>false</code> if not 
	     *  (the property value is <code>beforeFirst</code>).
	     *
	     *  <p>If the data is not local and an asynchronous operation must be performed,
	     *  an ItemPendingError is thrown.
	     *  See the ItemPendingError documentation and the collections
	     *  documentation for more information on using the ItemPendingError.</p>
	     *
	     *  @return <code>true</code> if still in the list,
	     *  <code>false</code> if the <code>current</code> value initially was or
	     *  now is <code>beforeFirst</code>.
	     *
	     *  For example:
	     *  <pre>
	     *  var myArrayCollection:ICollectionView = new ArrayCollection([ "Bobby", "Mark", "Trevor", "Jacey", "Tyler" ]);
	     *  var cursor:IViewCursor = myArrayCollection.createCursor();
	     *  cursor.seek(CursorBookmark.last);
	     *  while (!cursor.beforeFirst)
	     *  {
	     *      trace(current);
	     *      cursor.movePrevious();
	     *  }
	     *  </pre>
	     *
	     *  @see #current
	     *  @see #moveNext()
	     *  @see mx.collections.errors.ItemPendingError
	     */
	    function movePrevious():Boolean;
	}
}