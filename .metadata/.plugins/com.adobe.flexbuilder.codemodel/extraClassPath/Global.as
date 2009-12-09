/****************************************************************************
* 
* ADOBE CONFIDENTIAL
* ___________________
*
*  Copyright [2002] - [2006] Adobe Macromedia Software LLC and its licensors 
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains the property
* of Adobe Macromedia Software LLC and its licensors, if any.  
* The intellectual and technical concepts contained herein are proprietary
* to Adobe Macromedia Software LLC and its licensors and may be covered by 
* U.S. and Foreign Patents, patents in process, and are protected by trade  
* secret or copyright law. Dissemination of this information or reproduction 
* of this material is strictly forbidden unless prior written permission is 
* obtained from Adobe Macromedia Software LLC and its licensors.
****************************************************************************/
package {
	
//****************************************************************************
// ActionScript Standard Library
// ArgumentError object
//****************************************************************************
/**
 * The ArgumentError class represents an error that occurs when the arguments 
 * supplied in a function do not match the arguments defined for 
 * that function. Possible sources of this error include a function being called with
 * the wrong number of arguments, an argument of the incorrect type, or an argument that is
 * invalid.
 * 
 * @tiptext An ArgumentError is thrown when the parameter values supplied during a 
 * function call do not match the parameters defined for that function.
 * 
 * @includeExample examples\ArgumentErrorExample.as -noswf
 * 
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid 
 * @refpath 
 * @keyword Error
 */
public dynamic class ArgumentError extends Error
{
	/**
	 * Creates an ArgumentError object.
     * @param message A string associated with the error.
	 */
	public native function ArgumentError(message:String = "");
}

}
package {
/**
 * An <code>arguments</code> object is used to store and access a function's arguments. 
 * While inside the function's body it can be accessed with the local <code>arguments</code> 
 * variable.
 * <p>
 * The arguments are stored as array elements, the first is accessed as 
 * <code>arguments[0]</code>, the second as <code>arguments[1]</code>, etc. The
 * <code>arguments.length</code> property indicates the number of arguments passed to
 * the function. Note that there may be a different number of arguments passed in than 
 * the function declares.
 * </p>
 * <p>
 * ActionScript 3.0 has no <code>arguments.caller</code> property, which did exist in previous versions of
 * ActionScript. To get a reference to the function
 * that called the current function, you must pass a reference to that function as an
 * argument. An example of this technique can be found in the example for <code>arguments.callee</code>.
 * </p>
 * <p>ActionScript 3.0 supports a new <code>...(rest)</code> statement that is recommended instead of the 
 * arguments class.</p>
 * 
 * @tiptext An arguments object is used to store and access a function's arguments.
 * @playerversion Flash 8 
 * @langversion 3.0
 *
 * @includeExample examples\ArgumentsExample.as -noswf
 * @see statements.html#..._(rest)_parameter ...(rest) statement
 * @see Function
 */
public class arguments {
	/**
	 * A reference to the currently executing function.
	 *
	 * @includeExample examples\arguments.callee.1.as -noswf
	 * @tiptext A reference to the currently executing function.
	 * @playerversion Flash 8
	 * @langversion 3.0
	 */
	public var callee:Function;
	

	/**
	 * The number of arguments passed to the function. This may be more or less
	 * than the function declares.
	 * 
	 * @tiptext The number of parameters passed to the function.
	 * @playerversion Flash 8
	 * @langversion 3.0
	 */
	public var length:Number;
}
}
package {
//****************************************************************************
// ActionScript Standard Library
// Array object
//****************************************************************************

/**
 * The Array class lets you access and manipulate arrays. Array indices are zero-based, which means that the first element in the array is <code>[0]</code>, the second element is <code>[1]</code>, and so on. To create an Array object, you use the <code>new Array()</code> constructor . <code>Array()</code> can also be
 * invoked as a function. And, you can use the array access (<code>[]</code>) operator to initialize an array or access the elements of an array. 
 * <p>You can store a wide variety of data types in an array element, including numbers, strings, objects, and even other arrays. You can create a <em>multidimensional</em> array by creating an indexed array and assigning to each of its elements a different indexed array. Such an array is considered multidimensional because it can be used to represent data in a table.</p>
 * <p> Arrays are <em>sparse arrays</em> meaning there may be an element at index 0 and another at index 5, but nothing in the index positions between those two elements. In such a case, the elements in positions 1 through 4 are <code>undefined</code>, which indicates the absence of an element, not necessarily the presence of an element with the value undefined.</p>
 * 
 * <p>Array assignment is by reference rather than by value. When you assign one array variable to another array variable, both refer to the same array:</p>
 * <listing>
 * var oneArray:Array = new Array("a", "b", "c");
 * var twoArray:Array = oneArray; // Both array variables refer to the same array.
 * twoArray[0] = "z";             
 * trace(oneArray);               // Output: z,b,c.
 * </listing>
 * <p>The Array class should not be used to create <em>associative arrays</em>, which are different data structures that contain named elements instead of numbered elements. You should use the Object class to create associative arrays (also called <em>hashes</em>). Although ActionScript permits you to create associative arrays using the Array class, you cannot use any of the Array class methods or properties. </p>
 * <p>You can subclass Array and override or add methods. However, you must specify the subclass as <code>dynamic</code> 
 * or you will lose the ability to store data in an array.</p>
 *
 * @tiptext Lets you access and manipulate indexed arrays.
 *
 * @playerversion Flash 9
 * @langversion 3.0
 * 
 * @includeExample examples\ArrayExample.as -noswf
 *
 * @oldexample In the following example, my_array contains four months of the year:
 * <pre>
 * var my_array:Array = new Array();
 * my_array[0] = "January";
 * my_array[1] = "February";
 * my_array[2] = "March";
 * my_array[3] = "April";
 * </pre>
 * @helpid x208A1
 * @refpath Objects/Core/Array
 * @keyword Array, Array object, built-in class
 * 
 * @see operators.html#array_access [] (array access)
 * @see Object Object class
 */
public dynamic class Array
{
   
    /**
     * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> method. 
	 * <p>The value of this constant is 1.</p>

	 * @see Array#sort()
	 * @see Array#sortOn()
	 * @helpid x217F6
	 */
	public static const CASEINSENSITIVE:uint = 1;
	/**
     * Specifies descending sorting for the Array class sorting methods. 
 	 * You can use this constant for the <code>options</code> parameter in the <code>sort()</code>
 	 * or <code>sortOn()</code> method. 
 	 * <p>The value of this constant is 2.</p>
	 *
	 * @see Array#sort()
	 * @see Array#sortOn()
	 * @helpid x217F7
	 */
	public static const DESCENDING:uint = 2;
	/**
     * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
     * Including this constant in the <code>options</code>
 	 * parameter causes the <code>sort()</code> and <code>sortOn()</code> methods 
 	 * to sort numbers as numeric values, not as strings of numeric characters.  
     * Without the <code>NUMERIC</code> constant, sorting treats each array element as a 
 	 * character string and produces the results in Unicode order. 
 	 *
     * <p>For example, given the array of values <code>[2005, 7, 35]</code>, if the <code>NUMERIC</code> 
 	 * constant is <strong>not</strong> included in the <code>options</code> parameter, the 
     * sorted array is <code>[2005, 35, 7]</code>, but if the <code>NUMERIC</code> constant <strong>is</strong> included, 
     * the sorted array is <code>[7, 35, 2005]</code>. </p>
 	 * 
 	 * <p>This constant applies only to numbers in the array; it does 
     * not apply to strings that contain numeric data such as <code>["23", "5"]</code>.</p>
 	 * 
 	 * <p>The value of this constant is 16.</p>

	 * @see Array#sort()
	 * @see Array#sortOn()
	 * @helpid x217F8
	 */
	public static const NUMERIC:uint = 16;
	/**
	 * Specifies that a sort returns an array that consists of array indices as a result of calling
 	 * the <code>sort()</code> or <code>sortOn()</code> method. You can use this constant
 	 * for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> 
 	 * method, so you have access to multiple views on the array elements while the original array is unmodified. 
 	 * <p>The value of this constant is 8.</p>

	 * @see Array#sort()
	 * @see Array#sortOn()
	 * @helpid x217F9
	 */
	public static const RETURNINDEXEDARRAY:uint = 8;
	/**
     * Specifies the unique sorting requirement for the Array class sorting methods. 
     * You can use this constant for the <code>options</code> parameter in the <code>sort()</code> or <code>sortOn()</code> 
	 * method. The unique sorting option terminates the sort if any two elements
	 * or fields being sorted have identical values. 
	 * <p>The value of this constant is 4.</p>

	 * @see Array#sort()
	 * @see Array#sortOn()
	 * @helpid x217FA
	 */
	public static const UNIQUESORT:uint = 4;

	[Inspectable(environment="none")]
	
	/**
	 * A non-negative integer specifying the number of elements in the array. This property is automatically updated when new elements are added to the array. When you assign a value to an array element (for example, <code>my_array[index] = value</code>), if <code>index</code> is a number, and <code>index+1</code> is greater than the <code>length</code> property, the <code>length</code> property is updated to <code>index+1</code>.
   	 * <p><strong>Note: </strong>If you assign a value to the <code>length</code> property that is shorter than the existing length, the array will be truncated.</p>
   	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * 
	 * @includeExample examples\Array.length.1.as -noswf
	 *
	 * @helpid x2089F
	 * @refpath Objects/Core/Array/Properties/length
	 * @keyword array.length, length
	 */
	public native function get length():uint;
	public native function set length(newLength:uint);
	

	/**
	 * Lets you create an array of the specified length. 
	 * If you don't specify any parameters, an array with a length of 0 is created. 
	 * If you specify a length, an array is created with <code>length</code> number of elements. 
     * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
     * variable types of arguments. The constructor behaves differently depending on the type and number of 
     * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
     * 
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @param numElements An integer that specifies the number of elements in the array.
	 * 
	 * @throws RangeError If the sole argument is a number that is not an integer greater than or equal to zero.	 
	 * @includeExample examples\Array.1.as -noswf
	 * @includeExample examples\Array.2.as -noswf
	 *
	 * @see operators.html#array_access [] array access 
	 * @see #length Array.length
	 *
	 */
	public native function Array(numElements:int = 0);
	
	/**
	 * Lets you create an array containing the specified elements.
	 * The values specified can be of any type. 
	 * The first element in an array always has an index or position of 0.
     * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
     * variable types of arguments. The constructor behaves differently depending on the type and number of 
     * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
	 * @param ...values A comma-separated list of one or more arbitrary values. 
	 * <p><strong>Note: </strong>If only a single numeric parameter is passed to the Array constructor, 
	 * it is assumed to specify the array's <code>length</code> property.</p>
	 * @throws RangeError If the sole argument is a number that is not an integer greater than or equal to zero.	 
	 * @includeExample examples\Array.3.as -noswf
	 * @see operators.html#array_access [] array access 
	 * @see #length Array.length
	 */
	public native function Array(...values);
	
	/**
	 * Concatenates the elements specified in the parameters with the elements in an array and creates a new array. If the parameters specify an array, the elements of that array are concatenated. 
 	 *
 	 * @tiptext Concatenates the elements specified in the parameters.
	 *
	 * @playerversion Flash 9
    	 * @langversion 3.0 
	 *
	 * @param ...args A value of any data type (such as numbers, elements, or strings) to be concatenated in a new array. If you don't 
	 * pass any values, the new array is a duplicate of the original array.
	 *
	 * @return An array that contains the elements from this array followed by elements from
  	 * the parameters.
	 *
	 * @includeExample examples\Array.concat.1.as -noswf
	 *
	 * @helpid x2089D
	 * @refpath Objects/Core/Array/Methods/concat
	 * @keyword array.concat, concat, concatenate
	 */
	public native function concat(...args):Array;
	
	/**
	 * Executes a test function on each item in the array until an item is reached that returns <code>false</code> for the specified function. You use this method to find out if all items in an array meet a certain criterion; for example, they all have values less than some number).
     * <span class="flashonly"><p>For this method, the second parameter, <code>thisObject</code>, must be null if the
     * first parameter, <code>callback</code>, is a method closure. In other words, if you create a function in a movie clip
     * called <code>me</code>:</p>
     * <pre>
     * function myFunction(){
     *    //your code here
     * }
     * </pre>
     * <p>and then use the filter method on an array called myArray:</p>
     * <pre>
     * myArray.filter(myFunction, me);
     * </pre>
     * <p>the function <code>myFunction</code> is a member function of the Timeline class, which cannot be overridden 
     * by <code>me</code>. Flash Player will throw an exception.
     * You can avoid this runtime error by assigning the function to a variable, as follows:</p>
     * <pre>
     * var foo:Function = myFunction() {
     *     //your code here
     *     };
     * myArray.filter(foo, me);
     * </pre></span>
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * @param callback The function to run on each item in the array. This function can contain a simple comparison (for example, <code>item &lt; 20</code>) or a more complex operation, and it can be invoked with three arguments: the value of
	 * an item, the index of an item, and the Array object as in <code>(item, index, array)</code>. 
	 *
	 * @param thisObject An object to use as <code>this</code> for the function.
	 * @return A Boolean value; <code>true</code> if all items in the array return <code>true</code> for the specified function, otherwise <code>false</code>.
	 *
	 * @includeExample examples\Array.every.as -noswf
	 * @see #some() Array.some()
	 */	
	public native function every(callback:Function, thisObject=null):Boolean;

	/**
	 * Executes a test function on each item in the array and constructs a new array for all items that return <code>true</code> for the specified function. If an item returns <code>false</code>, it is not included in the new array.
     * <span class="flashonly"><p>For this method, the second parameter, <code>thisObject</code>, must be null if the
     * first parameter, <code>callback</code>, is a method closure. In other words, if you create a function in a movie clip
     * called <code>me</code>:</p>
     * <pre>
     * function myFunction(){
     *    //your code here
     * }
     * </pre>
     * <p>and then use the filter method on an array called myArray:</p>
     * <pre>
     * myArray.filter(myFunction, me);
     * </pre>
     * <p>the function <code>myFunction</code> is a member function of the Timeline class, which cannot be overridden 
     * by <code>me</code>. Flash Player will throw an exception.
     * You can avoid this runtime error by assigning the function to a variable, as follows:</p>
     * <pre>
     * var foo:Function = myFunction() {
     *     //your code here
     *     };
     * myArray.filter(foo, me);
     * </pre></span>
     *
	 * @playerversion Flash 9
	 * @langversion 3.0 
     * @param callback The function to run on each item in the array. This function can contain a simple comparison (for example, <code>item &lt; 20</code>) or a more complex operation and will be invoked with three arguments, including the
     * value of an item, the index of an item, and the Array object as in:
     * <pre>    function callback(item:&#42;, index:int, array:Array):void;</pre> 
	 *
	 * @param thisObject An object to use as <code>this</code> for the function.
	 * @return A new array containing all items from the original array that returned <code>true</code>.
	 *
	 * @includeExample examples\Array.filter.as -noswf
	 * @see #map() Array.map()	 
	 */	
	public native function filter(callback:Function, thisObject=null):Array;
	
	/**
	 * Executes a function on each item in the array.
     * <span class="flashonly"><p>For this method, the second parameter, <code>thisObject</code>, must be null if the
     * first parameter, <code>callback</code>, is a method closure. In other words, if you create a function in a movie clip
     * called <code>me</code>:</p>
     * <pre>
     * function myFunction(){
     *    //your code here
     * }
     * </pre>
     * <p>and then use the filter method on an array called myArray:</p>
     * <pre>
     * myArray.filter(myFunction, me);
     * </pre>
     * <p>the function <code>myFunction</code> is a member function of the Timeline class, which cannot be overridden 
     * by <code>me</code>. Flash Player will throw an exception.
     * You can avoid this runtime error by assigning the function to a variable, as follows:</p>
     * <pre>
     * var foo:Function = myFunction() {
     *     //your code here
     *     };
     * myArray.filter(foo, me);
     * </pre></span>
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * @param callback The function to run on each item in the array. This function can contain a simple command 
     * (for example, a <code>trace()</code> statement) or a more complex operation and it can be invoked with three arguments,
     * including the value of an item, the index of an item, and the Array object as in:
     * <pre>    function callback(item:&#42;, index:int, array:Array):void;</pre> 
	 *
	 * @param thisObject An object to use as <code>this</code> for the function.
	 *
	 * @includeExample examples\Array.forEach.as -noswf
	 * @includeExample examples\Array.forEach.2.as -noswf	 
	 */		
	public native function forEach(callback:Function, thisObject=null):void;

	/**
	 * Searches for an item in an array using strict equality (<code>===</code>) and returns the index 
	 * position of the item.
	 * @playerversion Flash 9
     * @langversion 3.0 
	 * @param searchElement The item to find in the array.
	 *
	 * @param fromIndex The location in the array from which to start searching for the item.
     * @return A zero-based index position of the item in the array. If the <code>searchElement</code> argument
     * is not found the return value will be -1.
	 *
	 * @includeExample examples\Array.indexOf.as -noswf	 
	 * @see #lastIndexOf() Array.lastIndexOf()
	 * @see operators.html#strict_equality === (strict equality)	 
	 */	
	public native function indexOf(searchElement, fromIndex:int=0):int;	
	
	/**
	 * Converts the elements in an array to strings, inserts the specified separator between the 
	 * elements, concatenates them, and returns the resulting string. A nested array is always 
	 * separated by a comma (,), not by the separator passed to the <code>join()</code> method.
	 *
	 * @tiptext Converts the elements in an array to strings.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0  
	 *
	 * @param sep A character or string that separates array elements in 
	 * the returned string. If you omit this parameter, a comma is used as the default 
	 * separator. 
	 *
	 * @return A string consisting of the elements of an array
	 * converted to strings and separated by the specified parameter.
	 * 
	 * @includeExample examples\Array.join.1.as -noswf
	 * @includeExample examples\Array.join.2.as -noswf
	 *
	 * @oldsee mx.String#split <span class="flexonly">mx.String.split()</span>
	 * @see String#split()
	 *
	 * @helpid x2089E
	 * @refpath Objects/Core/Array/Methods/join
	 * @keyword array.join, join
	 */
	public native function join(sep=void 0):String;
	
	/**
	 * Searches for an item in an array, working backward from the last item, and returns the index position of the matching item using strict equality (<code>===</code>).
	 * @playerversion Flash 9
     * @langversion 3.0 
     * @param searchElement The item to find in the array.
	 *
	 * @param fromIndex The location in the array from which to start searching for the item. The default is the maximum
	 * value allowed for an index. If <code>fromIndex</code> is not specified, the search starts at the last item
	 * in the array.
     * @return A zero-based index position of the item in the array. If the <code>searchElement</code> argument is 
     * not found the return value will be -1.
	 *
	 * @includeExample examples\Array.lastIndexOf.as -noswf	 
	 * @see #indexOf() Array.indexOf()	
	 * @see operators.html#strict_equality === (strict equality)
	 */		
	public native function lastIndexOf(searchElement, fromIndex:int=0x7fffffff):int;

	/**
	 * Executes a function on each item in an array, and constructs a new array of items corresponding to the results of the function on each item in the original array.
     * <span class="flashonly"><p>For this method, the second parameter, <code>thisObject</code>, must be null if the
     * first parameter, <code>callback</code>, is a method closure. In other words, if you create a function in a movie clip
     * called <code>me</code>:</p>
     * <pre>
     * function myFunction(){
     *    //your code here
     * }
     * </pre>
     * <p>and then use the filter method on an array called myArray:</p>
     * <pre>
     * myArray.filter(myFunction, me);
     * </pre>
     * <p>the function <code>myFunction</code> is a member function of the Timeline class, which cannot be overridden 
     * by <code>me</code>. Flash Player will throw an exception.
     * You can avoid this runtime error by assigning the function to a variable, as follows:</p>
     * <pre>
     * var foo:Function = myFunction() {
     *     //your code here
     *     };
     * myArray.filter(foo, me);
     * </pre></span>
	 * @playerversion Flash 9
	 * @langversion 3.0 
     * @param callback The function to run on each item in the array. This function can contain a simple command (such as changing the case of an array of strings) or a more complex operation and will be invoked with three arguments,
     * including the value of an item, the index of an item, and the Array object as in:
     * <pre>    function callback(item:&#42;, index:int, array:Array):void;</pre> 
	 *
	 * @param thisObject An object to use as <code>this</code> for the function.
	 * @return A new array containing the results of the function on each item in the original array.
	 *
	 * @includeExample examples\Array.map.as -noswf	 
	 * @see #filter() Array.filter()
	 */		
	public native function map(callback:Function, thisObject=null):Array
	
	/**
	 *  Removes the last element from an array and returns the value of that element.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return The value of the last element (of any data type) in the specified array.
	 * 
	 * @includeExample examples\Array.pop.1.as -noswf
	 *
	 * @see #push() Array.push()
	 * @see #shift() Array.shift()
	 * @see #unshift() Array.unshift()
	 *
	 * @helpid x208A2
	 * @refpath Objects/Core/Array/Methods/pop
	 * @keyword array.pop, pop
	 */
	public native function pop():Object;
	
	/**
	 * Adds one or more elements to the end of an array and returns the new length of the array.
	 *
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 *
	 * @param ...args One or more values to append to the array.
	 * @return An integer representing the length of the new array.
	 * 
	 * @includeExample examples\Array.push.1.as -noswf
	 * @includeExample examples\Array.push.2.as -noswf
	 * 
	 * @see #pop() Array.pop()
	 * @see #shift() Array.shift()
	 * @see #unshift() Array.unshift()
	 *
	 * @helpid x208A3
	 * @refpath Objects/Core/Array/Methods/push
	 * @keyword array.push, push
	 */
	public native function push( ...args):uint;
	
	/**
	 *  Reverses the array in place.
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
         * 
         * @includeExample examples\Array.reverse.1.as -noswf
	 *
	 * @return The new array.
	 * @helpid x2099E
	 * @refpath Objects/Core/Array/Methods/reverse 
	 * @keyword array.reverse, reverse
	 */
	public native function reverse():Array;
	
	/**
	 * Removes the first element from an array and returns that element. The remaining elements in the array are moved
     * from their original position, i, to i-1.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return The first element (of any data type) in an array.
	 * 
	 * @includeExample examples\Array.shift.1.as -noswf
	 *
	 * @see #pop() Array.pop()
	 * @see #push() Array.push()
	 * @see #unshift() Array.unshift()
	 *
	 * @helpid x208A4
	 * @refpath Objects/Core/Array/Methods/shift
	 * @keyword array.shift, shift
	 */
	public native function shift():Object;
	
	/**
	 * Returns a new array that consists of a range of elements from the original array, without modifying the original array. The returned array includes the <code>startIndex</code> element and all elements up to, but not including, the <code>endIndex</code> element. 
	 * <p>If you don't pass any parameters, a duplicate of the original array is created.</p>
	 *
	 * @tiptext Returns a new array that consists of a range of elements from the original array.
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 *
	 * @param startIndex A number specifying the index of the starting point 
	 * for the slice. If <code><em>start</em></code> is a negative number, the starting 
	 * point begins at the end of the array, where -1 is the last element.	
	 *
	 * @param endIndex A number specifying the index of the ending point for 
	 * the slice. If you omit this parameter, the slice includes all elements from the 
	 * starting point to the end of the array. If <code><em>end</em></code> is a negative 
	 * number, the ending point is specified from the end of the array, where -1 is the 
	 * last element.
	 *
	 * @return An array that consists of a range of elements from the original array.
	 *
	 * @includeExample examples\Array.slice.1.as -noswf
	 * @includeExample examples\Array.slice.2.as -noswf
	 * @includeExample examples\Array.slice.3.as -noswf
	 *
	 * @helpid x208A5
	 * @refpath Objects/Core/Array/Methods/slice
	 * @keyword array.slice, slice
	 */
	public native function slice(startIndex:int=0, endIndex:int=-1):Array;

	/**
     * Executes a test function on each item in the array until an item is reached that returns <code>true</code> for the specified function. Use this method to find out if any items in an array meet a certain criterion, such as having a value less than some number.
     * <span class="flashonly"><p>For this method, the second parameter, <code>thisObject</code>, must be null if the
     * first parameter, <code>callback</code>, is a method closure. In other words, if you create a function in a movie clip
     * called <code>me</code>:</p>
     * <pre>
     * function myFunction(){
     *    //your code here
     * }
     * </pre>
     * <p>and then use the filter method on an array called myArray:</p>
     * <pre>
     * myArray.filter(myFunction, me);
     * </pre>
     * <p>the function <code>myFunction</code> is a member function of the Timeline class, which cannot be overridden 
     * by <code>me</code>. Flash Player will throw an exception.
     * You can avoid this runtime error by assigning the function to a variable, as follows:</p>
     * <pre>
     * var foo:Function = myFunction() {
     *     //your code here
     *     };
     * myArray.filter(foo, me);
     * </pre></span>
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * @param callback The function to run on each item in the array. This function can contain a simple comparison (for example
     * <code>item &lt; 20</code>) or a more complex operation and it is invoked with three arguments, including the
     * value of an item, the index of an item, and the Array object as in:
     * <pre>    function callback(item:&#42;, index:int, array:Array):void;</pre> 
	 *
	 * @param thisObject An object to use as <code>this</code> for the function.
	 * @return A Boolean value; <code>true</code> if any items in the array return <code>true</code> for the specified function, otherwise <code>false</code>.
	 *
	 * @includeExample examples\Array.some.as -noswf	 
	 * @see #every() Array.every()
	 */		
	public native function some(callback:Function, thisObject=null):Boolean;
	
	
	/**
	 * Sorts the elements in an array. Flash sorts according to Unicode values. (ASCII is a subset of Unicode.)
	 * <p>By default, <code>Array</code>.<code>sort()</code> works in the following way:</p>
	 * <ul>
	 *   <li>Sorting is case-sensitive (<em>Z</em> precedes <em>a</em>).</li>
	 *   <li>Sorting is ascending (<em>a</em> precedes <em>b</em>). </li>
	 *   <li>The array is modified to reflect the sort order; multiple elements that have identical sort fields are placed consecutively in the sorted array in no particular order.</li>
	 *   <li>All elements, whatever the data type, are sorted as if they were strings, so 100 precedes 99, because &#34;1&#34; is a lower string value than &#34;9&#34;.</li>
	 * </ul>
	 * <p>
	 * To sort an array by using settings that deviate from the default settings, 
	 * you can either use one of the sorting options described in the <code>...args</code> parameter entry 
	 * for the <code>sortOptions</code> argument or you can create your own custom function to do the sorting. 
	 * If you create a custom function, you can use it by calling the <code>sort()</code> method, using the name
	 * of your custom function as the first argument (<code>compareFunction</code>) 
	 * </p>
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @param ...args The arguments specifying a comparison function and one or more values that determine the behavior of the sort.
	 * <p>This method uses the syntax and argument order <code>Array.sort(compareFunction, sortOptions)</code> with the arguments defined as:</p>
     * <ul><li><code>compareFunction</code> - A comparison function used to determine the sorting order of elements in an array. This argument is optional. A function should take two arguments to compare. Given the elements A and B, the result of <code>compareFunction</code> can have one of the following three values:
	 * <ul>
	 *   <li>-1, if A should appear before B in the sorted sequence</li>
	 *   <li>0, if A equals B</li>
	 *   <li>1, if A should appear after B in the sorted sequence</li>
	 * </ul>
	 * </li>
	 * <li><code>sortOptions</code> - One or more numbers or names of defined constants, separated by the <code>|</code> <code>(bitwise OR)</code> operator, that change the behavior of the sort from the default. This argument is optional. The following values are acceptable for <code>sortOptions</code>: 
	 *  <ul>
	 *   <li>1 or <code>Array.CASEINSENSITIVE</code></li>
	 *   <li>2 or <code>Array.DESCENDING</code></li>
	 *   <li>4 or <code>Array.UNIQUESORT</code></li>
	 *   <li>8 or <code>Array.RETURNINDEXEDARRAY</code> </li>
	 *   <li>16 or <code>Array.NUMERIC</code></li>
	 * </ul>
	 * For more information, see the <code>Array.sortOn()</code> method.</li>
	 * </ul>
	 * <span class="hide"><p><strong>Note: </strong>The <code>Array.sort()</code> method is defined in the ECMAScript (ECMA-262) edition 3
     * language specification, but the 
	 * array sorting options introduced in Flash Player 7 are Flash-specific extensions to 
	 * ECMA-262.
	 * </p></span>
	 * @return The return value depends on whether you pass any arguments, as described in 
	 * the following list:
	 * <ul>
	 *   <li>If you specify a value of 4 or <code>Array.UNIQUESORT</code> for the <code>sortOptions</code> argument
	 * of the <code>...args</code> parameter and two or more elements being sorted have identical sort fields,
	 * Flash returns a value of 0 and does not modify the array. </li>
  	 *   <li>If you specify a value of 8 or <code>Array.RETURNINDEXEDARRAY</code> for 
  	 * the <code>sortOptions</code> argument of the <code>...args</code> parameter, Flash returns a sorted numeric
     * array of the indices that reflects the results of the sort and does not modify the array. </li>
	 *   <li>Otherwise, Flash returns nothing and modifies the array to reflect the sort order.</li>
	 * </ul>
	 *
	 * @includeExample examples\Array.sort.1.as -noswf
	 * @includeExample examples\Array.sort.2.as -noswf
	 * @includeExample examples\Array.sort.3.as -noswf
	 * @includeExample examples\Array.sort.4.as -noswf
	 * @includeExample examples\Array.sort.5.as -noswf
	 * 
	 * @see operators.html#bitwise_OR | (bitwise OR)
	 * @see #sortOn() Array.sortOn()
	 *
	 * @helpid x209AF
	 * @refpath 
	 * @keyword array.sort, sort
	 */
	public native function sort(...args):Array; 
	
	/**
	 * Sorts the elements in an array according to one or more fields in the array. 
	 * The array should have the following characteristics:
	 * <ul>
	 *   <li>The array is an indexed array, not an associative array.</li>
 	 *   <li>Each element of the array holds an object with one or more properties.</li>
	 *   <li>All of the objects have at least one property in common, the values of which can be used
	 *       to sort the array. Such a property is called a <em>field</em>.</li>
	 * </ul>
	 * <p>If you pass multiple <code>fieldName</code> parameters, the first field represents the primary sort field, the second represents the next sort field, and so on. Flash sorts according to Unicode values. (ASCII is a subset of Unicode.) If either of the elements being compared does not contain the field that is specified in the <code>fieldName</code> parameter, the field is assumed to be set to <code>undefined</code>, and the elements are placed consecutively in the sorted array in no particular order.</p>
 	 * <p>By default, <code>Array</code>.<code>sortOn()</code> works in the following way:</p>
	 * <ul>
	 *   <li>Sorting is case-sensitive (<em>Z</em> precedes <em>a</em>).</li>
	 *   <li>Sorting is ascending (<em>a</em> precedes <em>b</em>). </li>
	 *   <li>The array is modified to reflect the sort order; multiple elements that have identical sort fields are placed consecutively in the sorted array in no particular order.</li>
	 *   <li>Numeric fields are sorted as if they were strings, so 100 precedes 99, because &#34;1&#34; is a lower string value than &#34;9&#34;.</li>
	 * </ul>
	 * <p>Flash Player 7 added the <code>options</code> parameter, which you can use to override the default sort behavior. To sort a simple array (for example, an array with only one field), or to specify a sort order that the <code>options</code> parameter doesn't support, use <code>Array.sort()</code>.</p>
 	 * <p>To pass multiple flags, separate them with the bitwise OR (<code>|</code>) operator:</p>
	 * <listing>
	 * my_array.sortOn(someFieldName, Array.DESCENDING | Array.NUMERIC);
	 * </listing>
	 * <p>Flash Player 8 added the ability to specify a different sorting option for each field when you sort by more than one field. In Flash Player 8, the <code>options</code> parameter accepts an array of sort options such that each sort option corresponds to a sort field in the <code>fieldName</code> parameter. The following example sorts the primary sort field, <code>a</code>, using a descending sort; the secondary sort field, <code>b</code>, using a numeric sort; and the tertiary sort field, <code>c</code>, using a case-insensitive sort:</p>
	 * <listing>
	 * Array.sortOn (["a", "b", "c"], [Array.DESCENDING, Array.NUMERIC, Array.CASEINSENSITIVE]);
	 * </listing>
	 * <p><strong>Note: </strong>The <code>fieldName</code> and <code>options</code> arrays must have the same number of elements; otherwise, the <code>options</code> array is ignored. Also, the <code>Array.UNIQUESORT</code> and <code>Array.RETURNINDEXEDARRAY</code> options can be used only as the first element in the array; otherwise, they are ignored.</p>
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 *
	 * @param fieldName A string that identifies a field to be used as the sort value, or an 
 	 * array in which the first element represents the primary sort field, the  second represents 
 	 * the secondary sort field, and so on.
	 *
	 * @param options One or more numbers or names of defined constants, separated by the <code>bitwise OR (|)</code> operator, that change the sorting behavior. The following values are acceptable for the <code>options</code> parameter:
	 * <ul>
	 *   <li><code><a href="#CASEINSENSITIVE">Array.CASEINSENSITIVE</a></code> or 1</li>
	 *   <li><code><a href="#DESCENDING">Array.DESCENDING</a></code> or 2</li>
	 *   <li><code><a href="#UNIQUESORT">Array.UNIQUESORT</a></code> or 4</li>
	 *   <li><code><a href="#RETURNINDEXEDARRAY">Array.RETURNINDEXEDARRAY</a></code> or 8</li>
	 *   <li><code><a href="#NUMERIC">Array.NUMERIC</a></code> or 16</li>
	 * </ul>
	 * <span class="flashonly"><p>Code hinting is enabled if you use the string form of the flag (for example, <code>DESCENDING</code>) rather than the numeric form (2).</p></span>
   	 *
	 *
	 * @return The return value depends on whether you pass any parameters:
	 * <ul>
	 *   <li>If you specify a value of 4 or <code>Array.UNIQUESORT</code> for the <code>options</code> parameter, and two or more elements being sorted have identical sort fields, a value of 0 is returned and the array is not modified. </li>
  	 *   <li>If you specify a value of 8 or <code>Array.RETURNINDEXEDARRAY</code> for the <code>options</code> parameter, an array is returned that reflects the results of the sort and the array is not modified.</li>
  	 *   <li>Otherwise, nothing is returned and the array is modified to reflect the sort order.</li>
	 * </ul>
	 * 
	 * @includeExample examples\Array.sortOn.1.as -noswf
	 * @includeExample examples\Array.sortOn.2.as -noswf
	 * @includeExample examples\Array.sortOn.3.as -noswf
	 *
	 * @see operators.html#bitwise_OR | (bitwise OR)
	 * @see #sort() Array.sort()
	 *
	 * @helpid x2058F
	 * @refpath Objects/Core/Array/Methods/sortOn
	 * @keyword array.sortOn, sortOn
	 */
	public native function sortOn(fieldName:Object, options:Object = null):Array; // 'key' is a String, or an Array of String. 'options' is optional.
	
	/**
	 * Adds elements to and removes elements from an array. This method modifies the array without 
	 * making a copy.
	 * <p><strong>Note:</strong> To override this method in a subclass of Array, use <code>...args</code> for the parameters.
	 * For example:</p>
	 * <pre>
	 * public override function splice(...args) {
	 *   // your statements here
	 * }
	 * </pre>
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @param startIndex An integer that specifies the index of the element in the array where the insertion or 
	 * deletion begins. You can specify a negative integer to specify a position relative to the end of the array
	 * (for example, -1 is the last element of the array).
	 * @param deleteCount An integer that specifies the number of elements to be deleted. This number includes the 
	 * element specified in the <code>startIndex</code> parameter. If no value is specified for the 
	 * <code>deleteCount</code> parameter, the method deletes all of the values from the <code>startIndex</code>
	 * element to the last element in the array. If the value is 0, no elements are deleted. 	 
	 * @param values An optional list of one or more comma-separated values, or an array,
	 * to insert into the array at the insertion point specified in the <code>startIndex</code> parameter.
	 *
	 * @return An array containing the elements that were removed from the original array.
	 * 
	 * @includeExample examples\Array.splice.1.as -noswf
	 *
	 * @helpid x208A6
	 * @refpath Objects/Core/Array/Methods/splice
	 * @keyword array.splice, splice
	 */
	public native function splice(startIndex:int, deleteCount:uint, ... values):Array;
	
	/**
	 * Returns a string value representing the elements in the specified Array object. Every element in the array, starting with index 0 and ending with the highest index, is converted to a concatenated string and separated by commas. To specify a custom separator, use the <code>Array.join()</code> method.
   	 *
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 *
	 * @return A string.
	 * 
	 * @includeExample examples\Array.toString.1.as -noswf
	 *
	 * <span class="flashonly"> <p>This example outputs 1,2,3,4,5 as a result of the <code>trace</code> statement.</p></span>
	 * <span class="flexonly"> <p>This example writes 1,2,3,4,5 to the log file.</p></span>
	 *
	 * @see String#split() String.split()
	 * @see #join() Array.join()
	 *
	 * @helpid x20A11
	 * @refpath Objects/Core/Array/Methods/toString
	 * @keyword array.toString, toString
	 */
	public native function toString():String;
	
	/**
     * Returns a string value representing the elements in the specified array object. Every element in the array, starting with index 0 and ending with the highest index, is converted to a concatenated string and separated by commas. In the ActionScript 3.0 implementation, this method returns the same value as the <code>Array.toString()</code> method.
   	 *
     *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return A string.
	 * @see #toString() Array.toString()
	 */
	public native function toLocaleString():String;
	
	/**
     * Adds one or more elements to the beginning of an array and returns the new length of the array. The other
     * elements in the array are moved from their original position, i, to i+1.
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 *
	 * @param ...args One or more numbers, elements, or variables to be inserted at the beginning of the array.  
	 *
	 * @return An integer representing the new length of the array.
	 * 
	 * @includeExample examples\Array.unshift.1.as -noswf
	 *
	 * @see Array#pop()
 	 * @see Array#push()
	 * @see Array#shift()
	 * @helpid x208A7
	 * @refpath Objects/Core/Array/Methods/unshift
	 * @keyword array.unshift, unshift
	 */
	public native function unshift( ...args):uint;
    
        /**
         * The default number of arguments for the constructor. You can specify 0, 1, or any number of arguments. For details, see the <code>Array()</code> constructor function.
         * @playerversion Flash 9
         * @langversion 3.0 
         * @see #Array()
         */
    public static const length:int = 1;
}


}
package {
//****************************************************************************
// ActionScript Standard Library
// Boolean object
//****************************************************************************
/**
* A data type that can have one of two values, either <code>true</code> or <code>false</code>.  
* Used for logical operations. Use the Boolean 
* class to retrieve the primitive data type or string representation of a Boolean object. 
* 
* <p>It makes no difference whether you use the constructor, the global function, or simply assign
* a literal value. The fact that all three ways of creating a Boolean are equivalent is new in ActionScript 3.0, 
* and different from a Boolean in JavaScript where a Boolean object is distinct from the Boolean primitive type.</p>
* 
*   <p>The following lines of code are equivalent:</p>
* <listing version="3.0">
* var flag:Boolean = true;
* var flag:Boolean = new Boolean(true);
* var flag:Boolean = Boolean(true);
* </listing>
* 
 * @includeExample examples\BooleanExample.as -noswf
* 
* @playerversion Flash 9
* @langversion 3.0 
* @helpid x208C1
* @keyword boolean, built-in class
* @refpath Objects/Core/Boolean/
*/
public final class Boolean
{
	
/**
 * Creates a Boolean object with the specified value. If you omit the <code><em>expression</em></code> 
 * parameter, the Boolean object is initialized with a value of <code>false</code>. If you 
 * specify a value for the <code><em>expression</em></code> parameter, the method evaluates it and returns the result 
 * as a Boolean value according to the rules in the global <code>Boolean()</code> function.
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 *
 * @param expression Any expression. 
 *
 * @return A reference to a Boolean object.
 *
 * @example The following code creates a new Boolean object, initialized to a value of <code>false</code> called <code>myBoolean</code>:
 * <listing version="3.0">
 * var myBoolean:Boolean = new Boolean();
 * </listing>
 *
 * @see package.html#Boolean() Boolean()
 * @helpid x208C0
 * @refpath Objects/Core/Boolean/new Boolean
 * @keyword new boolean, constructor
 */	
	public native function Boolean(expression:Object = false);

	
    /**
     * The default number of arguments for the constructor. For details, see the <code>Boolean()</code> constructor function.
     * @playerversion Flash 9
     * @langversion 3.0 
     * @see #Boolean()
     */
    public static const length:int = 1;
    
    /**
	 *  Returns the string representation (<code>"true"</code> or 
     * <code>"false"</code>) of the Boolean object. The output is not localized, and will be <code>"true"</code> or 
     * <code>"false"</code> regardless of the system language.
	 *
 	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return A string; <code>"true"</code> or <code>"false"</code>.
	 *
	 * @example This example creates a variable of type Boolean and then uses the <code>toString()</code> method
	 * to convert the value to a string for use in an array of strings:
	 * <listing version="3.0">
	 * var myStringArray:Array = new Array("yes", "could be");
	 * var myBool:Boolean = 0;
	 * myBool.toString();
	 * myStringArray.push(myBool);
	 * </listing>
	 *
	 *
	 * @helpid x208C2
	 * @refpath Objects/Core/Boolean/Methods/toString
	 * @keyword boolean.toString, toString
	 */
	public native function toString():String;
	
	/**
	 * Returns <code>true</code> if the value of the specified Boolean 
	 * object is true; <code>false</code> otherwise.  
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return A Boolean value.
	 *
	 * @example The following example shows how this method works, and also shows that the 
	 * value of a new Boolean object is <code>false</code>:
	 * <listing version="3.0">
	 * var myBool:Boolean = new Boolean();
	 * trace(myBool.valueOf());&#160;&#160;&#160;// false
	 * myBool = (6==3+3);
	 * trace(myBool.valueOf());&#160;&#160;&#160;// true  
	 * </listing>
	 *
	 *
	 * @helpid x208C3
	 * @refpath Objects/Core/Boolean/Methods/valueOf
	 * @keyword boolean.valueOf, valueOf
	 */
	public native function valueOf():Boolean;
}
}

package {
//****************************************************************************
// ActionScript Standard Library
// Class object
//****************************************************************************
/**
 * A class object is created for each class definition in a program. Every class object is an instance
 * of the Class class. The class object contains the static properties and methods of the class. The
 * class object creates instances of the class when invoked using the <code>new</code> operator.
 *
 * <p>Some methods return an object of type Class, such as <code>flash.net.getClassByAlias()</code>. 
 * Other methods may have a parameter of type Class, such as <code>flash.net.registerClassAlias()</code>. </p>
 * <p>The Class name is the reference to the class object.</p>
 * <p>For example:</p>
 * <pre> 
 * class Foo {
 * }
 * </pre> 
 * <p><code>class Foo{}</code> is the class definition that creates a class object Foo. Additionally, the statement
 * <code>new Foo()</code> will create a new instance of class Foo, and the result will be of type Foo.</p>
 * <p>Use the <code>class</code> statement to declare your classes. Class objects are useful for advanced 
 * techniques, such as the runtime assignment of classes to an existing instance object, as shown in the "Class Examples" 
 * section below.</p>
 * <p>Any static properties and methods of a class live on the class's Class object. Class, itself, declares 
 * <code>prototype</code>.</p>
 * 
 * <p>Generally, you do not need to declare or create variables of type Class manually. However, in the following 
 * code, a class is assigned as a public Class property <code>circleClass</code>, and you can refer to this Class property
 * as a property of the main Library class:</p>
 * <listing>
 * package {
 * 	import flash.display.Sprite;
 * 	public class Library extends Sprite {
 * 		
 * 		public var circleClass:Class = Circle;
 * 		public function Library() {
 * 		}
 * 	}
 * }
 *  
 * import flash.display.Shape;
 * class Circle extends Shape {
 * 	public function Circle(color:uint = 0xFFCC00, radius:Number = 10) {
 * 		graphics.beginFill(color);
 * 		graphics.drawCircle(radius, radius, radius);
 * 	}
 * }
 * </listing>
 * 
 * <p>Another SWF file can load the resulting Library.swf file and then instantiate objects of type Circle. The
 * following is one way, not the only way, to get access to a child SWF file's assets (other techniques include using
 * <code>flash.utils.getDefnitionByName()</code> or importing stub definitions of the child SWF file):</p>
 * 
 * <listing>
 * package {
 * 	import flash.display.Sprite;
 * 	import flash.display.Shape;
 * 	import flash.display.Loader;
 * 	import flash.net.URLRequest;
 * 	import flash.events.Event;
 * 	public class LibaryLoader extends Sprite {
 * 		public function LibaryLoader() {
 * 			var ldr:Loader = new Loader();
 * 			var urlReq:URLRequest = new URLRequest("Library.swf");
 * 			ldr.load(urlReq);
 * 			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
 * 		}
 * 		private function loaded(event:Event):void {
 * 			var library:Object = event.target.content;
 * 			var circle:Shape = new library.circleClass();
 * 			addChild(circle);
 * 		}
 * 	}
 * }
 * </listing>
 * <p>In ActionScript 3.0, you can create embedded classes for external assets (such as images, sounds, or fonts) that are 
 * compiled into SWF files. In earlier versions of ActionScript, you associated those assets using a linkage ID with the 
 * <code>MovieClip.attachMovie()</code> method. In ActionScript 3.0, each embedded asset is represented by a unique embedded 
 * asset class. So, you can use the <code>new</code> operator to instantiate the asset's associated class and call methods and properties
 * on that asset.</p>
 * <span class="flexonly"><p>For example, if you are using an MXML compiler to generate SWF files, you would create an embedded
 * class as follows:</p>
 * <pre>
 *     [Embed(source="bratwurst.jpg")]
 *     public var imgClass:Class;
 * </pre>
 * <p>And, to instantiate it, you write the following:</p>
 * <pre>
 *     var myImg:Bitmap = new imgClass();
 * </pre>
 * </span>
 * 
 * @includeExample examples\Class.1.as -noswf
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid 
 * @refpath 
 * @keyword Class
 * @see Object#prototype
 * @see operators.html#new new operator
 */
public dynamic class Class
{
}
}

package {
// Top Level Constants

/**
 * A special value representing positive <code>Infinity</code>. The value of this constant is the same as <code>Number.POSITIVE_<code>Infinity</code></code>.
 * @includeExample examples\Constants.Infinity.1.as -noswf
 * @see Number#POSITIVE_Infinity
 */
public const Infinity:Number;


/**
 * A special value representing negative <code>Infinity</code>. The value of this constant is the same as <code>Number.NEGATIVE_<code>Infinity</code></code>.
 * @includeExample examples\Constants.NegInfinity.1.as -noswf
 * @see Number#NEGATIVE_Infinity
 */
public const Infinity:Number;

/**
 * A special member of the Number data type that represents a value that is "not a number" (<code>NaN</code>). 
 * When a mathematical expression results in a value that cannot be expressed as a number, the result is <code>NaN</code>.
 * The following list describes common expressions that result in <code>NaN</code>.
 * <ul>
 *   <li>Division by 0 results in <code>NaN</code> only if the divisor is also 0. If the divisor is greater than 0, division by 0 results in <code><code>Infinity</code></code>. If the divisor is less than 0,  division by 0 results in <code><code>-Infinity</code></code>;</li>
 *   <li>Square root of a negative number;</li>
 *   <li>The arcsine of a number outside the valid range of 0 to 1;</li>
 *   <li><code>Infinity</code> subtracted from <code>Infinity</code>;</li>
 *   <li><code>Infinity</code> or <code>-Infinity</code> divided by <code>Infinity</code> or <code>-Infinity</code>;</li>
 *   <li><code>Infinity</code> or <code>-Infinity</code> multiplied by 0;</li>
  * </ul>
 * <p>The <code>NaN</code> value is not a member of the int or uint data types.</p>
 * <p>The <code>NaN</code> value is not considered equal to any other value, including <code>NaN</code>, which makes it impossible to use the equality operator to test whether an expression is <code>NaN</code>. To determine whether a number is the <code>NaN</code> function, use <code>isNaN()</code>.</p>
 * 
 * @see global#isNaN()
 * @see Number#NaN
 */
public const NaN:Number;


/**
 * A special value that applies to untyped variables that have not been initialized or dynamic object properties that are not initialized.
 * In ActionScript 3.0, only variables that are untyped can hold the value <code>undefined</code>,
 * which is not true in ActionScript 1.0 and ActionScript 2.0.
 * For example, both of the following variables are <code>undefined</code> because they are untyped and unitialized:
 * <ul>
 *   <li><code>var foo;</code></li>
 *   <li><code>var bar:~~;</code></li>
 * </ul>
 * <p>The <code>undefined</code> value also applies to uninitialized or undefined properties of dynamic objects.
 * For example, if an object is an instance of the Object class, 
 * the value of any dynamically added property is <code>undefined</code> until a value is assigned to that property.
 * </p>
 * <p>Results vary when <code>undefined</code> is used with various functions:</p>
 * <ul>
 * <li>The value returned by <code>String(undefined)</code> is <code>"undefined"</code> (<code>undefined</code> is
 * converted to a string).</li> 
 * <li>The value returned by <code>Number(undefined)</code> is <code>NaN</code>.</li> 
 * <li>The value returned by <code>int(undefined)</code> and <code>uint(undefined)</code> is 0.</li>
 * <li>The value returned by <code>Object(undefined)</code> is a new Object instance.</li>
 * <li>When the value <code>undefined</code> is assigned to a typed variable, 
 * the value is converted to the default value of the data type.</li>
 * </ul>
 * <p>Do not confuse <code>undefined</code> with <code>null</code>.
 * When <code>null</code> and <code>undefined</code> are compared with the equality
 * (<code>==</code>) operator, they compare as equal. However, when <code>null</code> and <code>undefined</code> are
 * compared with the strict equality (<code>===</code>) operator, they compare
 * as not equal.</p>
 * @includeExample examples\Constants.undefined.1.as -noswf
 * @includeExample examples\Constants.undefined.2.as -noswf
 * @see global#null
 */
public const undefined;
}
package {
//****************************************************************************
// ActionScript Standard Library
// Date object
//****************************************************************************


/**
 * The Date class represents date and time information. An instance of the Date class represents a particular point in time for which the properties such as month, day, hours and seconds can be queried or modified. The Date class lets you retrieve date and time values relative to universal time (Greenwich mean time, now called universal time or UTC) or relative to local time, which is determined by the local time zone setting on the operating system running Flash Player. The methods of the Date class are not static but apply only to the individual Date object specified when the method is called. The <code>Date.UTC()</code> and <code>Date.parse()</code> methods are exceptions; they are static methods.
 * <span class="flashonly"><p>The Date class handles daylight saving time differently, depending on the operating system and Flash Player version. Flash Player 6 and later versions handle daylight saving time on the following operating systems in these ways:</p>
 * <ul><li>Windows - the Date object automatically adjusts its output for daylight saving time. The Date object detects whether daylight saving time is employed in the current locale, and if so, it detects the standard-to-daylight saving time transition date and times. However, the transition dates currently in effect are applied to dates in the past and the future, so the daylight saving time bias might calculate incorrectly for dates in the past when the locale had different transition dates.</li>
 * <li>Mac OS X - the Date object automatically adjusts its output for daylight saving time. The time zone information database in Mac OS X is used to determine whether any date or time in the present or past should have a daylight saving time bias applied.</li>
 * <li>Mac OS 9 - the operating system provides only enough information to determine whether the current date and time should have a daylight saving time bias applied. Accordingly, the date object assumes that the current daylight saving time bias applies to all dates and times in the past or future.</li></ul>
 * <p>Flash Player 5 handles daylight saving time on the following operating systems as follows:</p>
 * <ul><li>Windows - the U.S. rules for daylight saving time are always applied, which leads to incorrect transitions in Europe and other areas that employ daylight saving time but have different transition times than the U.S. Flash correctly detects whether daylight saving time is used in the current locale.</li></ul></span>
 * <p>To use the Date class, construct a Date instance using the <code>new</code> operator.</p>
 * <p>ActionScript 3.0 adds several new accessor properties that can be used in place of many Date class methods that access or modify Date instances. ActionScript 3.0 also includes several new variations of the <code>toString()</code> method that are included for ECMA-262 3rd Edition compliance, including: <code>Date.toLocaleString()</code>, <code>Date.toTimeString()</code>, <code>Date.toLocaleTimeString()</code>, <code>Date.toDateString()</code>, <code>Date.toLocaleDateString()</code>.</p>
 * <p>To compute relative time or time elapsed, see the <code>getTimer()</code> method in the flash.utils package.</p>
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @includeExample examples\DateExample.as -noswf
 * @see flash.utils#getTimer() flash.utils.getTimer()
 * 
 * @helpid x208E9
 * @refpath Objects/Core/Date
 * @keyword Date object, built-in class, date 
 */
public final dynamic class Date
{
    /**
     * The default number of arguments for the constructor. You can specify 0, 1, or any number of arguments
     * up to a maximum of 7. For details, see the <code>Date()</code> constructor function.
     * @playerversion Flash 9
     * @langversion 3.0 
     * @see #Date()
     */
    public static const length:int = 7;

	/**
	 * The full year (a four-digit number, such as 2000) of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getFullYear()
	 * @see #setFullYear()
	 */
	public function get fullYear():Number { return getFullYear(); }
	public function set fullYear(value:Number):void { setFullYear(value); }

	/**
	 * The month (0 for January, 1 for February, and so on) portion of a <code>
	 * Date</code> object according to local time. Local time is determined by the operating system 
	 * on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getMonth()
	 * @see #setMonth()
	 */
	public function get month():Number { return getMonth(); }
	public function set month(value:Number):void { setMonth(value); }

	/**
	 * The day of the month (an integer from 1 to 31) specified by a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
 	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getDate()
	 * @see #setDate()
	 */
	public function get date():Number { return getDate(); }
	public function set date(value:Number):void { setDate(value); }

	/**
	 * The hour (an integer from 0 to 23) of the day portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running. 
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getHours()
	 * @see #setHours()
	 */
	public function get hours():Number { return getHours(); }
	public function set hours(value:Number):void { setHours(value); }

	/**
	 * The minutes (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getMinutes()
	 * @see #setMinutes()
	 */
	public function get minutes():Number { return getMinutes(); }
	public function set minutes(value:Number):void { setMinutes(value); }

	/**
	 * The seconds (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getSeconds()
	 * @see #setSeconds()
	 */
	public function get seconds():Number { return getSeconds(); }
	public function set seconds(value:Number):void { setSeconds(value); }

	/**
	 * The milliseconds (an integer from 0 to 999) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getMilliseconds()
	 * @see #setMilliseconds()
	 */
	public function get milliseconds():Number { return getMilliseconds(); }
	public function set milliseconds(value:Number):void { setMilliseconds(value); }

	/**
	 * The four-digit year of a <code>Date</code> object according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * 
	 * @see #getUTCFullYear()
	 * @see #setUTCFullYear()
	 */
	public function get fullYearUTC():Number { return getUTCFullYear(); }
	public function set fullYearUTC(value:Number):void { setUTCFullYear(value); }

	/**
	 * The month (0 [January] to 11 [December]) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCMonth()
	 * @see #setUTCMonth()
	 */
	public function get monthUTC():Number { return getUTCMonth(); }
	public function set monthUTC(value:Number):void { setUTCMonth(value); }

	/**
	 * The day of the month (an integer from 1 to 31) of a <code>Date</code> object 
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * 
	 * @see #getUTCDate()
	 * @see #setUTCDate()
	 */
	public function get dateUTC():Number { return getUTCDate(); }
	public function set dateUTC(value:Number):void { setUTCDate(value); }

	/**
	 * The hour (an integer from 0 to 23) of the day of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCHours()
	 * @see #setUTCHours()
	 */
	public function get hoursUTC():Number { return getUTCHours(); }
	public function set hoursUTC(value:Number):void { setUTCHours(value); }

	/**
	 * The minutes (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCMinutes()
	 * @see #setUTCMinutes()
	 */
	public function get minutesUTC():Number { return getUTCMinutes(); }
	public function set minutesUTC(value:Number):void { setUTCMinutes(value); }

	/**
	 * The seconds (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCSeconds()
	 * @see #setUTCSeconds()
	 */
	public function get secondsUTC():Number { return getUTCSeconds(); }
	public function set secondsUTC(value:Number):void { setUTCSeconds(value); }

	/**
	 * The milliseconds (an integer from 0 to 999) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCMilliseconds()
	 * @see #setUTCMilliseconds()
	 */
	public function get millisecondsUTC():Number { return getUTCMilliseconds(); }
	public function set millisecondsUTC(value:Number):void { setUTCMilliseconds(value); }

	/**
	 * The number of milliseconds since midnight January 1, 1970, universal time, 
	 * for a <code>Date</code> object. Use this method to represent a specific instant in time 
	 * when comparing two or more <code>Date</code> objects.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getTime()
	 * @see #setTime()
	 */
	public function get time():Number { return getTime(); }
	public function set time(value:Number):void { setTime(value); }

	/**
	 * The difference, in minutes, between the computer's local time and universal 
	 * time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getTimezoneOffset()
	 */
	public function get timezoneOffset():Number { return getTimezoneOffset(); }

	/**
	 * The day of the week (0 for Sunday, 1 for Monday, and so on) specified by this
	 * <code>Date</code> according to local time. Local time is determined by the operating 
	 * system on which Flash Player is running.
	 *
 	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getDay()
	 */
	public function get day():Number { return getDay(); }
	
	/**
	 * The day of the week (0 for Sunday, 1 for Monday, and so on) of this <code>Date
	 * </code> according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getUTCDay()
	 */
	public function get dayUTC():Number { return getUTCDay(); }
		
	/**
	 * Returns the number of milliseconds between midnight on January 1, 1970, universal time, 
	 * and the time specified in the parameters. This method uses universal time, whereas the 
	 * <code>Date</code> constructor uses local time.
	 * <p>This method is useful if you want to pass a UTC date to the Date class constructor.
	 * Because the Date class constructor accepts the millisecond offset as an argument, you
	 * can use the Date.UTC() method to convert your UTC date into the corresponding millisecond 
	 * offset, and send that offset as an argument to the Date class constructor:</p>
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param year A four-digit integer that represents the year (for example, 2000).
	 *
	 * @param month An integer from 0 (January) to 11 (December).
	 *
	 * @param date An integer from 1 to 31. 
	 *
	 * @param hour An integer from 0 (midnight) to 23 (11 p.m.).
	 *
	 * @param minute An integer from 0 to 59. 
	 *
	 * @param second An integer from 0 to 59. 
	 *
	 * @param millisecond An integer from 0 to 999. 
	 *
	 * @return The number of milliseconds since January 1, 1970 and the specified date and time.
	 * 
	 * @includeExample examples\Date.UTC.1.as -noswf
	 *
	 * @helpid x2090F
	 * @refpath Objects/Core/Date/Methods/UTC
	 * @keyword date.utc, utc, date
	 */
	public native static function UTC(year:Number,month:Number,date:Number = 1,
                        hour:Number = 0,minute:Number = 0,second:Number = 0,millisecond:Number = 0):Number;

	/**
	 * Constructs a new Date object that holds the specified date and time.  
	 * 
	 * <p>The <code>Date()</code> constructor takes up to seven parameters (year, month,  
	 * ..., millisecond) to specify a date and time to the millisecond. The date that
	 * the newly constructed Date object contains depends on the number, and data type, of arguments passed. </p>
	 * <ul>
	 *   <li>If you pass no arguments, the Date object is assigned the current date and time.</li>
	 *   <li>If you pass one argument of data type Number, the Date object is assigned a time value based on the number of milliseconds since January 1, 1970 0:00:000 GMT, as specified by the lone argument.</li>
	 *   <li>If you pass one argument of data type String, and the string contains a valid date, the Date object  contains a time value based on that date.</li>
	 *   <li>If you pass two or more arguments, the Date object is assigned a time value based on the argument values passed, which represent the date's year, month, date, hour, minute, second and milliseconds.</li>
	 * </ul>
	 * <p>If you pass a string to the Date class constructor, the date can be in a variety of formats, but must at least include the month, date and year. For example, <code>Feb 1 2005</code> is valid, but <code>Feb 2005</code> is not. The following list indicates some of the valid formats:</p>
	 * <ul>
	 *   <li>Day Month Date Hours:Minutes:Seconds GMT Year (for instance, "Tue Feb 1 00:00:00 GMT-0800 2005", which matches <code>toString()</code>)</li>
	 *   <li>Day Month Date Year Hours:Minutes:Seconds AM/PM (for instance, "Tue Feb 1 2005 12:00:00 AM", which matches <code>toLocaleString()</code>)</li>
	 *   <li>Day Month Date Year (for instance, "Tue Feb 1 2005", which matches <code>toDateString()</code>)</li>
	 *   <li>Month/Day/Year (for instance, "02/01/2005")</li>
	 *   <li>Month/Year (for instance, "02/2005")</li>
	 * </ul>
	 * @param yearOrTimevalue If other parameters are specified, this number represents a 
	 * year (such as 1965); otherwise, it represents a time value. If the number represents a year, a 
	 * value of 0 to 99 indicates 1900 through 1999; otherwise all four digits of the year must be 
	 * specified. If the number represents a time value (no other parameters are specified), it is the
	 * number of milliseconds before or after 0:00:00 GMT January 1, 1970; a negative values represents  
	 * a time <i>before</i> 0:00:00 GMT January 1, 1970, and a positive value represents a time after.
	 *
	 * @param month An integer from 0 (January) to 11 (December).
	 *
	 * @param date An integer from 1 to 31. 
	 *
	 * @param hour An integer from 0 (midnight) to 23 (11 p.m.).
	 *
	 * @param minute An integer from 0 to 59. 
	 *
	 * @param second An integer from 0 to 59. 
	 *
	 * @param millisecond An integer from 0 to 999 of milliseconds. 
	 * 
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @see #getMonth()
	 * @see #getDate()
	 * @see #getFullYear()
	 * @helpid x208FD
	 * @refpath Objects/Core/Date/new Date
	 * @keyword new Date, constructor, date
	 */
	public native function Date(yearOrTimevalue:Object,month:Number,date:Number = 1,hour:Number = 0,minute:Number = 0,second:Number = 0,millisecond:Number = 0);

	
	/**
	 * Returns the day of the month (an integer from 1 to 31) specified by a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
 	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The day of the month (1 - 31) a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getDate.1.as -noswf
	 *
	 * @see #getMonth()
	 * @see #getFullYear()
	 * @helpid x208EA
	 * @refpath Objects/Core/Date/Methods/getDate
	 * @keyword date.getdate, getdate, date
	 */
	public native function getDate():Number;
	
	/**
	 * Returns the day of the week (0 for Sunday, 1 for Monday, and so on) specified by this
	 * <code>Date</code> according to local time. Local time is determined by the operating 
	 * system on which Flash Player is running.
	 *
 	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return A numeric version of the day of the week (0 - 6) a <code>Date</code> object
	 * represents.
	 * 
	 * @includeExample examples\Date.getDay.1.as -noswf
	 *
	 * @helpid x208EB
	 * @refpath Objects/Core/Date/Methods/getDay
	 * @keyword date.getday, getday, date
	 */
	public native function getDay():Number;
	
	/**
	 * Returns the full year (a four-digit number, such as 2000) of a <code>Date</code> object 
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The full year a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getFullYear.1.as -noswf
	 *
	 * @helpid x208EC
	 * @refpath Objects/Core/Date/Methods/getFullYear
	 * @keyword date.getfullyear, getfullyear, date
	 */
	public native function getFullYear():Number;
	
	/**
	 * Returns the hour (an integer from 0 to 23) of the day portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running. 
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The hour (0 - 23) of the day a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getHours.1.as -noswf
	 *
	 * @helpid x208ED
	 * @refpath Objects/Core/Date/Methods/getHours
	 * @keyword date.gethours, gethours, date
	 */
	public native function getHours():Number;
	
	/**
	 * Returns the milliseconds (an integer from 0 to 999) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The milliseconds portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getMilliseconds.1.as -noswf
	 *
	 * @helpid x208EE
	 * @refpath Objects/Core/Date/Methods/getMilliseconds
	 * @keyword date.getmilliseconds, getmilliseconds, date
	 */
	public native function getMilliseconds():Number;
	
	/**
	 * Returns the minutes (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The minutes portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getMinutes.1.as -noswf
	 *
	 * @helpid x208EF
	 * @refpath Objects/Core/Date/Methods/getMinutes
	 * @keyword date.getminutes, getminutes, date
	 */
	public native function getMinutes():Number;
	
	/**
	 * Returns the month (0 for January, 1 for February, and so on) portion of this <code>
	 * Date</code> according to local time. Local time is determined by the operating system 
	 * on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The month (0 - 11) portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getMonth.1.as -noswf
	 *
	 * @helpid x208F0
	 * @refpath Objects/Core/Date/Methods/getMonth
	 * @keyword date.getmonth, getmonth, date
	 */
	public native function getMonth():Number;
	
	/**
	 * Returns the seconds (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The seconds (0 to 59) portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getSeconds.1.as -noswf
	 *
	 * @helpid x208F1
	 * @refpath Objects/Core/Date/Methods/getSeconds
	 * @keyword date.getseconds, getseconds, date
	 */
	public native function getSeconds():Number;
	
	/**
	 * Returns the number of milliseconds since midnight January 1, 1970, universal time, 
	 * for a <code>Date</code> object. Use this method to represent a specific instant in time 
	 * when comparing two or more <code>Date</code> objects.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The number of milliseconds since Jan 1, 1970 that a <code>Date</code> object represents.
	 *
	 * @includeExample examples\Date.getTime.1.as -noswf
	 * @includeExample examples\Date.getTime.2.as -noswf
	 * 
	 * @helpid x208F2
	 * @refpath Objects/Core/Date/Methods/getTime
	 * @keyword date.gettime, gettime, date
	 */
	public native function getTime():Number;
	
	/**
	 * Returns the difference, in minutes, between the computer's local time and universal 
	 * time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return Difference, in minutes, of local time and universal time (UTC).
	 * 
	 * @includeExample examples\Date.getTimezoneOffset.1.as -noswf
	 *
	 * @helpid x208F3
	 * @refpath Objects/Core/Date/Methods/getTimezoneOffset
	 * @keyword date.gettimezoneoffset, gettimezoneoffset, date
	 */
	public native function getTimezoneOffset():Number;
	
	/**
	 * Returns the day of the month (an integer from 1 to 31) of a <code>Date</code> object, 
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 * 
	 * @return The UTC day of the month (1 to 31) that a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getUTCDate.1.as -noswf
	 *
	 * @see #getDate()
	 * @helpid x208F4
	 * @refpath Objects/Core/Date/Methods/getUTCDate
	 * @keyword date.getutcdate, getutcdate, date
	 */
	public native function getUTCDate():Number;
	
	/**
	 * Returns the day of the week (0 for Sunday, 1 for Monday, and so on) of this <code>Date
	 * </code> according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC day of the week (0 to 6) that a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getUTCDay.1.as -noswf
	 *
	 * @see #getDay()
	 * @helpid x208F5
	 * @refpath Objects/Core/Date/Methods/getUTCDay
	 * @keyword date.getutcday, getutcday, date
	 */
	public native function getUTCDay():Number;
	
	/**
	 * Returns the four-digit year of a <code>Date</code> object according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC four-digit year a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getUTCFullYear.1.as -noswf
	 *
	 * @see #getFullYear()
	 * @helpid x208F6
	 * @refpath Objects/Core/Date/Methods/getUTCFullYear
	 * @keyword date.getutcfullyear, getutcfullyear, date
	 */
	public native function getUTCFullYear():Number;
	
	/**
	 * Returns the hour (an integer from 0 to 23) of the day of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC hour of the day (0 to 23) a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getUTCHours.1.as -noswf
	 *
	 * @see #getHours()
	 * @helpid x208F7
	 * @refpath Objects/Core/Date/Methods/getUTCHours
	 * @keyword date.getutchours, getutchours, date
	 */
	public native function getUTCHours():Number;
	
	/**
	 *  Returns the milliseconds (an integer from 0 to 999) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC milliseconds portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getUTCMilliseconds.1.as -noswf
	 *
	 * @helpid x208F8
	 * @refpath Objects/Core/Date/Methods/getUTCMilliseconds
	 * @keyword date.getutcmilliseconds, getutcmilliseconds, date
	 */
	public native function getUTCMilliseconds():Number;
	
	/**
	 * Returns the minutes (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC minutes portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getUTCMinutes.1.as -noswf
	 *
	 * @helpid x208F9
	 * @refpath Objects/Core/Date/Methods/getUTCMinutes
	 * @keyword date.getutcminutes, getutcminutes, date
	 */
	public native function getUTCMinutes():Number;
	
	/**
	 * Returns the month (0 [January] to 11 [December]) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC month portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getUTCMonth.1.as -noswf
	 *
	 * @see #getMonth()
	 * @helpid x208FA
	 * @refpath Objects/Core/Date/Methods/getUTCMonth
	 * @keyword date.getutcmonth, getutcmonth, date
	 */
	public native function getUTCMonth():Number;
	
	/**
	 * Returns the seconds (an integer from 0 to 59) portion of a <code>Date</code> object
	 * according to universal time (UTC).
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC seconds portion of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.getUTCSeconds.1.as -noswf
	 *
	 * @helpid x208FB
	 * @refpath Objects/Core/Date/Methods/getUTCSeconds
	 * @keyword date.getutcseconds, getutcseconds, date
	 */
	 
	public native function getUTCSeconds():Number;
	
	/**
	 * Returns the year of a <code>Date</code> object according to universal time (UTC). The year 
	 * is the full year minus 1900. For example, the year 2000 is represented as 100.
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The UTC year a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.getUTCYear.1.as -noswf
	 *
	 * @see #getFullYear()
	 * @helpid x208F6
	 * @refpath Objects/Core/Date/Methods/getUTCFullYear
	 * @keyword date.getutcfullyear, getutcfullyear, date
	 */
	public native function getUTCYear():Number;
	
	/**
	 * Returns the year of a <code>Date</code> object according to local time. Local time is 
	 * determined by the operating system on which Flash Player is running. The year is the 
	 * full year minus 1900. For example, the year 2000 is represented as 100.
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return An integer.
	 * 
	 * @includeExample examples\Date.getYear.1.as -noswf
	 *
	 * @see #getFullYear()
	 * @helpid x208FC
	 * @refpath Objects/Core/Date/Methods/getYear
	 * @keyword date.getyear, getyear, date
	 */
	public native function getYear():Number;
	
	/**
	 * Converts a string representing a date into a number equaling the number of milliseconds 
	 * elapsed since January 1, 1970, UTC.
	 *
     * @param date A string representation of a date, which conforms to the format for the output of
     * <code>Date.toString()</code>. The date format for the output of <code>Date.toString()</code> is: 
     * <pre>
     * Day Mon Date HH:MM:SS TZD YYYY
     * </pre>
     * <p>For example: </p>
     * <pre>
     * Wed Apr 12 15:30:17 GMT-0700 2006
     * </pre>
     * <p>Other supported formats include (and you can include partial representations of these, meaning 
     * just the month, day, and year):</p>
     * <pre>
     * MM/DD/YYYY HH:MM:SS TZD
     * YYYY-MM-DDThh:mm:ssTZD
     * </pre>
     *
	 * @return A number representing the milliseconds elapsed since January 1, 1970, UTC.
	 * 
	 * @includeExample examples\Date.parse.1.as -noswf
     * @see #toString() Date.toString()
	 */
	public native static function parse(date:String):Number;
	
	/**
	 * Sets the day of the month, according to local time, and returns the new time in 
	 * milliseconds. Local time is determined by the operating system on which Flash Player 
	 * is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param day An integer from 1 to 31.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setDate.1.as -noswf
	 *
	 * @helpid x208FE
	 * @refpath Objects/Core/Date/Methods/setDate
	 * @keyword date.setdate, setdate, date
	 */
	public native function setDate(day:Number):Number;
	
	/**
	 * Sets the year, according to local time, and returns the new time in milliseconds. If 
	 * the <code>month</code> and <code>day</code> parameters are specified, 
	 * they are set to local time. Local time is determined by the operating system on which 
	 * Flash Player is running.
	 * <p>
	 * Calling this method does not modify the other fields of the <code>Date</code> but 
	 * <code>Date.getUTCDay()</code> and <code>Date.getDay()</code> can report a new value 
	 * if the day of the week changes as a result of calling this method.
	 * </p>
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param year A four-digit number specifying a year. Two-digit numbers do not represent 
	 * four-digit years; for example, 99 is not the year 1999, but the year 99.
	 *
	 * @param month An integer from 0 (January) to 11 (December). 
	 *
	 * @param day A number from 1 to 31. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setFullYear.1.as -noswf
	 *
	 * @see #getUTCDay()
	 * @see #getDay()
	 * @helpid x208FF
	 * @refpath Objects/Core/Date/Methods/setFullYear
	 * @keyword date.setfullyear, setfullyear, date
	 */
	public native function setFullYear(year:Number, month:Number, day:Number):Number;
	
	/**
	 * Sets the hour, according to local time, and returns the new time in milliseconds. 
	 * Local time is determined by the operating system on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param hour An integer from 0 (midnight) to 23 (11 p.m.).
     * @param minute An integer from 0 to 59. 
     * @param second An integer from 0 to 59. 
     * @param millisecond An integer from 0 to 999. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setHours.1.as -noswf
	 *
	 * @helpid x20900
	 * @refpath Objects/Core/Date/Methods/setHours
	 * @keyword date.sethours, sethours, date
	 */
    public native function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the milliseconds, according to local time, and returns the new time in 
	 * milliseconds. Local time is determined by the operating system on which Flash Player 
	 * is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param millisecond An integer from 0 to 999.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setMilliseconds.1.as -noswf
	 *
	 * @helpid x20901
	 * @refpath Objects/Core/Date/Methods/setMilliseconds
	 * @keyword date.setmilliseconds, setmilliseconds, date
	 */
	public native function setMilliseconds(millisecond:Number):Number;
	
	/**
	 * Sets the minutes, according to local time, and returns the new time in milliseconds. 
	 * Local time is determined by the operating system on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param minute An integer from 0 to 59.
     * @param second An integer from 0 to 59.
     * @param millisecond An integer from 0 to 999.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setMinutes.1.as -noswf
	 *
	 * @helpid x20902
	 * @refpath Objects/Core/Date/Methods/setMinutes
	 * @keyword date.setminutes, setminutes, date
	 */
    public native function setMinutes(minute:Number, second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the month and optionally the day of the month, according to local time, and 
	 * returns the new time in milliseconds. Local time is determined by the operating 
	 * system on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param month An integer from 0 (January) to 11 (December).
	 *
	 * @param day An integer from 1 to 31. 
	 *
	 * @return The new time, in milliseconds.
	 *
	 * @includeExample examples\Date.setMonth.1.as -noswf
	 * 
	 * @helpid x20903
	 * @refpath Objects/Core/Date/Methods/setMonth
	 * @keyword date.setmonth, setmonth, date
	 */
	public native function setMonth(month:Number, day:Number):Number;
	
	/**
	 * Sets the seconds, according to local time, and returns the new time in milliseconds. 
	 * Local time is determined by the operating system on which Flash Player is running.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param second An integer from 0 to 59.
     * @param millisecond An integer from 0 to 999.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setSeconds.1.as -noswf
	 *
	 * @helpid x20904
	 * @refpath Objects/Core/Date/Methods/setSeconds
	 * @keyword date.setseconds, setseconds, date
	 */
	public native function setSeconds(second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the date in milliseconds since midnight on January 1, 1970, and returns the new 
	 * time in milliseconds. 
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param millisecond An integer value where 0 is midnight on January 1, universal time (UTC).
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setTime.1.as -noswf
	 *
	 * @helpid x20905
	 * @refpath Objects/Core/Date/Methods/setTime
	 * @keyword date.settime, settime, date
	 */
	public native function setTime(millisecond:Number):Number;
	
	/**
	 * Sets the day of the month, in universal time (UTC), and returns the new time in 
	 * milliseconds. Calling this method does not modify the other fields of a <code>Date
	 * </code> object, but the <code>Date.getUTCDay()</code> and <code>Date.getDay()</code> methods can report 
	 * a new value if the day of the week changes as a result of calling this method.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param day A number; an integer from 1 to 31.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCDate.1.as -noswf
	 *
	 * @see #getUTCDay()
	 * @see #getDay()
	 * @helpid x20906
	 * @refpath Objects/Core/Date/Methods/setUTCDate
	 * @keyword date.setutcdate, setutcdate, date
	 */
	public native function setUTCDate(day:Number):Number;
	
	/**
	 * Sets the year, in universal time (UTC), and returns the new time in milliseconds. 
	 * <p>
	 * Optionally, this method can also set the month and day of the month. Calling 
	 * this method does not modify the other fields, but the <code>Date.getUTCDay()</code> and 
	 * <code>Date.getDay()</code> methods can report a new value if the day of the week changes as a 
	 * result of calling this method. 
	 * </p>
	 *
 	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param year An integer that represents the year specified as a full four-digit year, 
	 * such as 2000.
	 *
	 * @param month An integer from 0 (January) to 11 (December). 
	 *
	 * @param day An integer from 1 to 31. 
	 *
	 * @return An integer.
	 * 
	 * @includeExample examples\Date.setUTCFullYear.1.as -noswf
	 *
	 * @see #getUTCDay()
	 * @see #getDay()
	 * @helpid x20907
	 * @refpath Objects/Core/Date/Methods/setUTCFullYear
	 * @keyword date.setutcfullyear, setutcfullyear, date
	 */
	public native function setUTCFullYear(year:Number, month:Number, day:Number):Number;
	
	/**
	 * Sets the hour, in universal time (UTC), and returns the new time in milliseconds. 
	 * Optionally, the minutes, seconds and milliseconds can be specified.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param hour An integer from 0 (midnight) to 23 (11 p.m.).
	 *
	 * @param minute An integer from 0 to 59. 
	 *
	 * @param second An integer from 0 to 59. 
	 *
	 * @param millisecond An integer from 0 to 999. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCHours.1.as -noswf
	 *
	 * @helpid x20908
	 * @refpath Objects/Core/Date/Methods/setUTCHours
	 * @keyword date.setutchours, setutchours, date
	 */
	public native function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the milliseconds, in universal time (UTC), and returns the new time in milliseconds.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param millisecond An integer from 0 to 999.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCMilliseconds.1.as -noswf
	 *
	 * @helpid x20909
	 * @refpath Objects/Core/Date/Methods/setUTCMilliseconds
	 * @keyword date.setutcmilliseconds, setutcmilliseconds, date
	 */
	public native function setUTCMilliseconds(millisecond:Number):Number;
	
	/**
	 * Sets the minutes, in universal time (UTC), and returns the new time in milliseconds.
	 * Optionally, you can specify the seconds and milliseconds.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param minute An integer from 0 to 59.
	 *
	 * @param second An integer from 0 to 59. 
	 *
	 * @param millisecond An integer from 0 to 999. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCMinutes.1.as -noswf
	 *
	 * @helpid x2090A
	 * @refpath Objects/Core/Date/Methods/setUTCMinutes
	 * @keyword date.setutcminutes, setutcminutes, date
	 */
	public native function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the month, and optionally the day, in universal time(UTC) and returns the new 
	 * time in milliseconds. Calling this method does not modify the other fields, but the
	 * <code>Date.getUTCDay()</code> and <code>Date.getDay()</code> methods might report a new 
	 * value if the day of the week changes as a result of calling this method.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param month An integer from 0 (January) to 11 (December).
	 *
	 * @param day An integer from 1 to 31. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCMonth.1.as -noswf
	 *
	 * @see #getDay()
	 * @helpid x2090B
	 * @refpath Objects/Core/Date/Methods/setUTCMonth
	 * @keyword date.setutcmonth, setutcmonth, date
	 */
	public native function setUTCMonth(month:Number, day:Number):Number;
	
	/**
	 * Sets the seconds, and optionally the milliseconds, in universal time (UTC) and 
	 * returns the new time in milliseconds.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param second An integer from 0 to 59.
	 *
	 * @param millisecond An integer from 0 to 999. 
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setUTCSeconds.1.as -noswf
	 *
	 * @helpid x2090C
	 * @refpath Objects/Core/Date/Methods/setUTCSeconds
	 * @keyword date.setutcseconds, setutcseconds, date
	 */
	public native function setUTCSeconds(second:Number, millisecond:Number):Number;
	
	/**
	 * Sets the year, in local time, and returns the new time in milliseconds. Local time is 
	 * determined by the operating system on which Flash Player is running.
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @param year A number that represents the year. If <code>year</code> is an 
	 * integer between 0 and 99, <code>setYear</code> sets the year at 1900 + 
	 * <code>year</code>; otherwise, the year is the value of the <code>year</code> 
	 * parameter.
	 *
	 * @return The new time, in milliseconds.
	 * 
	 * @includeExample examples\Date.setYear.1.as -noswf
	 *
	 * @helpid x2090D
	 * @refpath Objects/Core/Date/Methods/setYear
	 * @keyword date.setyear, setyear, date
	 */
	public native function setYear(year:Number):Number;

	
	/**
	 * Returns a string representation of the day and date only, and does not include the time or timezone.
	 * Contrast with the following methods:
	 * <ul>
	 *   <li><code>Date.toTimeString()</code>, which returns only the time and timezone</li>
	 *   <li><code>Date.toString()</code>, which returns not only the day and date, but also the time and timezone.</li>
	 * </ul>
	 *
	 * @playerversion Flash 9
	 * @langversion ActionScript 3.0 
	 *
	 * @return The string representation of day and date only.
	 * 
	 * @includeExample examples\Date.toDateString.1.as -noswf
	 *
	 * @see #toString()
	 */
	public native function toDateString():String;
	
	/**
	 * Returns a String representation of the time and timezone only, and does not include the day and date.
	 * Contrast with the <code>Date.toDateString()</code> method, which returns only the day and date.
	 *
	 * @playerversion Flash 9
	 * @langversion ActionScript 3.0 
	 *
	 * @return The string representation of time and timezone only.
	 * 
	 * @see #toDateString()
	 */
	public native function toTimeString():String;
	
	/**
	 * Returns a String representation of the day, date, time, given in local time.
	 * Contrast with the <code>Date.toString()</code> method, which returns the same information (plus the timezone)
	 * with the year listed at the end of the string.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return A string representation of a <code>Date</code> object in the local timezone.
	 *
	 */
	public native function toLocaleString():String;

	/**
	 * Returns a String representation of the day and date only, and does not include the time or timezone.
	 * This method returns the same value as <code>Date.toDateString</code>.
	 * Contrast with the following methods:
	 * <ul>
	 *   <li><code>Date.toTimeString()</code>, which returns only the time and timezone</li>
	 *   <li><code>Date.toString()</code>, which returns not only the day and date, but also the
	 * time and timezone.</li>
	 * </ul>
	 *
	 * @playerversion Flash 9
	 * @langversion ActionScript 3.0 
	 *
	 * @return The <code>String</code> representation of day and date only.
	 *
	 * @see #toDateString()
	 * @see #toTimeString()
	 * @see #toString()
	 */
	public native function toLocaleDateString():String;
	
	/**
	 * Returns a String representation of the time only, and does not include the day, date, year or timezone.
	 * Contrast with the <code>Date.toTimeString()</code> method, which returns the time and timezone.
	 *
	 * @playerversion Flash 9
	 * @langversion ActionScript 3.0 
	 *
	 * @return The string representation of time and timezone only.
	 * 
	 * @see #toTimeString()
	 */
	public native function toLocaleTimeString():String;

	/**
	 * Returns a String representation of the day, date, and time in universal time (UTC).
	 * For example, the date February 1, 2005 is returned as <code>Tue Feb 1 00:00:00 2005 UTC</code>.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The string representation of a <code>Date</code> object in UTC time.
	 * 
	 * @see #toString()
	 */
	 public native function toUTCString():String;

	
	/**
	 * Returns a String representation of the day, date, time, and timezone.
     * The date format for the output is: 
     * <pre>
     * Day Mon Date HH:MM:SS TZD YYYY
     * </pre>
     * <p>For example:</p>
     * <pre>
     * Wed Apr 12 15:30:17 GMT-0700 2006
     * </pre>
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The string representation of a <code>Date</code> object.
	 * 
	 * @includeExample examples\Date.toString.1.as -noswf
	 *
	 * @helpid x2090E
	 * @refpath Objects/Core/Date/Methods/toString
	 * @keyword date.tostring, tostring, date
	 */
	public native function toString():String;
	
	/**
	 * Returns the number of milliseconds since midnight January 1, 1970, universal time, 
	 * for a <code>Date</code> object.
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0 
	 *
	 * @return The number of milliseconds since January 1, 1970 that a <code>Date</code> object represents.
	 * 
	 * @includeExample examples\Date.valueOf.1.as -noswf
	 *
	 * @helpid
	 * @refpath Objects/Core/Date/Methods/valueOf
	 * @keyword date.valueof, valueof, date
	 */
	public native function valueOf():Number;
}


}
package {
//****************************************************************************
// ActionScript Standard Library
// DefinitionError object
//****************************************************************************
/**
 * The DefinitionError class represents an error that occurs whenever user code
 * attempts to define an identifier that is already defined. Common cases
 * where this error occurs include redefining classes, interfaces,  
 * or functions.
 * 
 * @tiptext An DefinitionError is thrown when code attempts to redefine a class,
 * interface, or function.
 * 
 * @includeExample 
 * 
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid 
 */
public dynamic class DefinitionError extends Error
{
	/**
	 * Creates a new DefinitionError object.
	 */
	public native function DefinitionError(message:String = "");
}


}
package flash.errors
{
   /**
	* An EOFError exception is thrown when you attempt to read past the end of the available data. For example, an 
	* EOFError is thrown when one of the read methods in the IDataInput interface is 
	* called and there is insufficient data to satisfy the read request. 
	* 
 	* @includeExample examples\EOFErrorExample.as -noswf
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* 
	* @see flash.utils.ByteArray
	* @see flash.utils.IDataInput
	* @see flash.net.Socket
	* @see flash.net.URLStream
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class EOFError extends IOError {
		/**
		* Creates a new EOFError object.
		* 
		* @param message A string associated with the error object.
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/
		function EOFError(message:String = "") {
			super(message);
		}	
	}
}
package {
//****************************************************************************
// ActionScript Standard Library
// Error object
//****************************************************************************
/**
 * Contains information about an error that occurred in a script. While developing ActionScript 3.0 applications,
 * you can run your compiled code and Flash Player will display exceptions of type Error, or of a subclass, 
 * in a dialog box at runtime to help you troubleshoot the code.
 * You create an Error object using the <code>Error</code> constructor function. 
 * Typically, you <code>throw</code> a new Error object from within a <code>try</code> 
 * code block that is then caught by a <code>catch</code> or <code>finally</code> code block.
 * <p>You can also create a subclass of the Error class and throw instances of that subclass.</p>
 *
 * @includeExample examples\ErrorExample.as -noswf
 * 
 * @tiptext An Error is thrown when an error occurs in a script.
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid 
 * @refpath 
 * @keyword Error
 */
public dynamic class Error extends Object
{
    /**
     * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>Error()</code> constructor function.
     * @playerversion Flash 9
     * @langversion 3.0 
     * @see #Error()
     */
    public static const length:int = 1;
    
    /**
     * Contains the reference number associated with the specific error message. For a custom Error object
     * this number is the value from the <code>id</code> parameter supplied in the constructor.
     * @return The error code number for a specific error message. 
     *
     * @playerversion Flash 9
     * @langversion 3.0 
     * 
     * @tiptext Contains the error number.
     *
     *
     * @helpid
     * @refpath 
     * @keyword Error.errorID, errorID
     */
    public native function get errorID():int;  
    
    /**
	 * Contains the message associated with the Error object. By default, the value of this property 
	 * is "<code>Error</code>". You can specify a <code>message</code> property when you create an 
	 * Error object by passing the error string to the <code>Error</code> constructor function.
	 *
	 *
 	 * @playerversion Flash 9
     	 * @langversion 3.0 
	 * 
	 * @tiptext Contains the error message associated with the Error instance.
	 *
	 * @oldexample In the following example, a method throws errors based on the 
	 * parameters passed to it. If either of the parameters is unspecified an instance of 
	 * the Error class with an appropriate message is thrown. If the second parameter is 
	 * zero an error with a different message gets thrown:
	 * <pre>
	 * function divideNum(num1:Number, num2:Number):Number {
	 *   if (isNaN(num1) || isNaN(num2)) {
	 *     throw new Error("divideNum function requires two numeric parameters.");
	 *   } else if (num2 == 0) {
	 *     throw new Error("cannot divide by zero.");
	 *   }
	 *   return num1/num2;
	 * }
	 * try {
	 *   var theNum:Number = divideNum(1, 0);
	 *   trace("SUCCESS! "+theNum);
	 * } catch (e_err:Error) {
	 *   trace("ERROR! "+e_err.message);
	 *   trace("\t"+e_err.name);
	 * }
	 * </pre>
	 * If you test this ActionScript with the specified parameters, an error message 
	 * displays indicating that you are attempting to divide by 0.
	 *
	 * @see statements.html#throw 
	 * @see statements.html#try..catch..finally
	 *
	 * @helpid
	 * @refpath 
	 * @keyword Error.message, message
	 */
	public var message:String;
	
	/**
	 *  Contains the name of the Error object. By default, the value of this property is "<code>Error</code>".
	 *
 	 * @playerversion Flash 9
         * @langversion 3.0 
	 * 
	 * @tiptext The name of the Error instance.
	 *
	 * @oldexample In the following example, a function throws a specified error depending on the two numbers that you try to divide. <span class="flashonly">Add the following ActionScript to Frame 1 of the Timeline:</span>
	 * <pre>
	 * function divideNumber(numerator:Number, denominator:Number):Number {
	 *   if (isNaN(numerator) || isNaN(denominator)) {
	 *     throw new Error("divideNum function requires two numeric parameters.");
	 *   } else if (denominator == 0) {
	 *     throw new DivideByZeroError();
	 *   }
	 *   return numerator/denominator;
	 * }
	 * try {
	 *   var theNum:Number = divideNumber(1, 0);
	 *   trace("SUCCESS! "+theNum);
	 *   // output: DivideByZeroError -&gt; Unable to divide by zero.
	 * } catch (e_err:DivideByZeroError) {
	 *   // divide by zero error occurred
	 *   trace(e_err.name+" -&gt; "+e_err.toString());
	 * } catch (e_err:Error) {
	 *   // generic error occurred
	 *   trace(e_err.name+" -&gt; "+e_err.toString());
	 * }
	 * </pre>
	 * <p>In the following example, we define a custom Error class called 
	 * DivideByZeroError:</p>
	 * <pre>
	 * class DivideByZeroError extends Error {
	 *   public DivideByZeroError() {
	 *   		super ("Unable to divide by zero.");
	 * 	 	name = "DivideByZeroError";
	 * 		}
	 * }
	 * </pre>
	 *<p>The following method then throws the custom error when it detects the 
	 * appropriate error conditions:</p>
	 * <pre>
	 * function divideNumbers(num1:Number, num2:Number) { etc.
	 * </pre>
	 * 
	 * @see statements.html#throw 
	 * @see statements.html#try..catch..finally 
	 *
	 * @helpid 
	 * @refpath 
	 * @keyword Error.name, name
	 */
	public var name:String;

	/**
	 * Creates a new Error object. If <code>message</code> is specified, its value is assigned 
	 * to the object's <code>Error.message</code> property.
	 *
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 * 
	 * @tiptext Creates a new Error instance with the specified error message.
	 *
	 * @param message A string associated with the Error object; this parameter 
	 * is optional. 
     * @param id A reference number to associate with the specific error message.
	 *
	 * @return A reference to an Error object.
	 * 
	 * @includeExample examples\Error.1.as -noswf
	 *
	 * @oldexample In the following example, a function throws an error (with a specified message) if the two strings that are passed to it are not identical:
	 * <pre>
	 * function compareStrings(str1_str:String, str2_str:String):void {
	 *   if (str1_str != str2_str) {
	 *     throw new Error("Strings do not match.");
	 *   }
	 * }
	 * try {
	 *   compareStrings("Dog", "dog");
	 *   // output: Strings do not match.
	 * } catch (e_err:Error) {
	 *   trace(e_err.toString());
	 * }
	 * </pre>
	 *
	 * @see statements.html#throw 
	 * @see statements.html#try..catch..finally 
	 *
	 * @helpid 
	 * @refpath 
	 * @keyword Error, constructor
	 */	
	public native function Error(message:String = "", id:int = 0);
	
	/**
	 * For debugger	versions of the Flash Player, only; this method returns the call stack for an error 
	 * as a string at the time of the error's construction. The first line of the return value is the 
	 * string representation of the exception object, followed by the strack trace elements. For example:
	 * <listing>
	 * TypeError: null cannot be converted to an object
	 *     at com.xyz.OrderEntry.retrieveData(OrderEntry.as:995)
	 *     at com.xyz.OrderEntry.init(OrderEntry.as:200)
	 *     at com.xyz.OrderEntry.$construct(OrderEntry.as:148)
   	 * </listing>
	 *
	 *
	 * @playerversion Flash 9
         * @langversion 3.0 
	 * 
	 * @tiptext Returns the call stack for an error in a readable form.
	 *
	 *
	 * @return A string representation of the call stack.
	 *
	 *
	 *
	 * @helpid 
	 * @refpath 
	 * @keyword Error, call stack
	 */	
	public native function getStackTrace():String	
	
	/**
	* 
	* Returns the string "Error" by default or the value contained in Error.message, if defined.
	*
        * @playerversion Flash 9
        * @langversion 3.0 
	* 
	* @tiptext Returns the error message, or the word "Error" if the message is 
	* undefined.
	*
	* @return The error message.
	* 
	* @includeExample examples\Error.toString.1.as -noswf
	* 
	* @oldexample In the following example, a function throws an error (with a specified message) if the two strings that are passed to it are not identical:
	* <pre>
	* function compareStrings(str1_str:String, str2_str:String):void {
	* if (str1_str != str2_str) {
	*   throw new Error("Strings do not match.");
	* 	}
	* }
	* try {
	* 	compareStrings("Dog", "dog");
	* 	// output: Strings do not match.
	* } catch (e_err:Error) {
	* 	trace(e_err.toString());
	* }
	* </pre>
	*
	* @see #message Error.message
	* @see statements.html#throw 
	* @see statements.html#try..catch..finally 
	* 
	* @helpid 
	* @refpath 
	* @keyword Error.toString, toString
	*/
	override native public function toString():String;
}


}
package {
//****************************************************************************
// ActionScript Standard Library
// EvalError object
//****************************************************************************
/**
 * The EvalError class represents an error that occurs whenever user code
 * calls the <code>eval()</code> function or attempts to use the <code>new</code>
 * operator with a Function object. Neither calling <code>eval()</code> nor 
 * calling <code>new</code> with a Function object is supported.
 * 
 * @tiptext An EvalError is thrown when code attempts to call eval() or use new with
 * a Function object.
 * 
 * @includeExample 
 * 
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid 
 */
public dynamic class EvalError extends Error
{
	/**
	 * Creates a new EvalError object.
	 */
	public native function EvalError(message:String = "");
}


}
package {
//****************************************************************************
// ActionScript Standard Library
// Function object
//****************************************************************************


/**
 * A Function is the basic unit of code that can be invoked in ActionScript.
 * Both user-defined and built-in functions in ActionScript are represented by Function objects, 
 * which are instances of the Function class.
 * <p>Methods of a class are slightly different than Function objects. Unlike an ordinary function object, a method is tightly linked to its associated class object. So, a method or property has a definition that is shared among all instances of the same class. Methods can be extracted from an instance and treated as "bound methods" (retaining the link to the original instance). For a bound method, the <code>this</code> keyword points to the original object that implemented the method. For a function, <code>this</code> points to the associated object at the time the function is invoked.</p>
 *
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @includeExample examples\FunctionExample.as -noswf
 * 
 * @tiptext The Function class is used to represent a built-in or user-defined function.
 *
 * @helpid 
 * @refpath 
 * @keyword Function, Function object, built-in class
 */
dynamic public class Function
{
 /**
  */
	public var prototype:Object;

 /**
  * Specifies the value of <code>thisObject</code> to be used within any function that ActionScript calls. 
  * This method also specifies the parameters to be passed to any called function. Because <code>apply()</code> 
  * is a method of the Function class, it is also a method of every Function object in ActionScript. 
  * <p>The parameters are specified as an Array object, unlike <code>Function.call()</code>, which specifies 
  * parameters as a comma-delimited list. This is often useful when the number of parameters to be passed is not
  * known until the script actually executes.</p>
  * <p>Returns the value that the called function specifies as the return value.</p>

  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Specifies the object instance on which the Function is called.
  *
  * @param thisObject The object to which myFunction is applied.
  *
  * @param argArray An array whose elements are passed to myFunction as parameters.
  *
  * @return Any value that the called function specifies.
  *
  *
  * @oldexample The following function invocations are equivalent:
  * <pre>
  * Math.atan2(1, 0)
  * Math.atan2.apply(null, [1, 0])
  * </pre>
  * <p>The following simple example shows how <code>apply()</code> passes an array of parameters:</p>
  * <pre>
  * function theFunction() {
  * 	trace(arguments);
  * }
  * 
  * // create a new array to pass as a parameter to apply()
  * var firstArray:Array = new Array(1,2,3);
  * theFunction.apply(null,firstArray);
  * // outputs: 1,2,3
  * 
  * // create a second array to pass as a parameter to apply()
  * var secondArray:Array = new Array("a", "b", "c");
  * theFunction.apply(null,secondArray);
  * // outputs a,b,c
  * </pre>
  * <p>The following example shows how <code>apply()</code> passes an array of parameters and specifies the value of this:</p>
  * <pre>
  * // define a function 
  * function theFunction() {
  * 	trace("this == myObj? " + (this == myObj));
  * 	trace("arguments: " + arguments);
  * }
  * 
  * // instantiate an object
  * var myObj:Object = new Object();
  * 
  * // create arrays to pass as a parameter to apply()
  * var firstArray:Array = new Array(1,2,3);
  * var secondArray:Array = new Array("a", "b", "c");
  * 
  * // use apply() to set the value of this to be myObj and send firstArray
  * theFunction.apply(myObj,firstArray);
  * // output: 
  * // this == myObj? true
  * // arguments: 1,2,3
  * 
  * // use apply() to set the value of this to be myObj and send secondArray
  * theFunction.apply(myObj,secondArray);
  * // output: 
  * // this == myObj? true
  * // arguments: a,b,c
  * </pre>
  *
  * @see #call() Function.call()
  * @helpid 
  * @refpath 
  * @keyword Function, Function.apply, apply
  */
	public native function apply(thisObject:Object,argArray:Array = null): void;
	
 /**
  * Invokes the function represented by a Function object. Every function in ActionScript 
  * is represented by a Function object, so all functions support this method. 
  * <p>In almost all cases, the function call (<code>()</code>) operator can be used instead of this method. 
  * The function call operator produces code that is concise and readable. This method is primarily useful 
  * when the <code>thisObject</code> parameter of the function invocation needs to be explicitly controlled. 
  * Normally, if a function is invoked as a method of an object, within the body of the function, <code>thisObject</code> 
  * is set to <code>myObject</code>, as shown in the following example:</p>
  * <listing>
  * myObject.myMethod(1, 2, 3);
  * </listing>
  * <p>In some situations, you might want <code>thisObject</code> to point somewhere else; 
  * for example, if a function must be invoked as a method of an object, but is not actually stored as a method 
  * of that object:</p>
  * <listing>
  * myObject.myMethod.call(myOtherObject, 1, 2, 3); 
  * </listing>
  * <p>You can pass the value null for the <code>thisObject</code> parameter to invoke a function as a 
  * regular function and not as a method of an object. For example, the following function invocations are equivalent:</p>
  * <listing>
  * Math.sin(Math.PI / 4)
  * Math.sin.call(null, Math.PI / 4)
  * </listing>
  *
  * <p>Returns the value that the called function specifies as the return value.</p>
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Invokes this Function. 
  *
  * @param thisObject An object that specifies the value of <code>thisObject</code> within the function body.
  *
  * @param parameter1 A parameter to be passed to the myFunction. You can specify zero or more parameters.
  *
  * @oldexample The following example uses <code>Function.call()</code> to make a function behave as a method of another object, without storing the function in the object:
  * <pre>
  * function myObject() {
  * }
  * function myMethod(obj) {
  *   trace("this == obj? " + (this == obj));
  * }
  * var obj:Object = new myObject();
  * myMethod.call(obj, obj);
  * </pre>
  * <span class="flashonly"><p>The <code>trace()</code> statement displays:</p></span>
  * <span class="flexonly"><p>The <code>trace()</code> statement sends the following code to the log file:</p></span>
  * <pre>
  * this == obj? true
  * </pre>
  *
  * @see #apply() Function.apply()
  * @helpid 
  * @refpath 
  * @keyword Function, Function.call, call
  */
	public native function call(thisObject:Object, parameter1:String = null): void;
 /**
  */	
	public native function toString():String;
}


}
package {
// Top Level functions

	
	/**
	 * Creates a new array. The array can be of length zero or more, or an array populated by a list of 
	 * specified elements, possibly of different data types. The number and data type of
	 * the arguments you use determine the contents of the returned array.
	 * <ul>
	 *   <li>Calling <code>Array()</code> with no arguments returns an empty array.</li>
	 *   <li>Calling <code>Array()</code> with a single integer argument returns an array of the specified length, but whose elements have undefined values.</li>
	 *   <li>Calling <code>Array()</code> with a list of specific values returns an array with elements that contain each of the specified values.</li>
	 * </ul>
	 * Using the <code>Array()</code> function is similar to creating an array with the Array class constructor.
	 * <p>Use the <code>as</code> operator for explicit type conversion, or type casting, 
	 * when the argument is not a primitive value. For more information, see the Example
	 * section of this entry. </p>
	 * @includeExample examples\Array.func.4.as -noswf
	 * @includeExample examples\Array.func.5.as -noswf
	 * @param args You can pass no arguments for an empty array, a single integer argument for an array of a specific length, or a series of comma-separated values of various types for an array populated with those values.
	 * @return An array of length zero or more.
	 * @see Array Array class
	 * @see operators.html#as as operator
	 */
	public native function Array(...args):Array
 
 	/**
	 * Converts the <code>expression</code> parameter to a Boolean value and returns the value. 
	 * <p>The return value depends on the data type and value of the argument, as described in the following table:</p>
	 *
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Input Value</th>
	 *     <th>Example</th>
	 *     <th>Return Value</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>0</code></td>
	 *     <td><code>0</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>NaN</code></td>
	 *     <td><code>NaN</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Number (not <code>0</code> or <code>NaN</code>)</td>
	 *     <td>4</td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Empty string</td>
	 *     <td><code>""</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Non-empty string</td>
	 *     <td><code>"6"</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>null</code></td>
	 *     <td><code>null</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>undefined</code></td>
	 *     <td><code>undefined</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>instance of Object class</td>
	 *     <td><code>var obj:Object = new Object();<br /> Boolean(obj)</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>No argument</td>
	 *     <td><code>Boolean()</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 * </table>
	 * <p>Unlike previous versions of ActionScript, the <code>Boolean()</code> function returns the same results as does the Boolean class constructor.</p>
	 * @param expression An expression or object to convert to Boolean.
	 * @return The result of the conversion to Boolean.
	 */
 	public native function Boolean(expression:Object):Boolean
	
	/**
	 * Decodes an encoded URI into a string. Returns a string in which all characters previously encoded 
	 * by the <code>encodeURI</code> function are restored to their unencoded representation.
	 * <p>The following table shows the set of escape sequences that are <i>not</i> decoded to characters by the <code>decodeURI</code> function. Use <code>decodeURIComponent()</code> to decode the escape sequences in this table.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Escape sequences not decoded</th>
	 *     <th>Character equivalents</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%23</code></td>
	 *     <td><code>#</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%24</code></td>
	 *     <td><code>$</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%26</code></td>
	 *     <td><code>&#38;</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%2B</code></td>
	 *     <td><code>+</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%2C</code></td>
	 *     <td><code>,</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%2F</code></td>
	 *     <td><code>/</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%3A</code></td>
	 *     <td><code>:</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%3B</code></td>
	 *     <td><code>;</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%3D</code></td>
	 *     <td><code>=</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%3F</code></td>
	 *     <td><code>?</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>%40</code></td>
	 *     <td><code>&#64;</code></td>
	 *   </tr>
	 * </table>
	 
	 * @param uri A string encoded with the <code>encodeURI</code> function.
	 * @return A string in which all characters previously escaped by the <code>encodeURI</code> function are
	 * restored to their unescaped representation.
	 * @includeExample examples\DecodeURIExample.as -noswf

	 * @see global#decodeURIComponent()
	 * @see global#encodeURI()
	 * @see global#encodeURIComponent()
	 */
	public native function decodeURI(uri:String):String
	
	/**
	 * Decodes an encoded URI component into a string. Returns a string in which 
	 * all characters previously escaped by the <code>encodeURIComponent</code> 
	 * function are restored to their uncoded representation.
	 * <p>This function differs from the <code>decodeURI()</code> function in that it is intended for use only with a part of a URI string, called a URI component.
	 * A URI component is any text that appears between special characters called <i>component separators</i> ( ":", "/", ";" and "?" ). 
	 * Common examples of a URI component are "http" and "www.adobe.com".</p>
	 * <p>Another important difference between this function and <code>decodeURI()</code> is that because this function
	 * assumes that it is processing a URI component it treats the escape sequences that represent special separator characters (<code>; / ? : &#64; &#38; = + $ , #</code>) as regular
	 * text that should be decoded. </p>
	 * @param uri A string encoded with the <code>encodeURIComponent</code> function.
	 * @return A string in which all characters previously escaped by the <code>encodeURIComponent</code> function are
	 * restored to their unescaped representation.
	 * @see global#decodeURI()
	 * @see global#encodeURI()
	 * @see global#encodeURIComponent()
	 */
	public native function decodeURIComponent(uri:String):String
	
	/**
	 * Encodes a string into a valid URI (Uniform Resource Identifier). 
	 * Converts a complete URI into a string in which all characters are encoded 
	 * as UTF-8 escape sequences unless a character belongs to a small group of basic characters.
	 * <p>The following table shows the entire set of basic characters that are <i>not</i> converted to UTF-8 escape sequences by the <code>encodeURI</code> function.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Characters not encoded</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>0 1 2 3 4 5 6 7 8 9</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>a b c d e f g h i j k l m n o p q r s t u v w x y z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>A B C D E F G H I J K L M N O P Q R S T U V W X Y Z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>; / ? : &#64; &#38; = + $ , #</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>- _ . ! ~ ~~ ' ( )</code></td>
	 *   </tr>
	 * </table>
	 * @param uri A string representing a complete URI.
	 * @return A string with certain characters encoded as UTF-8 escape sequences.
	 * @includeExample examples\EncodeURIExample.as -noswf
	 * @see global#decodeURI()
	 * @see global#decodeURIComponent()
	 * @see global#encodeURIComponent()
	 */
	public native function encodeURI(uri:String):String
	
	/**
	 * Encodes a string into a valid URI component. Converts a substring of a URI into a 
	 * string in which all characters are encoded as UTF-8 escape sequences unless a character
	 * belongs to a very small group of basic characters.
	 * <p>The <code>encodeURIComponent()</code> function differs from the <code>encodeURI()</code> function in that it is intended for use only with a part of a URI string, called a URI component.
	 * A URI component is any text that appears between special characters called <i>component separators</i> ( ":", "/", ";" and "?" ). 
	 * Common examples of a URI component are "http" and "www.adobe.com".</p>
	 * <p>Another important difference between this function and <code>encodeURI()</code> is that because this function
	 * assumes that it is processing a URI component it treats the special separator characters (<code>; / ? : &#64; &#38; = + $ , #</code>) as regular
	 * text that should be encoded. </p>
	 * <p>The following table shows all characters that are <i>not</i> converted to UTF-8 escape sequences by the <code>encodeURIComponent</code> function.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Characters not encoded</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>0 1 2 3 4 5 6 7 8 9</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>a b c d e f g h i j k l m n o p q r s t u v w x y z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>A B C D E F G H I J K L M N O P Q R S T U V W X Y Z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>- _ . ! ~ ~~ ' ( )</code></td>
	 *   </tr>
	 * </table>	 
	 * @see global#decodeURI()
	 * @see global#decodeURIComponent()
	 * @see global#encodeURI()
	 */
	public native function encodeURIComponent(uri:String):String
	
	/**
	 * Converts the parameter to a string and encodes it in a URL-encoded format, 
	 * where most nonalphanumeric characters are replaced with <code>%</code> hexadecimal sequences. 
	 * When used in a URL-encoded string, the percentage symbol (<code>%</code>) is used to introduce 
	 * escape characters, and is not equivalent to the modulo operator (<code>%</code>).
	 * <p>The following table shows all characters that are <i>not</i> converted to escape sequences by the <code>escape()</code> function.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Characters not encoded</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>0 1 2 3 4 5 6 7 8 9</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>a b c d e f g h i j k l m n o p q r s t u v w x y z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>A B C D E F G H I J K L M N O P Q R S T U V W X Y Z</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>&#64; - _ . ~~ + /</code></td>
	 *   </tr>
	 * </table>	 
	 
	 * @param str The expression to convert into a string and encode in a URL-encoded format.
	 * @return A URL-encoded string.
	 * @see global#unescape()
	 */
	public native function escape(str:String):String

	/**
	 * Converts a given numeric value to an integer value. Decimal values are truncated at the decimal point.
	 * @param value A value to be converted to an integer.
	 * @return The converted integer value.
	 * @see global#uint()
	 */
	public native function int(value:Number):int

	/**
	 * Returns <code>true</code> if the value is a finite number, 
	 * or <code>false</code> if the value is <code>Infinity</code> or <code>-Infinity</code>.
	 * The presence of <code>Infinity</code> or <code>-Infinity</code> indicates a mathematical
	 * error condition such as division by 0.
	 * @param num A number to evaluate as finite or infinite.
	 * @return Returns <code>true</code> if it is a finite number 
	 * or <code>false</code> if it is infinity or negative infinity.
	 */
	public native function isFinite(num:Number):Boolean
	
	
	/**
	 * Returns <code>true</code> if the value is <code>NaN</code>(not a number). The <code>isNaN()</code> function is useful for checking whether a mathematical expression evaluates successfully to a number. The <code>NaN</code> value is a special member of the Number data type that represents a value that is "not a number." 
	 * <p><strong>Note</strong>: The <code>NaN</code> value is not a member of the int or uint data types.</p>
	 * <p>The following table describes the return value of <code>isNaN()</code> on various input types and values.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Input Type/Value</th>
	 *     <th>Example</th>
	 *     <th>Return Value</th>
	 *   </tr>
	 *   <tr>
	 *     <td>0 divided by 0</td>
	 *     <td><code>isNaN(0/0)</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Non-zero number divided by <code>0</code></td>
	 *     <td><code>isNaN(5/0)</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Square root of a negative number</td>
	 *     <td><code>isNaN(Math.sqrt(-1))</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Arcsine of number greater than 1 or less than 0</td>
	 *     <td><code>isNaN(Math.asin(2))</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that can be converted to Number</td>
	 *     <td><code>isNaN("5")</code></td>
	 *     <td><code>false</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that cannot be converted to Number</td>
	 *     <td><code>isNaN("5a")</code></td>
	 *     <td><code>true</code></td>
	 *   </tr>
	 * </table>
	 * @param num A numeric value or mathematical expression to evaluate.
	 * @return Returns <code>true</code> if the value is <code>NaN</code>(not a number) and <code>false</code> otherwise.
	 */
	public native function isNaN(num:Number):Boolean

	/**
	 * Determines whether the specified string is a valid name for an XML element or attribute.
	 * @param str A string to evaluate.
	 * @return Returns <code>true</code> if the <code>str</code> argument is a valid XML name; <code>false</code> otherwise.
	 */
	public native function isXMLName(str:String):Boolean
	
	/**
	 * Converts a given value to a Number value. The following table shows the result of various input types:
	 * <br />
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Input Type/Value</th>
	 *     <th>Example</th>
	 *     <th>Return Value</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>undefined</code></td>
	 *     <td><code>Number(undefined)</code></td>
	 *     <td><code>NaN</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>null</code></td>
	 *     <td><code>Number(null)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>true</code></td>
	 *     <td><code>Number(true)</code></td>
	 *     <td><code>1</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>false</code></td>
	 *     <td><code>Number(false)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>NaN</code></td>
	 *     <td><code>Number(NaN)</code></td>
	 *     <td><code>NaN</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Empty string</td>
	 *     <td><code>Number("")</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that converts to Number</td>
	 *     <td><code>Number("5")</code></td>
	 *     <td>The number (e.g. <code>5</code>)</td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that does not convert to Number</td>
	 *     <td><code>Number("5a")</code></td>
	 *     <td><code>NaN</code></td>
	 *   </tr>
	 * </table>
	 * @param value A value to be converted to a number.
	 * @return The converted number value.
	 */
	public native function Number(expression:Object):Number
	 
	/**
	 * Every value in ActionScript 3.0 is an object, which means that calling Object() on a value returns that value.
	 * @param value An object or a number, string, or Boolean value to convert.
	 * @return The value specified by the <code>value</code> parameter.
	 */
	public native function Object(value:Object):Object
	
	/**
	 * Converts a string to an integer. If the specified string in the parameters cannot be converted to a number, the function returns <code>NaN</code>. Strings beginning with 0x are interpreted as hexadecimal numbers. Unlike in previous versions of ActionScript, integers beginning with 0 are <i>not</i> interpreted as octal numbers. You must specify a radix of 8 for octal numbers. White space and zeroes preceding valid integers is ignored, as are trailing nonnumeric characters.
	 * @param str A string to convert to an integer.
	 * @param radix An integer representing the radix (base) of the number to parse. Legal values are from 2 to 36.
	 * @return A number or <code>NaN</code> (not a number).
	 */
	public native function parseInt(str:String, radix:uint=0):Number
	
	/**
	 * Converts a string to a floating-point number. The function reads, or <i>parses</i>, and returns the numbers in a string until it reaches a character that is not a part of the initial number. If the string does not begin with a number that can be parsed, <code>parseFloat()</code> returns <code>NaN</code>. White space preceding valid integers is ignored, as are trailing nonnumeric characters.
	 * @param str The string to read and convert to a floating-point number.
	 * @return A number or <code>NaN</code> (not a number).
	 */
	public native function parseFloat(str:String):Number

	/**
	 * Returns a string representation of the specified parameter.
	 * <p>The following table shows the result of various input types:</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Input Type/Value</th>
	 *     <th>Return Value</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>undefined</code></td>
	 *     <td><code>undefined</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>null</code></td>
	 *     <td><code>"null"</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>true</code></td>
	 *     <td><code>"true"</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>false</code></td>
	 *     <td><code>"false"</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>NaN</code></td>
	 *     <td><code>"NaN"</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>String</td>
	 *     <td>String</td>
	 *   </tr>
	 *   <tr>
	 *     <td>Object</td>
	 *     <td>Object.toString()</td>
	 *   </tr>
	 *   <tr>
	 *     <td>Number</td>
	 *     <td>String representation of the number</td>
	 *   </tr>
	 * </table>
	 * @param expression  An expression to convert to a string.
	 * @return A string representation of the value passed for the <code>expression</code> parameter.
	 */
	public native function String(expression:Object):String

	/**
	 * Evaluates the parameter <code>str</code> as a string, decodes the string from URL-encoded format 
	 * (converting all hexadecimal sequences to ASCII characters), and returns the string.
	 * @param str A string with hexadecimal sequences to escape.
	 * @return A string decoded from a URL-encoded parameter.
	 */
	public native function unescape(str:String):String

	/**
	 * Converts a given numeric value to an unsigned integer value. Decimal values are truncated at the decimal point.
	 * <p>The following table describes the return value of <code>uint()</code> on various input types and values.</p>
	 * <table class="innertable">
	 *   <tr>
	 *     <th>Input Type/Value</th>
	 *     <th>Example</th>
	 *     <th>Return Value</th>
	 *   </tr>
	 *   <tr>
	 *     <td><code>undefined</code></td>
	 *     <td><code>uint(undefined)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>null</code></td>
	 *     <td><code>uint(null)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>0</code></td>
	 *     <td><code>uint(0)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>NaN</code></td>
	 *     <td><code>uint(NaN)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Positive floating point number</td>
	 *     <td><code>uint(5.31)</code></td>
	 *     <td>Truncated unsigned integer (e.g. <code>5</code>)</td>
	 *   </tr>
	 *   <tr>
	 *     <td>Negative floating point number</td>
	 *     <td><code>uint(-5.78)</code></td>
	 *     <td>Truncates to integer then applies rule for negative integers</td>
	 *   </tr>
	 *   <tr>
	 *     <td>Negative integer</td>
	 *     <td><code>uint(-5)</code></td>
	 *     <td>Sum of uint.MAX_VALUE and the negative integer (e.g. <code>uint.MAX_VALUE + (-5)</code>)</td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>true</code></td>
	 *     <td><code>uint(true)</code></td>
	 *     <td><code>1</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td><code>false</code></td>
	 *     <td><code>uint(false)</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>Empty String</td>
	 *     <td><code>uint("")</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that converts to Number</td>
	 *     <td><code>uint("5")</code></td>
	 *     <td>See rules for Numbers in this table</td>
	 *   </tr>
	 *   <tr>
	 *     <td>String that does not convert to Number</td>
	 *     <td><code>uint("5a")</code></td>
	 *     <td><code>0</code></td>
	 *   </tr>
	 * </table>

	 * @param value A value to be converted to an integer.
	 * @return The converted integer value.
	 * @see global#int()
	 */
	public native function uint(value:Number):uint
	
	/**
	 * Converts an object to an XML object. 
	 * <p>The following table describes return values for various input types.</p>
	 * 	<table class="innertable" width="640">
	 * 	<tr>
	 * 		<th>Parameter Type</th>
	 * 		<th>Return Value</th>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Boolean</td>
	 * 		<td>Value is first converted to a string, then converted to an XML object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Null</td>
	 * 		<td>A runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Number</td>
	 * 		<td>Value is first converted to a string, then converted to an XML object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Object</td>
	 * 		<td>Converts to XML only if the value is a String, Number or Boolean value. Otherwise a runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>String</td>
	 * 		<td>Value is converted to XML.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Undefined</td>
	 * 		<td>A runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>XML</td>
	 * 		<td>Input value is returned unchanged.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>XMLList</td>
	 * 		<td>Returns an XML object only if the XMLList object contains only one property of type XML. Otherwise a runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * </table>
	 * @param expression Object to be converted to XML.
	 * @return An XML object containing values held in the converted object.
	 * @see global#XMLList()
	 */
	public native function XML(expression:Object):XML
	
	/**
	 * Converts an object to an XMLList object, as described in the following table.
	 * <table class="innertable" width="640">
	 * 	<tr>
	 * 		<th>Parameter Type</th>
	 * 		<th>Return Value</th>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Boolean</td>
	 * 		<td>Value is first converted to a string, then converted to an XMLList object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Null</td>
	 * 		<td>A runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Number</td>
	 * 		<td>Value is first converted to a string, then converted to an XMLList object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Object</td>
	 * 		<td>Converts to XMLList only if the value is a String, Number or Boolean value. Otherwise a runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>String</td>
	 * 		<td>Value is converted to an XMLList object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>Undefined</td>
	 * 		<td>A runtime error occurs (TypeError exception).</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>XML</td>
	 * 		<td>Value is converted to an XMLList object.</td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td>XMLList</td>
	 * 		<td>Input value is returned unchanged.</td>
	 * 	</tr>
	 * </table>
	 * @param expression Object to be converted into an XMLList object.
	 * @return An XMLList object containing values held in the converted object.
	 * @see global#XML()
	 */
	public native function XMLList(expression:Object):XMLList


}
package flash.errors
{
   /**
	* The IllegalOperationError exception is thrown when a method is not implemented or the 
	* implementation doesn't cover the current usage.
	* 
	* Examples of illegal operation error exceptions include:
	* <ul>
	*     <li>A base class, such as DisplayObjectContainer, provides more functionality than a Stage 
	* can support (such as masks)</li>
	*     <li>Certain accessibility methods are called when Flash Player is compiled without accessibility 
	* support</li>
	*     <li>The mms.cfg setting prohibits a FileReference action</li>
	*     <li>ActionScript tries to run a FileReference.browse() call when a browse dialog box is already up</li>
	*     <li>ActionScript tries to use an unsupported protocol for FileReference (such as FTP)</li>
	* <span class="flashonly">
	*     <li>Authoring only features are invoked from a run-time player.</li>
	*     <li>An attempt is made to set the name of a timeline-placed object.</li>
	* </span>
	* </ul>
	* 
	*
	* 
 	* @includeExample examples\IllegalOperationErrorExample.as -noswf
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class IllegalOperationError extends Error {
		/**
		* Creates a new IllegalOperationError object.
		* 
		* @param message A string associated with the error object.
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/
		function IllegalOperationError(message:String = "") {
			super(message);
		}	
	}
}
package {
/**
 * A data type representing a 32-bit signed integer. 
 * The range of values represented by the int class is -2,147,483,648 (-2^31) to 2,147,483,647 (2^31-1).
 * <p>The properties of the int class are static, which means you do not need an object to use them, so you do not need to use the constructor. The methods, however, are not static, which means that you do need an object to use them. You can create an int object by using the int class constructor or by declaring a variable of type int and assigning the variable a literal value.</p>
 * <p>The int data type is useful for loop counters and other situations where a floating point number is not needed, and is similar to the int data type in Java and C++. The default value of a variable typed as int is <code>0</code></p>
 * <p>If you are working with numbers that exceed <code>int.MAX_VALUE</code>, consider using Number.  </p>
 * <p>The following example calls the <code>toString()</code> method of the int class, which returns the string <code>1234</code>: </p>
 * <listing version="3.0">
 * var myint:int = 1234;
 * myint.toString();
 * </listing>
 * <p>The following example assigns the value of the <code>MIN_VALUE</code> property to a variable declared without the use of the constructor:</p>
 * <pre>
 * var smallest:int = int.MIN_VALUE;
 * </pre> 
 *
 * @includeExample examples\IntExample.as -noswf
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 *
 * @see uint.html uint
 * @see Number.html Number
 * @helpid x2097D
 * @refpath Objects/Core/int
 * @keyword int object, int, built-in class
 */
public final class int
{
   /** 
	* The largest representable 32-bit signed integer, which is 2,147,483,647.
	*
    * @playerversion Flash 9
    * @langversion 3.0 
	*
	*
	* @example The following ActionScript <span class="flashonly">displays</span><span class="flexonly">writes</span> the largest and smallest representable ints <span class="flashonly">to the Output panel</span><span class="flexonly">to the log file</span>:
	* <pre>
	* trace("int.MIN_VALUE = "+int.MIN_VALUE);
	* trace("int.MAX_VALUE = "+int.MAX_VALUE);
	* </pre>
	* <p>This code <span class="flexonly">logs</span><span class="flashonly">displays</span> the following values:</p>
	* <pre>
	* int.MIN_VALUE = -2147483648
	* int.MAX_VALUE = 2147483647
	* </pre>
	*
	*
	* @helpid x20964
	* @refpath Objects/Core/int/Constants/MAX_VALUE
	* @keyword int, int.max_value, max_value, max value
	*/
	public static const MAX_VALUE:int = 2147483647;
 
	/**
	 * The smallest representable 32-bit signed integer, which is -2,147,483,648.
	 *
 	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
     * @example The following ActionScript <span class="flashonly">displays</span><span class="flexonly">writes</span> the largest and smallest representable ints<span class="flashonly"> to the Output panel</span><span class="flexonly"> to the log file</span>:
     * <pre>
     * trace("int.MIN_VALUE = "+int.MIN_VALUE);
     * trace("int.MAX_VALUE = "+int.MAX_VALUE);
     * </pre>
     * <p>This code <span class="flexonly">logs</span><span class="flashonly">displays</span> the following values:</p>
     * <pre>
	* int.MIN_VALUE = -2147483648
	* int.MAX_VALUE = 2147483647
     * </pre>
     *
     *
     * @helpid x2096B
     * @refpath Objects/Core/int/Constants/MIN_VALUE
     * @keyword int, int.min_value, min_value, min value
     */
	public static const MIN_VALUE:int = -2147483648;
 
	/**
	 * Constructor; creates a new int object. You must use the int constructor when using <code>int.toString()</code> and <code>int.valueOf()</code>. You do not use a constructor when using the properties of a int object. The <code>new int</code> constructor is primarily used as a placeholder. A int object is not the same as the <code>int()</code> function that converts a parameter to a primitive value.
	 *
 	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 *
	 * @param num The numeric value of the int object being created or a value to be converted to a&#160;number. The default value is 0 if <code>value</code> is not provided.
	 *
	 * @return A reference to a int object.
	 *
	 * @example The following code constructs new int objects:
	 * <pre>
	 * var n1:int = new int(3.4);
	 * var n2:int = new int(-10);
	 * </pre>
	 *
	 *
	 * @see int#toString()
	 * @see int#valueOf()
	 * @helpid x2097C
	 * @refpath Objects/Core/int/new int
	 * @keyword new number, constructor
	 */	
	public native function int(num:Object);
	
	/**
	 * Returns the string representation of an <code>int</code> object.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @param radix Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion. If you do not specify the <code><em>radix</em></code> parameter, the default value is 10.
	 *
	 * @return A string.
	 *
	 * @example The following example uses 2 and 8 for the <code><em>radix</em></code> parameter and returns a string that contains the corresponding representation of the number 9:
	 * <pre>
	 * var myint:int = new int(9);
	 * trace(myint.toString(2)); // output: 1001
	 * trace(myint.toString(8)); // output: 11
	 * </pre>
	 * <p>The following example results in a hexadecimal value.</p>
	 * <pre>
	 * var r:int = new int(250);
	 * var g:int = new int(128);
	 * var b:int = new int(114);
	 * var rgb:String = "0x"+ r.toString(16)+g.toString(16)+b.toString(16);
	 * trace(rgb); 
	 * // output: rgb:0xFA8072 (Hexadecimal equivalent of the color 'salmon')
	 * </pre>
	 *
	 * @helpid x2097E
	 * @refpath Objects/Core/int/Methods/toString
	 * @keyword number, number.tostring, tostring
	 */	
	public native function toString(radix:uint):String;	
	
	/**
	 * Returns the primitive value of the specified int object.
	 *
 	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return An int value.
	 *
	 * @example The following example results in the primative value of the <code>numSocks</code> object.
	 * <pre>
	 * var numSocks = new int(2);
	 * trace(numSocks.valueOf()); // output: 2
	 * </pre>
	 *
	 * @helpid x20A24
	 * @refpath Objects/Core/int/Methods/valueOf
	 * @keyword number, number.valueof, valueof, value of
	 */	
	public native function valueOf():int;
}
}
package flash.errors
{
   /**
	* The IOError exception is thrown when some type of input or output failure occurs. 
	* For example, an IOError exception is thrown if a read/write operation is attempted on 
	* a socket that has not connected or that has become disconnected.
	* 
	* 
 	* @includeExample examples\IOErrorExample.as -noswf
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class IOError extends Error {
	   /** 
		* Creates a new IOError object.
		* 
		* @param message A string associated with the error object.
		* 
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/
		function IOError(message:String = "") {
			super(message);
		}	
	}
}
package {
//****************************************************************************
// ActionScript Standard Library
// Math object
//****************************************************************************

/**
 * The Math class contains methods and constants that represent common mathematical
 * functions and values. 
 * <p>Use the methods and properties of this class to access and manipulate mathematical constants and functions.
 * All the properties and methods of the Math class are static and must be called using the syntax 
 * <code>Math.method(</code><code><em>parameter</em></code><code>)</code> or <code>Math.constant</code>. 
 * In ActionScript, constants are defined with the maximum precision of double-precision IEEE-754 floating-point numbers.</p>
 * <p>Several Math class methods use the measure of an angle in radians as a parameter. You can use the following equation 
 * to calculate radian values before calling the method and then provide the calculated value as the parameter, or you can 
 * provide the entire right side of the equation (with the angle's measure in degrees in place of <code>degrees</code>) as 
 * the radian parameter.</p>
 * <p>To calculate a radian value, use the following formula:</p>
 * <pre>
 * radians = degrees ~~ Math.PI/180
 * </pre>
 * <p>To calculate degrees from radians, use the following formula:</p>
 * <pre>
 * degrees = radians ~~ 180/Math.PI
 * </pre>
 * <p>The following is an example of passing the equation as a parameter to calculate the sine of a 45&#176; angle:</p>
 * <p><code>Math.sin(45 ~~ Math.PI/180)</code> is the same as <code>Math.sin(.7854)</code></p>
 * <p><b>Note:</b> The Math functions acos, asin, atan, atan2, cos, exp, log, pow, sin, and sqrt may 
 * result in slightly different values depending on the algorithms 
 * used by the CPU or operating system. Flash Player calls on the CPU (or operating system if the CPU doesn't support 
 * floating point calculations) when performing the calculations for the listed functions, and results have shown
 * slight variations depending upon the CPU or operating system in use.
 * </p>
 *
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @tiptext The Math class is a top-level class consisting of static properties and 
 * methods that define common mathematical constants and functions.
 *
 * @helpid 
 * @refpath 
 * @keyword math, math object, built-in class
 */
public final class Math
{
 /**
  * A mathematical constant for the base of natural logarithms, expressed as <em>e</em>.
  * The approximate value of <em>e</em><code> </code>is 2.71828182845905.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the base of natural logarithms, expressed as e.
  *
  * @oldexample This example shows how <code>Math.E</code> is used to compute 
  * continuously compounded interest for a simple case of 100 percent interest over 
  * a one-year period.
  * <pre>
  * var principal:Number = 100;
  * var simpleInterest:Number = 100;
  * var continuouslyCompoundedInterest:Number = (100 * Math.E) - principal;
  *
  * trace ("Beginning principal: $" + principal);
  * trace ("Simple interest after one year: $" + simpleInterest);
  * trace ("Continuously compounded interest after one year: $" + continuouslyCompoundedInterest);
  * 
  * // Output:
  * Beginning principal: $100
  * Simple interest after one year: $100
  * Continuously compounded interest after one year: $171.828182845905
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.e, e
  */
	public static const E:Number = 2.71828182845905;
 
 /**
  * A mathematical constant for the natural logarithm of 10, expressed as log<sub>e</sub>10,
  * with an approximate value of 2.302585092994046.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the natural logarithm of 10, expressed 
  * as loge10, with an approximate value of 2.302585092994046.
  *
  * @helpid 
  * @refpath 
  * @keyword math.ln10, ln10, logarithm
  */
	public static const LN10:Number = 2.302585092994046;
 
 /**
  * A mathematical constant for the natural logarithm of 2, expressed as log<sub>e</sub>2,
  * with an approximate value of 0.6931471805599453.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the natural logarithm of 2, expressed 
  * as loge2, with an approximate value of 0.6931471805599453.
  *
  * @helpid 
  * @refpath 
  * @keyword math.ln2, ln2, natural logarithm
  */
	public static const LN2:Number = 0.6931471805599453;
 
 /**
  * A mathematical constant for the base-10 logarithm of the constant e (<code>Math.E</code>),
  * expressed as log<sub>10</sub>e, with an approximate value of 0.4342944819032518. 
  * <p>The <code>Math.log()</code> method computes the natural logarithm of a number. Multiply the 
  * result of <code>Math.log()</code> by <code>Math.LOG10E</code> obtain the base-10 logarithm.</p>
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the base-10 logarithm of the constant 
  * e, expressed as log10e, with an approximate value of 0.4342944819032518.
  *
  * @oldexample This example shows how to obtain the base-10 logarithm of a number:
  * <pre>
  * trace(Math.log(1000) &#42; Math.LOG10E);<br />
  * // Output: 3<br />
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.log10e, log10e, logarithm
  */
	public static const LOG10E:Number = 0.4342944819032518;
 
 /**
  * A mathematical constant for the base-2 logarithm of the constant <em>e</em>, expressed 
  * as log2e, with an approximate value of 1.442695040888963387.
  *
  * <p>The <code>Math.log</code> method computes the natural logarithm of a number. Multiply the 
  * result of <code>Math.log()</code> by <code>Math.LOG2E</code> obtain the base-2 logarithm.</p>
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  *
  * @tiptext A mathematical constant for the base-2 logarithm of the constant 
  * e, expressed as log2e, with an approximate value of 1.442695040888963387.
  * 
  * @oldexample This example shows how to obtain the base-2 logarithm of a number:
  * <pre>
  * trace(Math.log(16) &#42; Math.LOG2E);<br />
  * // Output: 4<br />
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.log2e, log2e, logarithm
  */
	public static const LOG2E:Number = 1.442695040888963387;
 
 /**
  * A mathematical constant for the ratio of the circumference of a circle to its diameter,
  * expressed as pi, with a value of 3.141592653589793.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the ratio of the circumference of a 
  * circle to its diameter, expressed as pi, with a value of 3.141592653589793.
  *
  * @oldexample The following example draws a circle using the mathematical constant pi 
  * and the Drawing API.
  * <pre>
  * drawCircle(this, 100, 100, 50);
  * 
  * function drawCircle(mc:MovieClip, x:Number, y:Number, r:Number):void {
  *   mc.lineStyle(2, 0xFF0000, 100);
  *   mc.moveTo(x + r, y);
  *   mc.curveTo(r + x, Math.tan(Math.PI/8) * r + y, Math.sin(Math.PI / 4) * r + x, Math.sin(Math.PI/4)*r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)*r+x, r+y, x, r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)*r+x, r+y, -Math.sin(Math.PI/4)*r+x, Math.sin(Math.PI/4)*r+y);
  *   mc.curveTo(-r+x, Math.tan(Math.PI/8)*r+y, -r+x, y);
  *   mc.curveTo(-r+x, -Math.tan(Math.PI/8)*r+y, -Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)*r+x, -r+y, x, -r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)*r+x, -r+y, Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
  *   mc.curveTo(r+x, -Math.tan(Math.PI/8)*r+y, r+x, y);
  * }
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.pi, pi
  */
	public static const PI:Number = 3.141592653589793;
 
 /** 
  * A mathematical constant for the square root of one-half, with an approximate  
  * value of 0.7071067811865476.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the square root of one-half, with an 
  * approximate value of 0.7071067811865476.
  *
  * @helpid 
  * @refpath 
  * @keyword math.sqrt1_2, sqrt1_2, square root
  */
	public static const SQRT1_2:Number = 0.7071067811865476;
 
 /**
  * A mathematical constant for the square root of 2, with an approximate 
  * value of 1.4142135623730951.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext A mathematical constant for the square root of 2, with an 
  * approximate value of 1.4142135623730951.
  *
  * @helpid 
  * @refpath 
  * @keyword math.sqrt2, sqrt2, square root
  */
	public static const SQRT2:Number = 1.4142135623730951;

 
 /**
  * Computes and returns an absolute value for the number specified by the 
  * parameter <code>val</code>.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the absolute value of the specified Number.
  *
  * @param val The <code>Number</code> whose absolute value is returned.
  * @return The absolute value of the specified paramater.
  *
  * @oldexample The following example shows how <code>Math.abs()</code> returns 
  * the absolute value of a number and does not affect the value of the 
  * <code><em>val
  * </em></code> parameter (called <code>num</code> in this example):
  * <pre>
  * var num:Number = -12;
  * var numAbsolute:Number = Math.abs(num);
  * trace(num); // Output: -12
  * trace(numAbsolute); // Output: 12
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.abs, abs, absolute
  */
	public native static function abs(val:Number):Number;
 
 /**
  * Computes and returns the arc cosine of the number specified in the 
  * parameter <code>val</code>, in radians.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the arc cosine, in radians, of the specified 
  * Number. 
  *
  * @param val A number from -1.0 to 1.0.  
  *
  * @return The arc cosine of the parameter <code><em>val</em></code>.
  *
  * @oldexample The following example displays the arc cosine for several values.
  * <pre>
  * trace(Math.acos(-1)); // output: 3.14159265358979
  * trace(Math.acos(0));  // output: 1.5707963267949
  * trace(Math.acos(1));  // output: 0
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.acos, acos, arc cosine
  */
	public native static function acos(val:Number):Number;
 
 /**
  * Computes and returns the arc sine for the number specified in the 
  * parameter <code>val</code>, in radians.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the value, in radians, of the arc sine of the specified 
  * Number parameter.
  *
  * @param val A <code>Number</code> from -1.0 to 1.0.  
  *
  * @return A <code>Number</code> between negative pi divided by 2 and positive pi 
  * divided by 2.
  *
  * @oldexample The following example displays the arc sine for several values.
  * <pre>
  * trace(Math.asin(-1)); // output: -1.5707963267949
  * trace(Math.asin(0));  // output: 0
  * trace(Math.asin(1));  // output: 1.5707963267949
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.asin, asin, arc sine
  */
	public native static function asin(val:Number):Number;
 
 /**
  * Computes and returns the value, in radians, of the angle whose tangent is 
  * specified in the parameter <code>val</code>. The return value is between
  * negative pi divided by 2 and positive pi divided by 2.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the angle, in radians, whose tangent is specified by 
  * parameter val.
  *
  * @param val A <code>Number</code> that represents the tangent of an angle.  
  *
  * @return A <code>Number</code> between negative <em>pi</em> divided by 2 and positive 
  * <em>pi</em> divided by 2.
  *
  * @oldexample The following example displays the angle value for several tangents.
  * <pre>
  * trace(Math.atan(-1)); // output: -0.785398163397448
  * trace(Math.atan(0));  // output: 0
  * trace(Math.atan(1));  // output: 0.785398163397448
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.atan, atan, arc tangent
  */
	public native static function atan(val:Number):Number;
 
 /**
  * Computes and returns the angle of the point <code>y</code>/<code>x</code> in 
  * radians, when measured counterclockwise from a circle's <em>x</em> axis 
  * (where 0,0 represents the center of the circle). The return value is between 
  * positive pi and negative pi. Note that the first parameter to atan2 is always the y coordinate.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the angle of the point y/x in radians, when measured 
  * counterclockwise from a circle's x axis.
  *
  * @param y The <em>y</em> coordinate of the point.
  * @param x The <em>x</em>coordinate of the point.  
  *
  * @return A number.
  *
  * @see Math#acos()
  * @see Math#asin()
  * @see Math#atan()
  * @see Math#cos()
  * @see Math#sin()
  * @see Math#tan()   
  *
  * @oldexample The following example returns the angle, in radians, of the point specified by the coordinates (0, 10), such that x = 0 and y = 10. Note that the first parameter to atan2 is always the y coordinate.
  * <pre>
  * trace(Math.atan2(10, 0)); // output: 1.5707963267949
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.atan2, atan2, arc tangent
  */
	public native static function atan2(y:Number,x:Number):Number;
 
 /**
  * Returns the ceiling of the specified number or expression. The ceiling of a 
  * number is the closest integer that is greater than or equal to the number.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the ceiling of the specified number or expression.
  *
  * @param val A number or expression.
  * @return An integer that is both closest to, and greater than or equal to, parameter 
  * <code><em>val</em></code>.
  * 
  * @see Math#floor()
  * @see Math#round()
  *
  * @oldexample The following code returns a value of 13:
  * <pre>
  * Math.ceil(12.5);
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.ceil, ceil, ceiling
  */
	public native static function ceil(val:Number):Number;
 
 /**
  * Computes and returns the cosine of the specified angle in radians. To 
  * calculate a radian, see the overview of the Math class.
  * 
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the cosine of the specified angle.
  *
  * @param angleRadians A number that represents an angle measured in radians. 
  * @return  A number from -1.0 to 1.0.
  *
  * @oldexample The following example displays the cosine for several different angles.
  * <pre>
  * trace (Math.cos(0));         // 0 degree angle. Output: 1
  * trace (Math.cos(Math.PI/2)); // 90 degree angle. Output: 6.12303176911189e-17
  * trace (Math.cos(Math.PI));   // 180 degree angle. Output: -1
  * trace (Math.cos(Math.PI*2)); // 360 degree angle. Output: 1
  * </pre>
  * <p><strong>Note: </strong>The cosine of a 90 degree angle is zero, but because of the inherent inaccuracy of decimal 
  * calculations using binary numbers, Flash Player will report a number extremely close to, but not exactly equal to, zero.</p>
  *
  * @see Math#acos()
  * @see Math#asin()
  * @see Math#atan()
  * @see Math#atan2()
  * @see Math#sin()
  * @see Math#tan()
  *
  * @helpid 
  * @refpath 
  * @keyword math.cos, cos, cosine
  */
	public native static function cos(angleRadians:Number):Number;
 
 /**
  * Returns the value of the base of the natural logarithm (<em>e</em>), to the 
  * power of the exponent specified in the parameter <code>x</code>. The 
  * constant <code>Math.E</code> can provide the value of <em>e</em>.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  *
  * @tiptext Returns the value of the base of the natural logarithm 
  * (e), to the power of the exponent specified in the parameter val.
  * 
  * @param val The exponent; a number or expression.
  * @return <em>e</em> to the power of parameter <code>val</code>.
  *
  * @see Math#E
  * @helpid 
  * @refpath 
  * @keyword math.exp, exp, exponent
  */
	public native static function exp(val:Number):Number;
 
 /**
  * Returns the floor of the number or expression specified in the parameter 
  * <code>val</code>. The floor is the closest integer that is less than or equal
  * to the specified number or expression.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the floor of the number or expression specified in the 
  * parameter val.
  *
  * @param val A number or expression.
  * @return The integer that is both closest to, and less than or equal to, parameter 
  * <code>val</code>.
  *
  * @oldexample The following code returns a value of 12:
  * <pre>
  * <code>Math.floor(12.5);</code>
  * 
  * The following code returns a value of -7:
  * <code>Math.floor(-6.5);</code>
  * </pre>
  *
  * @helpid 
  * @refpath 
  * @keyword math.floor, floor
  */
	public native static function floor(val:Number):Number;
 
 /**
  * Returns the natural logarithm of parameter <code>val</code>.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the natural logarithm of parameter val. 
  *
  * @param val A number or expression with a value greater than 0.
  * @return  The natural logarithm of parameter <code><em>val</em></code>.
  *
  * @oldexample The following example displays the logarithm for three numerical values.
  * <pre>
  * trace(Math.log(0)); // output: -Infinity
  * trace(Math.log(1)); // output: 0
  * trace(Math.log(2)); // output: 0.693147180559945
  * trace(Math.log(Math.E)); // output: 1
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword math.log, log, logarithm
  */
	public native static function log(val:Number):Number;
 
 /**
  * Evaluates <code>val1</code> and <code>val2</code> (or more values) and returns the largest value.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Evaluates parameters val1 and val2 and 
  * returns the larger value.
  *
  * @param val1 A number or expression.
  * @param val2 A number or expression.
  * @param ... A number or expression. <code>Math.max()</code> can accept multiple arguments.
  * @return The largest of the parameters <code>val1</code> and <code>val2</code> (or more values).
  *
  * @oldexample The following example displays <code>Thu Dec 30 00:00:00 GMT-0700 2004</code>, which is the larger of the evaluated expressions.
  * <pre>
  * var date1:Date = new Date(2004, 11, 25);
  * var date2:Date = new Date(2004, 11, 30);
  * var maxDate:Number = Math.max(date1.getTime(), date2.getTime());
  * trace(new Date(maxDate).toString());
  * </pre>
  *
  * @see Math#min()
  *
  * @helpid 
  * @refpath 
  * @keyword math.max, max, maximum
  */
	public native static function max(val1:Number,val2:Number, ...rest):Number;
 
 /**
  * Evaluates <code>val1</code> and <code>val2</code> (or more values) and returns the smallest value.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Evaluates parameters val1 and val2 and returns the smaller value.
  *
  * @param val1 A number or expression.
  * @param val2 A number or expression.
  * @param ... A number or expression. <code>Math.min()</code> can accept multiple arguments.
  * @return The smallest of the parameters <code>val1</code> and <code>val2</code> (or more values).
  *
  * @oldexample The following example displays <code>Sat Dec 25 00:00:00 GMT-0700 2004</code>, which is the smaller of the evaluated expressions.
  * <pre>
  * var date1:Date = new Date(2004, 11, 25);
  * var date2:Date = new Date(2004, 11, 30);
  * var minDate:Number = Math.min(date1.getTime(), date2.getTime());
  * trace(new Date(minDate).toString());
  * </pre>
  *
  * @see Math#max()
  *
  * @helpid 
  * @refpath 
  * @keyword math.min, min, minimum
  */
	public native static function min(val1:Number,val2:Number, ... rest):Number;
 
 /**
  * Computes and returns <code>val1</code> to the power of <code>val2</code>.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns val1 to the power of val2.
  *
  * @param val1 A number to be raised by the power of parameter <code>val2</code>.
  * @param val2 A number specifying the power the parameter <code>val2</code> is raised by.
  * @return The value of parameter <code>val1</code> raised to the power of parameter 
  * <code>val2</code>.
  *
  * @oldexample The following example uses <code>Math.pow</code> and <code>Math.sqrt</code> to calculate the length of a line.
  * <pre>
  * 	this.createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
  * 	var mouseListener:Object = new Object();
  * 	mouseListener.onMouseDown = function() {
  *   	this.origX = _xmouse;
  *   	this.origY = _ymouse;
  * };
  * mouseListener.onMouseUp = function() {
  *	this.newX = _xmouse;
  *	this.newY = _ymouse;
  *   var minY = Math.min(this.origY, this.newY);
  *   var nextDepth:Number = canvas_mc.getNextHighestDepth();
  *   var line_mc:MovieClip = canvas_mc.createEmptyMovieClip("line"+nextDepth+"_mc", nextDepth);
  *   line_mc.moveTo(this.origX, this.origY);
  *   line_mc.lineStyle(2, 0x000000, 100);
  *   line_mc.lineTo(this.newX, this.newY);
  *   var hypLen:Number = Math.sqrt(Math.pow(line_mc._width, 2)+Math.pow(line_mc._height, 2));
  *   line_mc.createTextField("length"+nextDepth+"_txt", canvas_mc.getNextHighestDepth(), this.origX, this.origY-22, 100, 22);
  *   line_mc[&quot;length&quot;+nextDepth+&quot;_txt&quot;].text = Math.round(hypLen) +" pixels";
  * };
  * Mouse.addListener(mouseListener);
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword math.pow, pow, power
  */
	public native static function pow(val1:Number,val2:Number):Number;
 
 /**
  * Returns a pseudo-random number n, where 0 &lt;= n &lt; 1. The number returned is calculated in an undisclosed manner, and "pseudo-random" because the calculation inevitably contains some element of "non-randomness".
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns a pseudo-random number n, where 0 &lt;= n &lt; 1.
  *
  * @return A pseudo-random number.
  *
  * @oldexample The following example outputs 100 random integers between 4 and 11 
  * (inclusively):
  * <pre>
  * function randRange(min:Number, max:Number):Number {
  *    var randomNum:Number = Math.floor(Math.random() &#42; (max - min + 1)) + min;
  *    return randomNum;
  * }
  * for (var i = 0; i < 100; i++) {
  *    var n:Number = randRange(4, 11)
  *    trace(n);
  * }
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword math.random, random
  */
	public native static function random():Number;
 
 /**
  * Rounds the value of the parameter <code>val</code> up or down to the nearest
  * integer and returns the value. If parameter <code>val</code> is equidistant 
  * from its two nearest integers (that is, the number ends in .5), the value 
  * is rounded up to the next higher integer.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the value of parameter val rounded up or down to the 
  * nearest integer.
  *
  * @param val The number to round.
  * @return Parameter <code>val</code> rounded to the nearest whole number.
  *
  * @oldexample The following example returns a random number between two specified integers.
  * <pre>
  * function randRange(min:Number, max:Number):Number {
  *   var randomNum:Number = Math.round(Math.random() &#42; (max - min + 1) + (min - .5));
  *   return randomNum;
  * }
  * for (var i = 0; i&lt;25; i++) {
  *   trace(randRange(4, 11));
  * }
  * </pre>
  *
  * @see Math#ceil()
  * @see Math#floor()
  *
  * @helpid 
  * @refpath 
  * @keyword math.round, round
  */
	public native static function round(val:Number):Number;
 
 /**
  * Computes and returns the sine of the specified angle in radians. To 
  * calculate a radian, see the overview of the Math class.
  * 
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the sine of the specified angle.
  *
  * @param angleRadians A number that represents an angle measured in radians.
  * @return A number; the sine of the specified angle (between -1.0 and 1.0).
  *
  * @oldexample The following example draws a circle using the mathematical constant pi, the sine of an angle, and the Drawing API.
  * <pre>
  * drawCircle(this, 100, 100, 50);
  * //
  * function drawCircle(mc:MovieClip, x:Number, y:Number, r:Number):void {
  *   mc.lineStyle(2, 0xFF0000, 100);
  *   mc.moveTo(x+r, y);
  *   mc.curveTo(r+x, Math.tan(Math.PI/8)~r+y, Math.sin(Math.PI/4)~r+x, Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)~r+x, r+y, x, r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)~r+x, r+y, -Math.sin(Math.PI/4)~r+x, Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(-r+x, Math.tan(Math.PI/8)~r+y, -r+x, y);
  *   mc.curveTo(-r+x, -Math.tan(Math.PI/8)~r+y, -Math.sin(Math.PI/4)~r+x, -Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)~r+x, -r+y, x, -r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)~r+x, -r+y, Math.sin(Math.PI/4)~r+x, -Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(r+x, -Math.tan(Math.PI/8)~r+y, r+x, y);
  * }
  * </pre>
  *
  * @see Math#acos()
  * @see Math#asin()
  * @see Math#atan()
  * @see Math#atan2()
  * @see Math#cos()
  * @see Math#tan()
  *
  * @helpid 
  * @refpath 
  * @keyword math.sin, sin, sine
  */
	public native static function sin(angleRadians:Number):Number;
 
 /**
  * Computes and returns the square root of the specified number.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the square root of the specified number.
  *
  * @param val A number or expression greater than or equal to 0. 
  * @return A number if parameter <em>val</em> is greater than or equal to zero; NaN (not a number) otherwise.
  *
  * @oldexample The following example uses <code>Math.pow</code> and <code>Math.sqrt</code> to calculate the length of a line.
  * <pre>
  * this.createEmptyMovieClip("canvas_mc", this.getNextHighestDepth());
  * var mouseListener:Object = new Object();
  * mouseListener.onMouseDown = function() {
  *   this.origX = _xmouse;
  *   this.origY = _ymouse;
  * };
  * mouseListener.onMouseUp = function() {
  *   this.newX = _xmouse;
  *   this.newY = _ymouse;
  *   var minY = Math.min(this.origY, this.newY);
  *   var nextDepth:Number = canvas_mc.getNextHighestDepth();
  *   var line_mc:MovieClip = canvas_mc.createEmptyMovieClip("line"+nextDepth+"_mc", nextDepth);
  *   line_mc.moveTo(this.origX, this.origY);
  *   line_mc.lineStyle(2, 0x000000, 100);
  *   line_mc.lineTo(this.newX, this.newY);
  *   var hypLen:Number = Math.sqrt(Math.pow(line_mc._width, 2)+Math.pow(line_mc._height, 2));
  *   line_mc.createTextField("length"+nextDepth+"_txt", canvas_mc.getNextHighestDepth(), this.origX, this.origY-22, 100, 22);
  *   line_mc[&#39;length&#39;+nextDepth+&#39;_txt&#39;].text = Math.round(hypLen) +" pixels";
  * };
  * Mouse.addListener(mouseListener);
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword math.sqrt, sqrt, square root 
  */
	public native static function sqrt(val:Number):Number;
 
 /**
  * Computes and returns the tangent of the specified angle. To calculate a 
  * radian, see the overview of the Math class.
  *
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Returns the tangent of the specified angle.
  *
  * @param angleRadians A number that represents an angle measured in radians.
  * @return The tangent of parameter <code>angleRadians</code>.
  *
  * @oldexample The following example draws a circle using the mathematical constant pi, the tangent of an angle, and the Drawing API.
  * <pre>
  * drawCircle(this, 100, 100, 50);
  * //
  * function drawCircle(mc:MovieClip, x:Number, y:Number, r:Number):void {
  *   mc.lineStyle(2, 0xFF0000, 100);
  *   mc.moveTo(x+r, y);
  *   mc.curveTo(r+x, Math.tan(Math.PI/8)~r+y, Math.sin(Math.PI/4)~r+x, Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)~r+x, r+y, x, r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)~r+x, r+y, -Math.sin(Math.PI/4)~r+x, Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(-r+x, Math.tan(Math.PI/8)~r+y, -r+x, y);
  *   mc.curveTo(-r+x, -Math.tan(Math.PI/8)~r+y, -Math.sin(Math.PI/4)~r+x, -Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(-Math.tan(Math.PI/8)~r+x, -r+y, x, -r+y);
  *   mc.curveTo(Math.tan(Math.PI/8)~r+x, -r+y, Math.sin(Math.PI/4)~r+x, -Math.sin(Math.PI/4)~r+y);
  *   mc.curveTo(r+x, -Math.tan(Math.PI/8)~r+y, r+x, y);
  * }
  * </pre>
  *
  * @see Math#acos()
  * @see Math#asin()
  * @see Math#atan()
  * @see Math#atan2()
  * @see Math#cos()
  * @see Math#sin()
  *
  * @helpid 
  * @refpath 
  * @keyword math.tan, tan, tangent
  */
	public native static function tan(angleRadians:Number):Number;
}


}
package flash.errors
{
   /**
	* The MemoryError exception is thrown when a memory allocation request fails. 
	* 
	* <p>On a desktop machine, memory allocation failures are rare unless an allocation 
	* request is extremely large; a 32-bit Windows program can access only 2GB of
	* address space, for example, so a request for 10 billion bytes is impossible.</p>
	* 
	* <p>By default, Flash Player does not impose a limit on how much memory an 
	* ActionScript program may allocate.</p>
	* 
 	* @includeExample examples\MemoryErrorExample.as -noswf
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class MemoryError extends Error {
		
	   /** 
		* Creates a new MemoryError object.
		* 
		* @param message A string associated with the error object.
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/		
		function MemoryError(message:String = "") {
			super(message);
		}	
	}
}
package {
//
// Namespace
//

// Based on the ECMA E4X spec, 1st Edition

/**
*
* The Namespace class contains methods and properties for defining and working with namespaces. 
* There are three use cases for using namespaces:
*
* <ul>
* <li> <strong>Namespaces of XML objects</strong> Namespaces associate a namespace prefix with a Uniform Resource Identifier (URI) 
* that identifies the namespace. The prefix is a string used to reference the namespace within an 
* XML object. If the prefix is undefined, when the XML is converted to a string, a prefix is 
* automatically generated.
* </li>
* 
* <li> <strong>Namespace to differentiate methods</strong> Namespaces can differentiate methods with the same name to perform different tasks. 
* If two methods have the same name but separate namespaces, they can perform different tasks.
* </li>
* 
* <li> <strong>Namespaces for access control</strong> 
* Namespaces can be used to control access to a group of
* properties and methods in a class. If you place the
* group of properties and methods into a private
* namespace, those properties and methods are
* unreachable by any code that does not have access to
* that namespace. You can grant access to the group of
* properties and methods by passing the namespace to
* other classes, methods or functions.
* </li>
* </ul>
*
* <p>This class (along with the XML, XMLList, and QName classes) implements 
* powerful XML-handling standards defined in ECMAScript for XML 
* (E4X) specification (ECMA-357 edition 2).</p>
* 
* @includeExample examples\NamespaceExample.1.as -noswf
* @includeExample examples\NamespaceExample.2.as -noswf
* 
* @tiptext The Namespace class contains methods and properties for defining and 
* working with namespaces of XML objects.
* 
* @see XML
* @see XMLList
* @see QName
* @see http://www.ecma-international.org/publications/standards/Ecma-357.htm ECMAScript for XML 
* (E4X) specification (ECMA-357 edition 2)
*
* @playerversion Flash 9
* @langversion 3.0
* @helpid
* @refpath 
* @keyword Namespace
*/
public final class Namespace
{
	
	/** 
	* Creates a Namespace object given the <code>uriValue</code> parameter.
	* The values assigned to the <code>uri</code> and <code>prefix</code> properties 
	* of the new Namespace object depend on the type of value passed for the <code>uriValue</code> parameter:
	* <ul>
	*   <li>If no argument is passed, the <code>prefix</code> and <code>uri</code> properties are set to the empty string.</li>
	*   <li>If the argument is a Namespace object, a copy of the object is created.</li>
	*   <li>If the argument is a QName object, the <code>uri</code> property is set to the <code>uri</code> property of the QName object.</li>
	*   <li>Otherwise, the argument is converted into a string and assigned to the <code>uri</code> property.</li>
	* </ul>
    * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
    * variable types of arguments. The constructor behaves differently depending on the type and number of 
    * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
    * 
	* @tiptext Creates a Namespace object, given the uriValue.
	*
	* @param uriValue The Uniform Resource Identifier (URI) of the namespace.
	* 
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	**/
	public native function Namespace(uriValue:*);

    /**
     * The default number of arguments for the constructor. You can specify <code>prefix</code> or <code>uri</code> or both arguments. For details, see the <code>Namespace()</code> constructor function.
     * @playerversion Flash 9
     * @langversion 3.0 
     * @see #Namespace()
     */
    public static const length:int = 2; 
    
	/** 
	* Creates a Namespace object, given the <code>prefixValue</code> and <code>uriValue</code> parameters.
	* This constructor requires both parameters.
	* <p>The value of the <code>prefixValue</code> parameter is assigned to the <code>prefix</code>
	* property in the following manner:</p>
	* <ul>
	*   <li>If <code>undefined</code> is passed, <code>prefix</code> is set to <code>undefined</code>.</li>
	*   <li>If the argument is a valid XML name, as determined by the <code>isXMLName()</code> function, it is converted to a string and assigned to the <code>prefix</code> property.</li>
	*   <li>If the argument is not a valid XML name, the <code>prefix</code> property is set to <code>undefined</code>.</li>
	* </ul>
	*
	* <p>The value of the <code>uriValue</code> parameter is assigned to the <code>uri</code>
	* property in the following manner:</p>
	* <ul>
	*   <li>If a QName object is passed for the <code>uriValue</code> parameter, the <code>uri</code> property is set to the value of the <code>uri</code> property of the QName object.</li>
	*   <li> Otherwise, the <code>uriValue</code> parameter is converted to a string and assigned to the <code>uri</code> property.</li>
	* </ul>
    * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
    * variable types of arguments. The constructor behaves differently depending on the type and number of 
    * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
    * 
	* @tiptext Creates a Namespace object, given the prefixValue and uriValue.
	*
	* @param prefixValue The prefix to use for the namespace.   
	*
	* @param uriValue The Uniform Resource Identifier (URI) of the namespace.
	* 
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	**/
	public native function Namespace(prefixValue:*, uriValue:*);

	
	/**
	* Equivalent to the <code>Namespace.uri</code> property.
	* 
	* @tiptext Equivalent to the Namespace.uri property. 
	*
	* @return The Uniform Resource Identifier (URI) of the namespace, as a string.
	* 
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Namespace, Namespace.toString, toString
	**/
	public native function toString():String;
	
	/**
	* The prefix of the namespace.
	* 
	* @tiptext The prefix of the namespace.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Namespace, Namespace.prefix, prefix
	**/
	public native function get prefix():String;
	public native function set prefix(value:String):void;

	/**
	* The Uniform Resource Identifier (URI) of the namespace.
	* 
	* @tiptext The Uniform Resource Identifier (URI) of the namespace.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Namespace, Namespace.uri, uri
	**/
	public native function get uri():String;
	public native function set uri(value:String):void;
	
}

}
package {
	
//****************************************************************************
// ActionScript Standard Library
// Number object
//****************************************************************************


/**
 * A data type representing an IEEE-754 double-precision floating-point number. You can manipulate primitive numeric 
 * values by using the methods and properties associated with the Number class. This class is identical to the 
 * JavaScript Number class.
 * <p>The properties of the Number class are static, which means you do not need an object to use them, so you 
 * do not need to use the constructor.</p>
 * <p>The Number data type adheres to the double-precision IEEE-754 standard. </p>
 * <p>The Number data type is useful when you need to use floating-point values.
 * Flash Player handles int and uint more efficiently than Number, but Number is 
 * useful in situations where the range of values required exceeds the valid range 
 * of the int and uint data types. The Number class can be used to
 * represent integer values well beyond the valid range of the int and uint data types.
 * The Number data type can use up to 53 bits to represent integer values, compared to
 * the 32 bits available to int and uint. The default value of a variable typed as Number is <code>NaN</code> (Not a Number).</p>
 * 
 * @includeExample examples\NumberExample.as -noswf
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @tiptext The Number class is a simple wrapper object for the <code>Number</code> 
 * data type.
 *
 * @see int.html int
 * @see uint.html uint 
 * @helpid
 * @refpath 
 * @keyword number object, number, built-in class
 */
public final class Number
{
     /**
      * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>Number()</code> constructor function.
      * @playerversion Flash 9
      * @langversion 3.0 
      * @see #Number()
      */
    public static const length:int = 1; 
    
 /**
  * The largest representable number (double-precision IEEE-754). This number is 
  * approximately 1.79e+308.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext The largest representable number (double-precision IEEE-754).
  *
  * @oldexample The following ActionScript <span class="flashonly">displays</span><span class="flexonly">writes</span> the largest and smallest representable numbers <span class="flashonly">to the Output panel</span><span class="flexonly">to the log file</span>.
  * <pre>
  * trace("Number.MIN_VALUE = "+Number.MIN_VALUE);
  * trace("Number.MAX_VALUE = "+Number.MAX_VALUE);
  * </pre>
  * <p>This code <span class="flexonly">logs</span><span class="flashonly">displays</span> the following values:</p>
  * <pre>
  * Number.MIN_VALUE = 4.94065645841247e-324
  * Number.MAX_VALUE = 1.79769313486232e+308
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword number, number.max_value, max_value, max value
  */
	public static const MAX_VALUE:Number;
 
 /**
  * The smallest representable non-negative, non-zero, number (double-precision IEEE-754). This number is 
  * approximately 5e-324. The smallest representable number overall is actually <code>-Number.MAX_VALUE</code>.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext The smallest representable number (double-precision IEEE-754).
  *
  * @oldexample The following ActionScript <span class="flashonly">displays</span><span class="flexonly">writes</span> the largest and smallest representable numbers to the Output panel to the log file.
  * <pre>
  * trace("Number.MIN_VALUE = "+Number.MIN_VALUE);
  * trace("Number.MAX_VALUE = "+Number.MAX_VALUE);
  * </pre>
  * <p>This code <span class="flexonly">logs</span><span class="flashonly">displays</span> the following values:</p>
  * <pre>
  * Number.MIN_VALUE = 4.94065645841247e-324
  * Number.MAX_VALUE = 1.79769313486232e+308
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword number, number.min_value, min_value, min value
  */
	public static const MIN_VALUE:Number;
 
 /**
  * The IEEE-754 value representing Not a Number (<code>NaN</code>).
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext The IEEE-754 value representing Not a Number (NaN).
  *
  * @see package.html#isNaN() isNaN() 
  * @helpid 
  * @refpath 
  * @keyword number, number.nan, nan, not a number
  */
	public static const NaN:Number;
 
 /**
  * Specifies the IEEE-754 value representing negative infinity. The value of this property 
  * is the same as that of the constant <code>-Infinity</code>.
  * <p>
  * Negative infinity is a special numeric value that is returned when a mathematical 
  * operation or function returns a negative value larger than can be 
  * represented.
  * </p>
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Specifies the IEEE-754 value representing negative infinity.
  *
  * @oldexample This example compares the result of dividing the following values.
  * <pre>
  * var posResult:Number = 1/0;
  * if (posResult == Number.POSITIVE_INFINITY) {
  *   trace("posResult = "+posResult); // output: posResult = Infinity
  * }
  * var negResult:Number = -1/0;
  * if (negResult == Number.NEGATIVE_INFINITY) {
  *   trace("negResult = "+negResult); // output: negResult = -Infinity
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword number, number.negative_infinity, negative_infinity, negative infinity, infinity
  */
	public static const NEGATIVE_INFINITY:Number;
 
 /**
  * Specifies the IEEE-754 value representing positive infinity. The value of this property 
  * is the same as that of the constant <code>Infinity</code>.
  * <p>
  * Positive infinity is a special numeric value that is returned when a mathematical 
  * operation or function returns a value larger than can be represented.
  * </p>
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Specifies the IEEE-754 value representing positive infinity.
  *
  * @oldexample This example compares the result of dividing the following values.
  * <pre>
  * var posResult:Number = 1/0;
  * if (posResult == Number.POSITIVE_INFINITY) {
  *   trace("posResult = "+posResult); // output: posResult = Infinity
  * }
  * var negResult:Number = -1/0;
  * if (negResult == Number.NEGATIVE_INFINITY) {
  *   trace("negResult = "+negResult); // output: negResult = -Infinity
  * </pre>
  *
  *
  * @helpid 
  * @refpath 
  * @keyword number, number.positive_infinity, positive_infinity, positive infinity, infinity
  */
	public static const POSITIVE_INFINITY:Number;

 /**
  * Creates a <code>Number</code> with the specified value. This constructor has the same effect
  * as the <code>Number()</code> public native function that converts an object of a different type
  * to a primitive numeric value.
  *
  * @playerversion Flash 9
  * @langversion 3.0 
  * 
  * @tiptext Creates a Number with the specified value.
  * 
  * @param num The numeric value of the <code>Number</code> instance being created or a value 
  * to be converted to a <code>Number</code>. The default value is 0 if <code>num</code> is 
  * not specified. Using the constructor without specifying a <code>num</code> parameter is not
  * the same as declaring a variable of type Number with no value assigned (such as <code>var myNumber:Number</code>), which 
  * defaults to NaN. A number with no value assigned is undefined and the equivalent of <code>new Number(undefined)</code>.
  *
  * @oldexample The following code constructs new Number objects:
  * <pre>
  * <code>var n1:Number = new Number(3.4);</code>
  * <code>var n2:Number = new Number(-10);</code>
  * </pre>
  *
  *
  * @see #toString() Number.toString()
  * @see #valueOf() Number.valueOf()
  * @helpid 
  * @refpath 
  * @keyword new number, constructor
  */	
	public native function Number(num:Object);
    
    
/**  
  */ 
private static native function _convert(n:Number, precision:int, mode:int):String
   
	
/**
 * Returns the string representation of the specified Number object (<code><em>myNumber</em></code>).
 * If the value of the Number object is a decimal number without a leading zero (such as <code>.4</code>),
 * <code>Number.toString()</code> adds a leading zero (<code>0.4</code>).
 *
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @tiptext Returns the string representation of this Number using the specified 
 * radix parameter as the numeric base.
 *
 * @param radix Specifies the numeric base (from 2 to 36) to use for the number-to-string 
 * conversion. If you do not specify the <code>radix</code> parameter, the default value 
 * is 10.
 *
 * @return The numeric representation of this <code>Number</code> as a string.
 *
 * @oldexample The following example uses 2 and 8 for the <code><em>radix</em></code> parameter and returns a string that contains the corresponding representation of the number 9:
 * <pre>
 * var myNumber:Number = new Number(9);
 * trace(myNumber.toString(2)); // output: 1001
 * trace(myNumber.toString(8)); // output: 11
 * </pre>
 * The following example results in a hexadecimal value.
 * <pre>
 * var r:Number = new Number(250);
 * var g:Number = new Number(128);
 * var b:Number = new Number(114);
 * var rgb:String = "0x"+ r.toString(16)+g.toString(16)+b.toString(16);
 * trace(rgb); 
 * // output: rgb:0xFA8072 (Hexadecimal equivalent of the color 'salmon')
 * </pre>
 *
 * @helpid 
 * @refpath 
 * @keyword number, number.tostring, tostring
 */	
	public native function toString(radix:Number = 10):String;	
	
/**
 * Returns the primitive value type of the specified Number object.
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * 
 * @tiptext Returns the primitive value type of the specified Number object.
 *
 * @return The primitive type value of this <code>Number</code>.
 *
 * @oldexample The following example results in the primative value of the <code>numSocks</code> object.
 * <pre>
 * var numSocks = new Number(2);
 * trace(numSocks.valueOf()); // output: 2
 * </pre>
 *
 * @helpid 
 * @refpath 
 * @keyword number, number.valueof, valueof, value of
 */	
	public native function valueOf():Number;
	
	/**
	 * Returns a string representation of the number in fixed-point notation. 
	 * Fixed-point notation means that the string will contain a specific number of digits 
	 * after the decimal point, as specified in the <code>fractionDigits</code> parameter.
	 * The valid range for the <code>fractionDigits</code> parameter is from 0 to 20. 
	 * Specifying a value outside this range throws an exception.
	 *
	 * @param fractionDigits An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
     * @throws RangeError Throws an exception if the <code>fractionDigits</code> argument is outside the range 0 to 20.
	 * @includeExample examples\Number.toFixed.1.as -noswf
	 * @includeExample examples\Number.toFixed.2.as -noswf
	 */
	 public native function toFixed(fractionDigits:uint):String;
	 
	 /**
	  * Returns a string representation of the number in exponential notation. The string contains
	  * one digit before the decimal point and up to 20 digits after the decimal point, as
	  * specified by the <code>fractionDigits</code> parameter.
	  * @param fractionDigits An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
      * @throws RangeError Throws an exception if the <code>fractionDigits</code> argument is outside the range 0 to 20.
      * @includeExample examples\Number.toExponential.1.as -noswf
	  */
	 public native function toExponential(fractionDigits:uint):String;
	 
	 /**
	  * Returns a string representation of the number either in exponential notation or in
	  * fixed-point notation. The string will contain the number of digits specified in the
	  * <code>precision</code> parameter.
	  * @param precision An integer between 1 and 21, inclusive, that represents the desired number of digits to represent in the resulting string.
      * @throws RangeError Throws an exception if the <code>precision</code> argument is outside the range 1 to 21.
      * @includeExample examples\Number.toPrecision.1.as -noswf
	  * @includeExample examples\Number.toPrecision.2.as -noswf
	  */
	 public native function toPrecision(precision:uint):String;
}

}
package {
//****************************************************************************
// ActionScript Standard Library
// Object object
//****************************************************************************


/**
 * The Object class is at the root of the ActionScript class hierarchy. Objects are created by constructors using the
 * <code>new</code> operator syntax, and can have properties assigned to them dynamically. Objects can also be created by 
 * assigning an object literal, as in:
 * <listing>var obj:Object = {a:"foo", b:"bar"}</listing>
 * 
 * <p>All classes that don't declare an explicit base class extend the built-in Object class.</p>
 * <p>You can use the Object class to create <i>associative arrays</i>. At its core, an associative array is an instance of the Object class, and each key-value pair is represented by a property and its value. Another reason to declare an associative array using the Object data type is that you can then use an object literal to populate your associative array (but only at the time you declare it). The following example creates an associative array using an object literal, accesses items using both the dot operator and the array access operator, and then adds a new key-value pair by creating a new property:</p>
 * <listing>
 * var myAssocArray:Object = {fname:"John", lname:"Public"};
 * trace(myAssocArray.fname);     // Output: John
 * trace(myAssocArray["lname"]);  // Output: Public
 * myAssocArray.initial = "Q";
 * trace(myAssocArray.initial);   // Output: Q</listing> 
 * 
 * <p>ActionScript 3.0 has two types of inheritance: "class inheritance" and "prototype inheritance":</p>
 * <ul><li>Class inheritance - the primary inheritance mechanism, supports inheritance of fixed properties. A fixed property is a variable, constant or method declared as part of a class definition. Every class definition is now represented by a special class object that stores information about the class. </li>
 * <li>Prototype inheritance - the only inheritance mechanism in previous versions of ActionScript, serves as an alternate form of inheritance in ActionScript 3.0. Each class has an associated prototype object, and the properties of the prototype object are shared by all instances of the class. When a class instance is created, the new instance has a reference to its class's prototype object that serves as a link between an instance and its class's prototype object. At runtime, when a property is not found on a class instance, the delegate, which is the class prototype object, is checked for that property. If the prototype object does not contain the property, the process continues with the prototype object's delegate on up the hierarchy until Flash Player finds the property. </li></ul>
 * <p>Both class inheritance and prototype inheritance can exist simultaneously, such as:</p>
 * <listing>
 * class A {
 *     var x = 1
 *     prototype.px = 2
 * }
 * dynamic class B extends A {
 *     var y = 3
 *     prototype.py = 4
 * }
 *  
 * var b = new B()
 * b.x // 1 via class inheritance
 * b.px // 2 via prototype inheritance from A.prototype
 * b.y // 3
 * b.py // 4 via prototype inheritance from B.prototype
 *  
 * B.prototype.px = 5
 * b.px // now 5 because B.prototype hides A.prototype
 *  
 * b.px = 6
 * b.px // now 6 because b hides B.prototype</listing>
 * 
 * <p>Using functions instead of classes, you can construct custom prototype inheritance trees. With classes, the prototype inheritance tree mirrors the class inheritance tree. However, since the prototype objects are dynamic, you can add and delete prototype-based properties at runtime.</p>
 *
 * @playerversion Flash 9
 * 
 * @includeExample examples\ObjectExample.as -noswf
 *
 * @helpid x20982
 * @refpath Objects/Core/Object
 * @keyword object, object object, built-in class
 * 
 * @see #prototype
 */
public dynamic class Object
{
	/**
	 * A reference to the prototype object of a class or function object. The <code>prototype</code> property 
	 * is automatically created and attached to any class or function object that you create. This property is 
	 * static in that it is specific to the class or function that you create. For example, if you create a  
	 * class, the value of the <code>prototype</code> property is shared by all instances of the class and is
	 * accessible only as a class property. Instances of your class cannot directly access 
	 * the <code>prototype</code> property. 
     * <p>A class's prototype object is a special instance of that class that provides a mechanism for sharing state across all instances of a class. At runtime, when a property is not found on a class instance, the delegate, which is the class prototype object, is checked for that property. If the prototype object does not contain the property, the process continues with the prototype object's delegate on up the hierarchy until Flash Player finds the property. </p>
     * <p><b>Note:</b> In ActionScript 3.0, prototype inheritance is not the primary mechanism for inheritance. Class inheritance, which drives the inheritance of fixed properties in class definitions, is the primary inheritance mechanism. <span class = "hide">For more information on class inheritance. Need XREF to Prog AS3</span></p>
	 * 
	 * @maelexample The following example creates a class named Shape and a subclass of Shape named Circle.
	 * <listing version="2.0">
	 * // Shape class defined in external file named Shape.as
	 * class Shape {
	 * 	function Shape() {}
	 * }
	 *
	 * // Circle class defined in external file named Circle.as
	 * class Circle extends Shape{
	 * 	function Circle() {}
	 * }
	 * </listing>
	 * The Circle class can be used to create two instances of Circle:
	 * <listing version="2.0">
	 * var oneCircle:Circle = new Circle();
	 * var twoCircle:Circle = new Circle();
	 * </listing>
	 * The following trace statement shows that the <code>prototype</code> property of the Circle class points to its superclass Shape. The identifier <code>Shape</code> refers to the constructor function of the Shape class.
	 * <listing version="2.0">
	 * trace(Circle.prototype.constructor == Shape); // Output: true
	 * </listing>
	 * The following trace statement shows how you can use the <code>prototype</code> property and the <code>__proto__</code> property together to move two levels up the inheritance hierarchy (or prototype chain). The <code>Circle.prototype.__proto__</code> property contains a reference to the superclass of the Shape class.
	 * <listing version="2.0">
	 * trace(Circle.prototype.__proto__ == Shape.prototype); // Output: true
	 * </listing>
	 * 
	 * 
	 * @playerversion Flash 9
	 * @langversion 3.0
	 */
	public static var prototype:Object;
	
     /**
      * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>Object()</code> constructor function.
      * @playerversion Flash 9
      * @langversion 3.0 
      * @see #Object()
      */
    public static const length:int = 1; 
    
	/**
	 * A reference to the class object or constructor function for a given object instance. 
	 * If an object is an instance of a class, the <code>constructor</code> 
	 * property holds a reference to the class object. 
	 * If an object is created with a constructor function, the <code>constructor</code>   
	 * property holds a reference to the constructor function.
	 * Do not confuse a constructor function with a constructor method of a class.
	 * A constructor function is a Function object used to create objects, and is an
	 * alternative to using the <code>class</code> keyword for defining classes.
	 *
	 * <p>If you use the <code>class</code> keyword to define a class, the class's prototype object
	 * is assigned a property named <code>constructor</code> that holds a reference to the class object.
	 * An instance of the class inherits this property from the prototype object. For example,
	 * the following code creates a new class, <code>A</code>, and a class instance named <code>myA</code>:</p>
	 * <listing version="3.0">
	 * dynamic class A {}
	 * trace(A.prototype.constructor);      // [class A]
	 * trace(A.prototype.constructor == A); // true
	 * var myA:A = new A();
	 * trace(myA.constructor == A);         // true</listing>
	 * 
	 * <p>Advanced users may choose to use the <code>function</code> keyword instead of the <code>class</code>
	 * keyword to define a Function object that can be used as a template for the creation of objects. Such a
	 * function is called a constructor function because you can use it in conjunction with the <code>new</code>
	 * operator to create new objects. 
	 * If you use the <code>function</code> keyword to create a constructor function, its prototype object is assigned
	 * a property named <code>constructor</code> that holds a reference to the constructor function. 
	 * If you then use the constructor function to create an new object, the object inherits the  
	 * <code>constructor</code> property from the constructor function's prototype object. For example,
	 * the following code creates a new constructor function, <code>f</code>, and an object named <code>myF</code>:</p>
	 * <listing version="3.0">
	 * function f() {}
	 * trace(f.prototype.constructor);      // function Function() {}
	 * trace(f.prototype.constructor == f); // true
	 * var myF = new f();
	 * trace(myF.constructor == f);         // true</listing>
	 *
	 * <p><strong>Note</strong>: The <code>constructor</code> property is writable, which means that user code can change
	 * its value with an assignment statement. Changing the value of the <code>constructor</code> property is not 
	 * recommended, but if you write code that depends on the value of the <code>constructor</code> property, you should
	 * ensure that the value is not reset. The value can be changed only when the property is accessed through the prototype
	 * object (for example, <code>className.prototype.constructor</code>).</p>
	 * @playerversion Flash 9
	 *
	 * @see Class
	 * @see Function
	 * @see #prototype
	 * @helpid 
	 * @refpath 
	 * @keyword Object, Object.constructor, constructor
	 */
	var constructor:Object;
	

	/**
	 * Creates an Object object and stores a reference to the object's constructor method in the object's <code>constructor</code> property.
	 *
	 * @version Flash Player 8.0
	 *
	 */	
	public native function Object();

	
	/**
	 * Indicates whether an object has a specified property defined. This method returns <code>true</code> if the target object has
	 * a property that matches the string specified by the <code>name</code> parameter, and <code>false</code> otherwise. 
	 * The following types of properties cause this method to return <code>true</code> for objects that are instances of a class (as opposed to class objects):
	 * <ul>
	 *   <li>fixed instance properties&#x2014;variables, constants, or methods defined by the object's class that are not static;</li>
	 *   <li>inherited fixed instance properties&#x2014;variables, constants, or methods inherited by the object's class;</li>
	 *   <li>dynamic properties&#x2014;properties added to an object after it is instantiated (outside of its class definition). To add dynamic properties, the object's defining class must be declared with the <code>dynamic</code> keyword.</li>
	 * </ul>
	 * <p>The following types of properties cause this method to return <code>false</code> for objects that are instances of a class:</p>
	 * <ul>
	 *   <li>static properties&#x2014;variables, constants, or methods defined with the static keyword in an object's defining class or any of its superclasses;</li>
	 *   <li>prototype properties&#x2014;properties defined on a prototype object that is part of the object's prototype chain. In ActionScript 3.0, the prototype chain is not used for class inheritance, but still exists as an alternative form of inheritance. For example, an instance of the Array class can access the <code>valueOf()</code> method because it exists on <code>Object.prototype</code>, which is part of the prototype chain for the Array class. Although you can use <code>valueOf()</code> on an instance of Array, the return value of <code>hasOwnProperty("valueOf")</code> for that instance is <code>false</code>.</li>
	 * </ul>
	 * 
	 * <p>ActionScript 3.0 also has class objects, which are concrete representations of class definitions. 
	 * When called on class objects, <code>hasOwnProperty()</code> returns <code>true</code> only if a property 
	 * is a static property defined on that class object. For example, if you create a subclass of Array named 
	 * CustomArray, and define a static property in CustomArray named <code>foo</code>, a call to 
	 * <code>CustomArray.hasOwnProperty("foo")</code> returns <code>true</code>.
	 * For the static property <code>DESCENDING</code> defined in the Array class, however, a call to 
	 * <code>CustomArray.hasOwnProperty("DESCENDING")</code> returns <code>false</code>.</p>
	 * 
     * <p><b>Note:</b> Methods of the Object class are dynamically created on Object's prototype. To redefine this method in a subclass of Object, do not use the <code>override</code> keyword. For example, A subclass of Object implements <code>function hasOwnProperty():Boolean</code> instead of using an override of the base class.</p>
     *
	 * @param name The property of the object.	 
	 * @return If the target object has the property specified by the <code>name</code> 
	 * parameter this value is <code>true</code>, otherwise <code>false</code>.
	 * 
	 * @category Method
	 * @playerversion Flash 9
	 * @langversion 3.0
	 */
	public native function hasOwnProperty(name:String):Boolean;
	
	/**
	 * Indicates whether the specified property exists and is enumerable. If <code>true</code>, then the property exists and 
	 * can be enumerated in a <code>for..in</code> loop. The property must exist on the target object because this method does not 
	 * check the target object's prototype chain.
	 * 
	 * <p>Properties that you create are enumerable, but built-in properties are generally not enumerable.</p>
	 * 
     * <p><b>Note:</b> Methods of the Object class are dynamically created on Object's prototype. To redefine this method in a subclass of Object, do not use the <code>override</code> keyword. For example, A subclass of Object implements <code>function propertyIsEnumerable():Boolean</code> instead of using an override of the base class.</p>
     *
	 * @param name The property of the object.
	 * @return If the property specified by the <code>name</code> parameter is enumerable this value is <code>true</code>, otherwise <code>false</code>.
	 * 
	 * @maelexample The following example creates a generic object, adds a property to the object, then checks whether the object is enumerable. By way of contrast, the example also shows that a built-in property, the <code>Array.length</code> property, is not enumerable.
	 * <listing>
	 * var myObj:Object = new Object();
	 * myObj.prop1 = "hello";
	 * trace(myObj.propertyIsEnumerable("prop1")); // Output: true
	 * 
	 * var myArray = new Array();
	 * trace(myArray.propertyIsEnumerable("length")); // Output: false
	 * </listing> 
	 * 
	 * @playerversion Flash 9
	 * @langversion 3.0
	 */
	public native function propertyIsEnumerable(name:String):Boolean;
	
	/**
	 * Indicates whether an instance of the Object class is in the prototype chain of the object specified 
	 * as the parameter. This method returns <code>true</code> if the object is in the prototype chain of the 
	 * object specified by the <code>theClass</code> parameter. The method returns <code>false</code> 
	 * if the target object is absent from the prototype chain of the <code>theClass</code> object, 
	 * and also if the <code>theClass</code> parameter is not an object.
	 *
     * <p><b>Note:</b> Methods of the Object class are dynamically created on Object's prototype. To redefine this method in a subclass of Object, do not use the <code>override</code> keyword. For example, A subclass of Object implements <code>function isPrototypeOf():Boolean</code> instead of using an override of the base class.</p>
     *
	 * @param theClass The class to which the specified object may refer.  
	 * 
	 * @return If the object is in the prototype chain of the object 
	 * specified by the <code>theClass</code> parameter this value is <code>true</code>, otherwise <code>false</code>.
	 * 
	 * @playerversion Flash 9
	 * @langversion 3.0
	 */
	public native function isPrototypeOf(theClass:Object):Boolean;
	
    /**
     * Sets the availability of a dynamic property for loop operations. The property must exist on the target object because this method does not check the target object's prototype chain.
     * @param name The property of the object.
     * @param isEnum  If set to <code>false</code>, the dynamic property will not show up in <code>for..in</code> loops, and the method <code>propertyIsEnumerable()</code> will return <code>false</code>. 
     * @playerversion Flash 9
     * @langversion 3.0
     * @see #propertyIsEnumerable()
     */
    public native function setPropertyIsEnumerable(name:String, isEnum:Boolean=true):void;
    
    /**
	 * @playerversion Flash 9
	 * @langversion 3.0
	 * 
	 */
	public native function toLocaleString():String;
	
	/**
	 * Returns the string representation of the specified object.
	 *
     * <p><b>Note:</b> Methods of the Object class are dynamically created on Object's prototype. To redefine this method in a subclass of Object, do not use the <code>override</code> keyword. For example, A subclass of Object implements <code>function toString():String</code> instead of using an override of the base class.</p>
     *
     * @playerversion Flash 9
	 *
	 * @return A string representation of the object.
	 *
	 * @oldexample This example shows the return value for toString() on a generic object:
	 * <pre>
	 * var myObject:Object = new Object();<br/>
	 * trace(myObject.toString()); // output: [object Object]<br/>
	 * </pre>
	 * <p>This method can be overridden to return a more meaningful value. The following examples show that this method has been overridden for the built-in classes Date, Array, and Number:</p>
	 * <pre>
	 * // Date.toString() returns the current date and time<br/>
	 * var myDate:Date = new Date();<br/>
	 * trace(myDate.toString()); // output: [current date and time]<br/>
	 * <br/>
	 * // Array.toString() returns the array contents as a comma-delimited string<br/>
	 * var myArray:Array = new Array("one", "two");<br/>
	 * trace(myArray.toString()); // output: one,two<br/>
	 * <br/>
	 * // Number.toString() returns the number value as a string<br/>
	 * // Because trace() won't tell us whether the value is a string or number<br/>
	 * // we will also use typeof() to test whether toString() works.<br/>
	 * var myNumber:Number = 5;<br/>
	 * trace(typeof (myNumber));  // output: number<br/>
	 * trace(myNumber.toString()); // output: 5<br/>
	 * trace(typeof (myNumber.toString())); // output: string<br/>
	 * </pre>
	 * <p>The following example shows how to override <code>toString()</code> in a class. First create a text file named <em>Vehicle.as</em> that contains only the Vehicle class definition and place it into your Classes folder inside your Configuration folder.</p>
	 * <pre>
	 * // contents of Vehicle.as<br/>
	 * class Vehicle {<br/>
	 *   var numDoors:Number;<br/>
	 *   var color:String;<br/>
	 *   function Vehicle(param_numDoors:Number, param_color:String) {<br/>
	 *     this.numDoors = param_numDoors;<br/>
	 *     this.color = param_color;<br/>
	 *   }<br/>
	 *   function toString():String {<br/>
	 *     var doors:String = "door";<br/>
	 *     if (this.numDoors &gt; 1) {<br/>
	 *       doors += "s";<br/>
	 *     }<br/>
	 *     return ("A vehicle that is " + this.color + " and has " + this.numDoors + " " + doors);<br/>
	 *   }<br/>
	 * }<br/>
	 * <br/>
	 * // code to place into a FLA file<br/>
	 * var myVehicle:Vehicle = new Vehicle(2, "red");<br/>
	 * trace(myVehicle.toString());<br/>
	 * // output: A vehicle that is red and has 2 doors<br/>
	 * <br/>
	 * // for comparison purposes, this is a call to valueOf()<br/>
	 * // there is no primitive value of myVehicle, so the object is returned<br/>
	 * // giving the same output as toString().<br/>
	 * trace(myVehicle.valueOf());<br/>
	 * // output: A vehicle that is red and has 2 doors<br/>
	 * <br/>
	 * </pre>
	 *
	 * @helpid x20983
	 * @refpath Objects/Core/Object/Methods/toString
	 * @keyword object, object.tostring, tostring
	 */
	public native function toString():String;
		
	/**
	 * Returns the primitive value of the specified object. If this object
	 * does not have a primitive value, the object itself is returned.
     * <p><b>Note:</b> Methods of the Object class are dynamically created on Object's prototype. To redefine this method in a subclass of Object, do not use the <code>override</code> keyword. For example, A subclass of Object implements <code>function valueOf():Object</code> instead of using an override of the base class.</p>
     *
	 * @playerversion Flash 9
	 *
	 * @return The primitive value of this object or the object itself.
	 *
	 * @oldexample The following example shows the return value of valueOf() for a generic object (which does not have a primitive value) and compares it to the return value of toString():
	 * <pre>
	 * // Create a generic object<br/>
	 * var myObject:Object = new Object();<br/>
	 * trace(myObject.valueOf()); // output: [object Object]<br/>
	 * trace(myObject.toString()); // output: [object Object]<br/>
	 * </pre>
	 * <p>The following examples show the return values for the built-in classes Date and Array, and compares them to the return values of <code>Object.toString()</code>:</p>
	 * <pre>
	 * // Create a new Date object set to February 1, 2004, 8:15 AM<br/>
	 * // The toString() method returns the current time in human-readable form<br/>
	 * // The valueOf() method returns the primitive value in milliseconds<br/>
	 * var myDate:Date = new Date(2004,01,01,8,15);<br/>
	 * trace(myDate.toString()); // output: Sun Feb 1 08:15:00 GMT-0800 2004<br/>
	 * trace(myDate.valueOf()); // output: 1075652100000<br/>
	 * <br/>
	 * // Create a new Array object containing two simple elements<br/>
	 * // In this case both toString() and valueOf() return the same value: one,two<br/>
	 * var myArray:Array = new Array("one", "two");<br/>
	 * trace(myArray.toString()); // output: one,two<br/>
	 * trace(myArray.valueOf()); // output: one,two<br/>
	 * </pre>
	 * 
	 * <p>See the example for <code>Object.toString()</code> for an example of the return value
	 * of <code>Object.valueOf()</code> for a  class that overrides <code>toString()</code>.</p>
	 *
	 * @see Object#toString()
	 * 
	 * @helpid x20984
	 * @refpath Objects/Core/Object/Methods/valueOf
	 * @keyword object, object.valueof, valueof
	 */
	public native function valueOf():Object;
}

}
package {
//
// QName
//

// Based on the ECMA E4X spec, 1st Edition

/**
*
* QName objects represent qualified names of XML elements and attributes. Each
* QName object has a local name and a namespace Uniform Resource Identifier (URI). 
* When the value of the namespace URI is <code>null</code>, the QName object matches any namespace.
* Use the QName constructor to create a new QName object that is either a copy of another QName 
* object or a new QName object with a <code>uri</code> from a Namespace object and a 
* <code>localName</code> from a QName object. 
*  
*
* <p>Methods specific to E4X can use QName objects interchangeably with strings. 
* E4X methods are in the QName, Namespace, XML, and XMLList classes.
* These E4X methods, which take a string, can also take a QName object. 
* This interchangeability is how namespace support works with, for example, 
* the <code>XML.child()</code> method. </p>
* 
* <p>The QName class (along with the XML, XMLList, and Namespace classes) implements 
* powerful XML-handling standards defined in ECMAScript for XML 
* (E4X) specification (ECMA-357 edition 2).</p>
* 
* <p>A qualified identifier evaluates to a QName object. If the QName object of an XML element is 
* specified without identifying a namespace, the <code>uri</code> 
* property of the associated QName object is set to the global default namespace. If the QName object of an XML  
* attribute is specified without identifying a namespace, the <code>uri</code> property is set to 
* an empty string.</p>
*
* @includeExample examples\QNameExample.as -noswf
* 
* @see XML
* @see XMLList
* @see Namespace
* @see http://www.ecma-international.org/publications/standards/Ecma-357.htm ECMAScript for XML 
* (E4X) specification (ECMA-357 edition 2)
*
* @playerversion Flash 9
* @langversion 3.0
* @helpid
* @refpath 
* @keyword QName
*/
public final class QName
{
	
	/** 
	* Creates a QName object with a <code>uri</code> from a Namespace object and a <code>localName</code> from a QName object.
	* If either parameter is not the expected data type, the parameter is converted to a string and 
	* assigned to the corresponding property of the new QName object.
	* For example, if both parameters are strings, a new QName object is returned with a <code>uri</code> property set
	* to the first parameter and a <code>localName</code> property set to the second parameter.
	* In other words, the following permutations, along with many others, are valid forms of the constructor:
<pre>
QName (uri:Namespace, localName:String);
QName (uri:String, localName: QName);
QName (uri:String, localName: String);
</pre>
	* <p>If the parameter passed as the <code>uri</code> parameter is the <code>null</code> value,
	* the <code>uri</code> property of the new <code>QName</code> property is set to the <code>null</code> value.
	* </p>
    * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
    * variable types of arguments. The constructor behaves differently depending on the type and number of 
    * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
    *
	* @param uri A Namespace object from which to copy the <code>uri</code> value. A parameter of any other type is converted to a string.
	* @param localName A QName object from which to copy the <code>localName</code> value. A parameter of any other type is converted to a string.
 	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword QName
	**/
	public native function QName(uri:Namespace, localName:String);
	
	// Note [M.Shepherd 10/30/06] - this file "global.as" is created by a perl script that runs on the original files 
	// found in flashfarm perforce at //depot/main/player/FlashPlayer/avmglue/ASDocs/AS3/system_classes/*
	// According to Dave Jacowitz
	//		"The 'system_classes' are duplicate ASDoc-only files that are not actually used
	// 		in the Flash Player builds. They are for doc purposes only. The real Flash Player equivalents are in 
	// 		//depot/main/player/FlashPlayer/avmplus/core. The system_classes files are owned by the doc team, 
	// 		and we make an effort to keep them in relative sync with the real 'core' files.
	// So I guess that from time to time, the FlexBuilder team needs to run the perl script, (which can be
	// found somewhere in zorn.codemodel) and check in a new copy of global.as.
	//
	// Anyway, system_classes/QName.as contains several versions of the constructor, because this is
	// what they want for the ASDocs. Flexbuilder, however, only recognizes one constructor, because
	// that is all that is legal in ActionScript 3. So I've edited this file (global.as) to make the 
	// first constructor in this class be the one that we want to code hint.
	//
	// If you ever update global.as with a new version, make sure you preserve this change.

	public native function QName(uri:Namespace, localName:QName);
	
	/** 
	* Creates a QName object that is a copy of another QName object. If the parameter passed 
	* to the constructor is a QName object, a copy of the QName object is created. If the parameter 
	* is not a QName object, the parameter is converted to a string and assigned to the
	* <code>localName</code> property of the new QName instance. 
	* If the parameter is <code>undefined</code> or unspecified, a new QName object
	* is created with the <code>localName</code> property set to the empty string.
    * <p><strong>Note:</strong> This class shows two constructor method entries because the constructor accepts 
    * variable types of arguments. The constructor behaves differently depending on the type and number of 
    * arguments passed, as detailed in each entry. ActionSript 3.0 does not support method or constructor overloading.</p>
	* 
	*
	* @param qname The QName object to be copied. Objects of any other type are 
	* converted to a string that is assigned to the <code>localName</code> property
	* of the new QName object.
 	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	**/
	public native function QName(qname:QName);
	
	
	/**
	* Returns a string composed of the URI, and the local name for the 
	* QName object, separated by "::".
	* 
	* <p>The format depends on the <code>uri</code> property of the QName object:<br />
	* If <code>uri</code> == "" <br />
	* &#160;&#160;<code>toString</code> returns <code>localName</code><br />
	* else if <code>uri</code> == null <br />
	* &#160;&#160;<code>toString</code> returns ~~::<code>localName</code> <br />
	* else
	* &#160;&#160;<code>toString</code> returns <code>uri</code>::<code>localName</code><br />
	* </p>
	*
	* @return The qualified name, as a string.
	*
	* @oldexample
	*
	* <p> Consider the following:</p>
	*
	* <code><pre>
	* var myQN:QName = QName("http://www.exampleNS.com/2005", "xx");
	* trace(myQN.toString())
	* </pre></code>
	*
	* <p>The Output window displays the following: </p>
	*  
	* <code><pre>
	*      http://www.exampleNS.com/2005::xx
	* </pre></code>
	* 
 	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword QName, QName.toString, toString
	**/
	public native function toString():String;
	
	/**
	* The local name of the QName object.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword QName, QName.localName, localName
	**/
	public native function get localName():String;

	/**
	* The Uniform Resource Identifier (URI) of the QName object.
 	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword QName, QName.uri, uri
	**/
	public native function get uri():String;
	
}
}
package {

/**
 * A RangeError exception is thrown when a numeric value is outside the acceptable range. When working with Arrays,
 * referring to an index position of an array item that does not exist will throw a RangeError exception. <code>Number.toExponential()</code>, 
 * <code>Number.toPrecision()</code>, and <code>Number.toFixed()</code> will throw a RangeError exception in cases
 * where the arguments are outside the acceptable range of numbers. You can extend <code>Number.toExponential()</code>,
 * <code>Number.toPrecision()</code>, and <code>Number.toFixed()</code> to avoid throwing a RangeError.
 * <span class="flashonly">In addition, this exception 
 * will be thrown when:
 * <ul>
 *   <li>Any Flash Player API that expects a depth number is invoked with an invalid depth 
 * number.</li>
 *   <li>Any Flash Player API that expects a frame number is invoked with an invalid frame 
 * number.</li>
 *   <li>Any Flash Player API that expects a layer number is invoked with an invalid layer 
 * number.</li>
 *	</ul>
 * </span>
 * @includeExample examples\RangeErrorExample.as -noswf
 * 
 * @see Number#toExponential() 
 * @see Number#toPrecision()
 * @see Number#toFixed()
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, RangeError
 */
public dynamic class RangeError extends Error
{
	/**
	 * Creates a new RangeError object.
	 * @param message Contains the message associated with the RangeError object.
	 */
	public native function RangeError(message:String = "");
}


}
package {

/**
 * A ReferenceError exception is thrown when a reference to an undefined property is 
 * attempted on a sealed (nondynamic) object. References to undefined variables will 
 * result in ReferenceError exceptions to inform you of potential bugs and help you troubleshoot
 * application code.
 * <p>However, you can refer to undefined properties of a dynamic class without having a ReferenceError thrown. For more information, see the <code>dynamic</code> keyword.</p>
 *
 * @includeExample examples\ReferenceErrorExample.as -noswf
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, ReferenceError
 * @see statements.html#dynamic dynamic keyword
 */
public dynamic class ReferenceError extends Error
{
	/**
	 * Creates a new ReferenceError object.
	 * @param message Contains the message associated with the ReferenceError object.
	 */
	public native function ReferenceError(message:String = "");

}


}
package {
// RegExp class

/**
 *
 * The RegExp class lets you work with regular expressions, which are patterns that you can use 
 * to perform searches in strings and to replace text in strings.
 * 
 * <p>You can create a new RegExp object by using the <code>new RegExp()</code> constructor or by
 * assigning a RegExp literal to a variable:</p>
 * 
 * <listing>var pattern1:RegExp = new RegExp("test-\d", "i");
 * var pattern2:RegExp = /test-\d/i;
 * </listing>
 * 
 * <p>For more information, see "Using Regular Expressions" in <i>Programming 
 * ActionScript 3.0</i>.</p>
 * 
 * @includeExample examples\RegExpExample.as -noswf
 * 
 * @see String#match()
 * @see String#replace()
 * @see String#search()
 *
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid
 * @refpath 
 * @keyword RegExp
 **/
public dynamic class RegExp {
	
	/**
	* Lets you construct a regular expression from two strings. One string defines the pattern of the
	* regular expression, and the other defines the flags used in the regular expression. 
	*
	* @param re The pattern of the regular expression (also known as the <i>constructor string</i>). This is the 
	* main part  of the regular expression (the part that goes within the "/" characters). 
	* 
	* <p><b>Note:</b> Do not include the starting and trailing "/" characters; use these only when defining a regular expression
	* literal without using the constructor.</p>
	*
	* @param flags The modifiers of the regular expression. These can include the following:
	*
	* <ul>
	*
	*    <li> <code>g</code> &#151; When using the <code>replace()</code> method of the String class, 
	* 	specify this modifier to replace all matches, rather than only the first one. 
	* 	This modifier corresponds to the <code>global</code> property of the RegExp instance.</li>
	*    <li> <code>i</code> &#151; The regular expression is evaluated <i>without</i> case 
	* 	sensitivity. This modifier corresponds to the <code>ignoreCase</code> property of the RegExp instance.</li>
	*    <li> <code>s</code> &#151; The dot (<code>.</code>) character matches new-line characters. Note 
	*       This modifier corresponds to the <code>dotall</code> property of the RegExp instance.</li>
	*    <li> <code>m</code> &#151; The caret (<code>^</code>) character and dollar sign (<code>$</code>) match 
	*	before <i>and</i> after new-line characters. This modifier corresponds to the 
	* 	<code>multiline</code> property of the RegExp instance.</li>
	*    <li> <code>x</code> &#151; White space characters in the <code>re</code> string are ignored, 
	* 	so that you can write more readable constructors. This modifier corresponds to the
	*       <code>extended</code> property of the RegExp instance.</li>
	*
	* </ul>
	*
	* <p>All other characters in the <code>flags</code> string are ignored. </p>
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp, RegExp.attribute, attribute
	**/
	public native function RegExp (re:String, flags:String);

     /**
      * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>RegExp()</code> constructor function.
      * @playerversion Flash 9
      * @langversion 3.0 
      * @see #RegExp()
      */
    public static const length:int = 1;     

	/**
	 * Performs a search for the regular expression on the given string <code>str</code>. 
	 *
	 * <p>If the <code>g</code> (<code>global</code>) flag is <em>not</em> set for the regular 
	 * expression, then the search starts 
	 * at the beginning of the string (at index position 0); the search ignores
	 * the <code>lastIndex</code> property of the regular expression.</p>
	 *
	 * <p>If the <code>g</code> (<code>global</code>) flag <em>is</em> set for the regular 
	 * expression, then the search starts 
	 * at the index position specified by the <code>lastIndex</code> property of the regular expression. 
	 * If the search matches a substring, the <code>lastIndex</code> property changes to match the position 
	 * of the end of the match. </p>
	 *
	 * @param str The string to search.	 
	 *
	 * @return If there is no match, <code>null</code>; otherwise, an object with the following properties: 
	 * 
	 * <ul>
	 *
	 * 	<li>An array, in which element 0 contains the complete matching substring, and  
	 * other elements of the array (1 through <i>n</i>) contain substrings that match parenthetical groups  
	 * in the regular expression </li>
	 *
	 * 	<li><code>index</code> &#151; The character position of the matched substring within 
	 * 		the string</li>
	 *
	 * 	<li><code>input</code> &#151; The string (<code>str</code>)</li>
	 *
	 * </ul>
	 * 
	 * 
	 * @example When the <code>g</code> (<code>global</code>) flag is <i>not</i> set in the regular expression, then you can 
	 * use <code>exec()</code> to find the first match in the string: 
	 *
	 * <listing>
	 * var myPattern:RegExp = /(\w~~)sh(\w~~)/ig;   
	 * var str:String = "She sells seashells by the seashore";
	 * var result:Object = myPattern.exec(str);
	 * trace(result);
	 * </listing>
	 * 
	 * <p> The <code>result</code> object is set to the following:</p>
	 *
	 * <ul>
	 * 
	 * 	<li> <code>result[0]</code> is set to <code>"She"</code> (the complete
	 * 		match). </li>
	 * 
	 * 	<li> <code>result[1]</code> is set to an empty string (the first matching  
	 * 		parenthetical group). </li>
	 * 
	 * 	<li> <code>result[2]</code> is set to <code>"e"</code> (the second matching  
	 * 		parenthetical group). </li>
	 * 
	 * 	<li> <code>result.index</code> is set to 0.</li>
	 * 
	 * 	<li> <code>result.input</code> is set to the input string: <code>"She sells seashells 
	 *  by the seashore"</code>.</li>
	 *
	 * </ul> 
	 * 
	 * 
	 * 
	 * <p> In the following example, the <code>g</code> (<code>global</code>) flag <i>is</i> set in the regular 
	 * expression, so you can use <code>exec()</code> repeatedly to find multiple matches:</p>
	 *
	 * <listing>
	 * var myPattern:RegExp = /(\w~~)sh(\w~~)/ig;  
	 * var str:String = "She sells seashells by the seashore";
	 * var result:Object = myPattern.exec(str);
	 *
	 * while (result != null) {
	 *     trace ( result.index, "\t", result);
	 *     result = myPattern.exec(str);
	 * }
	 * </listing>
	 * 
	 * <p> This code results in the following output:</p>
	 *
	 * <pre><code>
	 *	  0 	 She,,e
	 *	  10 	 seashells,sea,ells
	 *	  27 	 seashore,sea,ore
	 * </code></pre>
	 * 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp, RegExp.exec, exec
	* @see String#match()
	* @see String#search()
	 */
	public native function exec (str:String):Object;

	/**
	 * Tests for the match of the regular expression in the given string <code>str</code>. 
	 *
	 * <p>If the <code>g</code> (<code>global</code>) flag is <em>not</em> set for the regular expression, 
	 * then the search starts at the beginning of the string (at index position 0); the search ignores
	 * the <code>lastIndex</code> property of the regular expression.</p>
	 *
	 * <p>If the <code>g</code> (<code>global</code>) flag <em>is</em> set for the regular expression, then the search starts 
	 * at the index position specified by the <code>lastIndex</code> property of the regular expression. 
	 * If the search matches a substring, the <code>lastIndex</code> property changes to match the 
	 * position of the end of the match. </p>
	 *
	 * @param str The string to test.
	 * 
	 * @return If there is a match, <code>true</code>; otherwise, <code>false</code>.
	 *
	 * @includeExample examples\RegExp.test.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp, RegExp.test, test
	 */
	public native function test(str:String):Boolean;

	/**
	 * Specifies whether the dot character (.) in a regular expression pattern matches 
	 * new-line characters. Use the <code>s</code> flag when constructing 
	 * a regular expression to set <code>dotall = true</code>.
	 *
	 * @includeExample examples\RegExp.dotall.1.as -noswf
	 * 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp, RegExp.dotall, dotall
	 */
	public native function get dotall():Boolean;
	
	/**
	 * Specifies whether to use extended mode for the regular expression. 
	 * When a RegExp object is in extended mode, white space characters in the constructor  
	 * string are ignored. This is done to allow more readable constructors.
	 *
	 * <p>Use the <code>x</code> flag when constructing a regular expression to set 
	 * <code>extended = true</code>. </p>
	 *
	 * @includeExample examples\RegExp.extended.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.extended, extended
	 */
	public native function get extended():Boolean;
	
	/**
	 * Specifies whether to use global matching for the regular expression. When 
	 * <code>global == true</code>, the <code>lastIndex</code> property is set after a match is 
	 * found. The next time a match is requested, the regular expression engine starts from 
	 * the <code>lastIndex</code> position in the string. Use the <code>g</code> flag when 
	 * constructing a regular expression  to set <code>global</code> to <code>true</code>. 
	 *
	 * @includeExample examples\RegExp.global.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.global, global
	 */
	public native function get global():Boolean;
	
	/**
	 * Specifies whether the regular expression ignores case sensitivity. Use the 
	 * <code>i</code> flag when constructing a regular expression to set 
	 * <code>ignoreCase = true</code>. 
	 *
	 * @includeExample examples\RegExp.ignoreCase.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.ignoreCase, ignoreCase
	**/
	public native function get ignoreCase():Boolean;
	
	/**
	 * Specifies the index position in the string at which to start the next search. This property 
	 * affects the <code>exec()</code> and <code>test()</code> methods of the RegExp class. 
	 * However, the <code>match()</code>, <code>replace()</code>, and <code>search()</code> methods
	 * of the String class ignore the <code>lastIndex</code> property and start all searches from
	 * the beginning of the string.
	 * 
	 * <p>When the <code>exec()</code> or <code>test()</code> method finds a match and the <code>g</code> 
	 * (<code>global</code>) flag is set to <code>true</code> for the regular expression, the method
	 * automatically sets the <code>lastIndex</code> property to the index position of the character 
	 * <i>after</i> the last character in the matching substring of the last match. If the 
	 * <code>g</code> (<code>global</code>) flag is set to <code>false</code>, the method does not 
	 * set the <code>lastIndex</code>property.</p>
	 * 
	 * <p>You can set the <code>lastIndex</code> property to adjust the starting position
	 * in the string for regular expression matching. </p>
	 *
	 * @includeExample examples\RegExp.lastIndex.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.lastIndex, lastIndex
	*/
	public native function get lastIndex():Number;
	public native function set lastIndex(value:Number):void;
	
	/**
	 * Specifies whether the <code>m</code> (<code>multiline</code>) flag is set. If it is set,
	 * the caret (<code>^</code>) and dollar sign (<code>$</code>) in a regular expression 
	 * match before and after new lines. 
	 * Use the <code>m</code> flag when constructing a regular expression to set 
	 * <code>multiline = true</code>.
	 *
	 * @includeExample examples\RegExp.multiline.1.as -noswf
	 *
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.multiline, multiline
	 */
	public native function get multiline():Boolean;
	
	/**
	 * Specifies the pattern portion of the regular expression.
	 * 
	 * @includeExample examples\RegExp.source.1.as -noswf
	 * 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword RegExp
	* @keyword RegExp, RegExp.source, source
	 */
	public native function get source():String;
	
}
}
package flash.errors
{
   /**
	* The ScriptTimeoutError exception is thrown when the script timeout interval is reached. 
	* The script timeout interval is 15 seconds. <span class="flexonly">There are two XML attributes 
	* that you can add to the <code>mx:Application</code> tag: <code>scriptTimeLimit</code> 
	* (the number of seconds until script timeout) and <code>scriptRecursionLimit</code> 
	* (the depth of recursive calls permitted). </span> 
	* 
	* <p>Two ScriptTimeoutError exceptions are thrown. The first exception you can catch and exit
	* cleanly. If there is no exception handler, the uncaught exception terminates execution. The 
	* second exception is thrown but cannot be caught by user code; it goes to the uncaught 
	* exception handler. It is uncatchable to prevent Flash Player from hanging 
	* indefinitely.</p>
	* 
 	* @includeExample examples\ScriptTimeoutErrorExample.as -noswf
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class ScriptTimeoutError extends Error {
		/**
		* Creates a new ScriptTimeoutError object.
		* 
		* @param message A string associated with the error object.
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/
		function ScriptTimeoutError(message:String = "") {
			super(message);
		}	
	}
}
package {

/**
 * The <code>SecurityError</code> exception is thrown when some type of security violation 
 * takes place.
 * <p>
 * Examples of security errors:</p>
 * <ul>
 *   <li>An unauthorized property access or method call is made across a security sandbox 
 * boundary.</li>
 *   <li>An attempt was made to access a URL not permitted by the security sandbox.</li>
 *   <li>A socket connection was attempted to an unauthorized port number, e.g. a port below 
 * 1024 without a policy file present.</li>
 *   <li>An attempt was made to access the user's camera or microphone, and the request to 
 * access the device was denied by the user.</li>
 *	</ul>
 * 
 * @includeExample examples\SecurityErrorExample.as -noswf
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, SecurityError
 *
 */
public dynamic class SecurityError extends Error
{
	/**
	 * Creates a new SecurityError object.
	 */
	public native function SecurityError(message:String = "");
	
}


}
package flash.errors
{
   /**
	* ActionScript throws a StackOverflowError exception when the stack available to the script 
	* is exhausted. ActionScript uses a stack to store information about each method call made in 
	* a script, such as the local variables that the method uses. The amount of stack space 
	* available varies from system to system.
	* 
	* <p>A StackOverflowError exception might indicate that infinite recursion has occurred, in 
	* which case a termination case needs to be added to the function. It also might indicate 
	* that the recursive algorithm has a proper terminating condition but has exhausted the stack 
	* anyway. In this case, try to express the algorithm iteratively instead.</p>
	*
 	* @includeExample examples\StackOverflowErrorExample.as -noswf
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword Error
	*/
	public dynamic class StackOverflowError extends Error {
		/**
		* Creates a new StackOverflowError object.
		* @param message A string associated with the error object.
		*
		* @playerversion Flash 9
		* @langversion 3.0
		* @helpid
		* @refpath 
		* @keyword
		**/		
		function StackOverflowError(message:String = "") {
			super(message);
		}	
	}
}
package {
/**
 * A StackTraceElement provides programmatic access to the elements of the call stack. 
 * A string representation of StackTraceElement objects is returned by the Error.getStackTrace() method.
 *
 * <p>The StackTraceElement class is useful for writing custom exception handlers 
 * that need to display the call stack to the developer.</p>
 * 
 * @includeExample examples\StackTraceElementExample.as -noswf
 *
 * @playerversion Flash 9
 * @langversion 3.0 
 * @see Error#getStackTrace()
 */

public class StackTraceElement
  {
      /**
      * The fully qualified name of the class containing the
      * execution point represented by this stack trace
      * element, or <code>null</code> if the execution point is not
      * within a class.
      * @playerversion Flash 9
      * @langversion 3.0 
	  */
      public var className:String;

      /**
      * The name of method or function containing the execution
      * point represented by this stack trace element, or
      * <code>null</code> if the execution point is not within a method.
      * @playerversion Flash 9
      * @langversion 3.0 	  
      */
      public var methodName:String;

      /**
      * The name of the ActionScript file containing the execution point
      * represented by this stack trace element, or <code>null</code> if
      * this information is not available.
      * @playerversion Flash 9
      * @langversion 3.0 	  
      */
      public var fileName:String;

      /**
      * Line number of the execution point in the source file
      * specified by fileName, or <code>null</code> if this information
      * is not available.
      * @playerversion Flash 9
      * @langversion 3.0 	  
      */
      public var lineNumber:Integer;

      /**
      * The nativeMethod property value is <code>true</code> if the execution point is within a native method and
      * <code>false</code> otherwise.
      * @playerversion Flash 9
      * @langversion 3.0 	  
      */
      public var nativeMethod:Boolean;

      /**
      * Returns the string representation of this stack
      * trace element. Such as:
      * <pre>
      *    MyClass.method(MyClass.as:100)
      * </pre>
      * @playerversion Flash 9
      * @langversion 3.0 	  
      */
      public native function toString():String;
  }
}
package {

//****************************************************************************
// ActionScript Standard Library
// String object
//****************************************************************************


/**
 * The String class is a data type that represents a string of characters. The String class 
 * provides methods and properties that let you manipulate primitive string value types. 
 * You can convert the value of any object into a String data type object using the String() 
 * function. 
 * <p> 
 * All the methods of the String class, except for <code>concat()</code>, 
 * <code>fromCharCode()</code>, <code>slice()</code>, and <code>substr()</code>, are 
 * generic, which means the methods call <code>toString()</code> before performing their 
 * operations, and you can use these methods with other non-String objects. 
 * </p><p>
 * Because all string indexes are zero-based, the index of the last character 
 * for any string <code>x</code> is <code>x.length - 1</code>.
 * </p><p>
 * You can call any of the methods of the String class whether you use the constructor method
 * <code>new String()</code> to create a new string variable or simply assign a string literal value. 
 * Unlike previous versions of ActionScript, it makes no difference whether you use the constructor,
 * the global function, or simply assign a string literal value. The following lines of code are equivalent:
 * </p>
 * <listing version="3.0">
 * var str:String = new String("foo");
 * var str:String = "foo";
 * var str:String = String("foo");</listing>
 * <p>When setting a string variable to <code>undefined</code>, Flash Player coerces <code>undefined</code> 
 * to <code>null</code>. So, the statement:</p>
 * <pre>
 * var s:String = undefined;</pre>
 * sets the value to <code>null</code> instead of <code>undefined</code>. Use the <code>String()</code>
 * function if you need to use <code>undefined</code>.
 * @includeExample examples\StringExample.as -noswf
 * 
 * @playerversion Flash 9
 *
 * @see package.html#String() String Function
 * @refpath Objects/Core/String
 * @keyword string, string object, built-in class
 */
public final class String
{

    /**
      * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>String()</code> constructor function.
      * @playerversion Flash 9
      * @langversion 3.0 
      * @see #String()
      */
    public static const length:int = 1; 
    
	/**
	 * An integer specifying the number of characters in the specified String object.
	 * <p>
	 * Because all string indexes are zero-based, the index of the last character for any 
	 * string <code>x</code> is <code>x.length - 1</code>.
	 * </p>
	 *
	 * @playerversion Flash 9
	 *
	 * @oldexample The following example creates a new String object and uses <code>String.length</code> to count the number of characters:
	 * <pre>
	 * var my_str:String = "Hello world!";<br/>
	 * trace(my_str.length); // output: 12<br/>
	 * </pre>
	 * <p>The following example loops from 0 to <code>my_str.length</code>.
	 *
	 * <span class="flashonly"> The code checks the characters 
	 * within a string, and if the string contains the <code>&#64;</code> character, <code>true</code> displays in the Output panel.</span>
	 *
	 * <span class="flexonly"> The code checks the characters within a string, and if the string contains the <code>&#64;</code> character, 
	 * <code>true</code> writes to the log file.</span>
	 *
	 * <span class="flashonly"> If it does not contain the <code>&#64;</code> character, 
	 * <code>false</code> displays in the Output panel.</span>
	 
	 * <span class="flexonly"> If it does not contain the <code>&#64;</code> character, 
	 * then <code>false</code> writes to the log file.</span></p>
	 *
	 * <pre>
	 * function checkAtSymbol(my_str:String):Boolean {<br/>
	 *   for (var i = 0; i&lt;my_str.length; i++) {<br/>
	 *     if (my_str.charAt(i) == "&#64;") {<br/>
	 *       return true;<br/>
	 *     }<br/>
	 *   }<br/>
	 *   return false;<br/>
	 * }<br/>
	 * <br/>
	 * trace(checkAtSymbol("dog&#64;house.net")); // output: true<br/>
	 * trace(checkAtSymbol("Chris")); // output: false<br/>
	 * </pre>
	 * <span class="flashonly"><p>An example is also in the Strings.fla file in the HelpExamples folder. 
	 * The following list gives typical paths to this folder:</p>
	 * <ul>
	 *   <li>Windows: \Program Files\Macromedia\Flash MX 2004\Samples\HelpExamples\ </li>
	 *   <li>Macintosh: HD/Applications/Macromedia Flash MX 2004/Samples/HelpExamples/ </li>
	 *  </ul></p></span>
	 *
	 *
	 * @helpid x209C5
	 * @refpath Objects/Core/String/Properties/length
	 * @keyword string, string.length, length
	 */
	 public native function get length():int
	
 
   /**
	* Returns a string comprising the characters represented by the Unicode character codes
	* in the parameters.
	*
	* @playerversion Flash 9
	* 
	* @param ...charCodes A series of decimal integers that represent Unicode values.
	* 
	* @return The string value of the specified Unicode character codes.
	*
	* @oldexample The following example uses <code>fromCharCode()</code> to insert an <code>&#64;</code> character in the e-mail address:
	* <pre>
	* var address_str:String = "dog"+String.fromCharCode(64)+"house.net";<br/>
	* trace(address_str); // output: dog&#64;house.net <br/>
	* </pre>
	*
	*
	* @helpid x209BE
	* @refpath Objects/Core/String/Methods/fromCharCode
	* @keyword string, string.fromcharcode, fromcharcode, from character code
	*/
	public native static function fromCharCode(...charCodes):String;

 /**
  * Creates a new String object initialized to the specified string.
  * 
  * <p>
  * <strong>Note: </strong>Because string literals use less overhead than String 
  * objects and are generally easier to use, you should use string literals instead of the 
  * String class unless you have a good reason to use a String object rather than a string literal.
  * </p>
  *
  * @playerversion Flash 9
  *
  * @param val The initial value of the new String object.
  *
  * @return A reference to a String object.
  *
  *
  * @helpid x209C8
  * @refpath Objects/Core/String/new String
  * @keyword string, new string, new, constructor
  */	
	public native function String(val:String);
	
	
	/**
     * Returns the character in the position specified by the <code>index</code> parameter. 
	 * If <code>index</code> is not a number from 0 to <code>string.length - 1</code>, an 
	 * empty string is returned.
	 * <p>
	 * This method is similar to <code>String.charCodeAt()</code> except that the returned 
	 * value is a character, not a 16-bit integer character code.
	 * </p>
	 *
	 * @playerversion Flash 9
	 *
	 * @param index An integer specifying the position of a character in the string. The first 
	 * character is indicated by <code>0</code>, and the last character is indicated by 
	 * <code>my_str.length - 1</code>.
	 *
	 * @return The character at the specified index. Or an empty string if the
	 * specified index is outside the range of this string's indices.
	 *
	 * @oldexample In the following example, this method is called on the first letter of the string "<code>Chris</code>":
	 * <pre>
	 * var my_str:String = "Chris";<br/>
	 * var firstChar_str:String = my_str.charAt(0);<br/>
	 * trace(firstChar_str); // output: C<br/>
	 * </pre>
	 *
	 *
	 * @see #charCodeAt()
	 * @helpid x209BA
	 * @refpath Objects/Core/String/Methods/charAt
	 * @keyword string, string.charat, charat, character at
	 */
	public native function charAt(index:Number = 0):String;
	
	/**
	 * Returns the numeric Unicode character code of the character at the specified  
	 * <code>index</code>. If <code>index</code> is not a number from 0 to <code>
	 * string.length - 1</code>, <code>NaN</code> is returned.
	 * <p>
	 * This method is similar to <code>String.charAt()</code> except that the returned 
	 * value is a 16-bit integer character code, not the actual character.
	 * </p>
	 *
	 * @playerversion Flash 9
	 *
	 * @param index An integer that specifies the position of a character in the string. The 
	 * first character is indicated by <code>0,</code> and the last character is indicated by 
	 * <code>my_str.length - 1</code>.
	 *
	 * @return The Unicode character code of the character at the specified index. Or <code>
	 * NaN</code> if the index is outside the range of this string's indices.
	 * 
	 * @oldexample In the following example, this method is called on the first letter of the string "Chris":
	 * <pre>
	 * var my_str:String = "Chris";<br/>
	 * var firstChar_num:Number = my_str.charCodeAt(0);<br/>
	 * trace(firstChar_num); // output: 67<br/>
	 * </pre>
	 *
	 *
	 * @see #charAt()
	 * @helpid x209BB
	 * @refpath Objects/Core/String/Methods/charCodeAt
	 * @keyword string, string.charcodeat, charcodeat, character code at
	 */
	public native function charCodeAt(index:Number = 0):Number;
	
	/**
	 * Appends the supplied arguments to the end of the String object, converting them to strings if
	 * necessary, and returns the resulting string. The original value of the source String object 
	 * remains unchanged.
	 *
	 * @playerversion Flash 9
	 *
	 * @param ...args Zero or more values to be concatenated.
	 *
	 * @return A new string consisting of this string concatenated
	 * with the specified parameters.
	 *
	 * @oldexample The following example creates two strings and combines them using <code>String.concat()</code>:
	 * <pre>
	 * var stringA:String = "Hello";<br/>
	 * var stringB:String = "World";<br/>
	 * var combinedAB:String = stringA.concat(" ", stringB);<br/>
	 * trace(combinedAB); // output: Hello World<br/>
	 * </pre>
	 *
	 *
	 * @helpid x209BC
	 * @refpath Objects/Core/String/Methods/concat
	 * @keyword string, string.concat, concat, concatenate
	 */
	public native function concat(...args):String;
	
	/**
	 * Searches the string and returns the position of the first occurrence of <code>val</code> 
	 * found at or after <code>startIndex</code> within the calling string. This index is zero-based, 
	 * meaning that the first character in a string is considered to be at index 0--not index 1. If 
	 * <code>val</code> is not found, the method returns -1.
	 *
	 * @playerversion Flash 9
	 *
	 * @param val The substring for which to search.
	 *
	 * @param startIndex An optional integer specifying the starting index of the search.
	 *
	 * @return The index of the first occurrence of the specified substring or <code>-1</code>.
	 *
	 * @oldexample The following examples use <code>indexOf()</code> to return the index of characters and substrings:
	 * <pre>
	 * var searchString:String = "Lorem ipsum dolor sit amet.";<br/>
	 * var index:Number;<br/>
	 * <br/>
	 * index = searchString.indexOf("L");<br/>
	 * trace(index); // output: 0<br/>
	 * <br/>
	 * index = searchString.indexOf("l");<br/>
	 * trace(index); // output: 14<br/>
	 * <br/>
	 * index = searchString.indexOf("i");<br/>
	 * trace(index); // output: 6<br/>
	 * <br/>
	 * index = searchString.indexOf("ipsum");<br/>
	 * trace(index); // output: 6<br/>
	 * <br/>
	 * index = searchString.indexOf("i", 7);<br/>
	 * trace(index); // output: 19<br/>
	 * <br/>
	 * index = searchString.indexOf("z");<br/>
	 * trace(index); // output: -1<br/>
	 * </pre>
	 *
	 *
	 * @see #lastIndexOf()
	 * @helpid x209C2
	 * @refpath Objects/Core/String/Methods/indexOf
	 * @keyword string, string.indexof, indexof, index
	 */
	public native function indexOf(val:String = "undefined", startIndex:Number = 0):int;
	
	/**
	 * Searches the string from right to left and returns the index of the last occurrence 
	 * of <code>val</code> found before <code>startIndex</code>. The index is zero-based, 
	 * meaning that the first character is at index 0, and the last is at <code>string.length
	 * - 1</code>. If <code>val</code> is not found, the method returns <code>-1</code>.
	 *
	 * @playerversion Flash 9
	 *
	 * @param val The string for which to search.
	 *
	 * @param startIndex An optional integer specifying the starting index from which to 
	 * search for <code>val</code>. The default is the maximum value allowed for an index. 
     * If <code>startIndex</code> is not specified, the search starts at the last item in the string.
	 *
	 * @return The position of the last occurrence of the specified substring or -1 if not found.
	 *
	 * @oldexample The following example shows how to use <code>lastIndexOf()</code> to return the index of a certain character:
	 * <pre>
	 * var searchString:String = "Lorem ipsum dolor sit amet.";<br/>
	 * var index:Number;<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("L");<br/>
	 * trace(index); // output: 0<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("l");<br/>
	 * trace(index); // output: 14<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("i");<br/>
	 * trace(index); // output: 19<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("ipsum");<br/>
	 * trace(index); // output: 6<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("i", 18);<br/>
	 * trace(index); // output: 6<br/>
	 * <br/>
	 * index = searchString.lastIndexOf("z");<br/>
	 * trace(index); // output: -1<br/>
	 * </pre>
	 *
	 *
	 * @see #indexOf()
	 * @helpid x209C3
	 * @refpath Objects/Core/String/Methods/lastIndexOf
	 * @keyword string, string.lastindexof, lastindexof, last index of
	 */
	public native function lastIndexOf(val:String = "undefined", startIndex:Number=0x7FFFFFFF):int;
	
	/**
	 * Compares the sort order of two or more strings and returns the result of the comparison as an integer. While this
     * method is intended to handle the comparison in a locale-specific way, the ActionScript 3.0 implementation
     * does not produce a different result from other string comparisons such as the equality (<code>==</code>) or 
     * inequality (<code>!=</code>) operators.
	 * If the strings are equivalent, the return value is 0.
	 * If the original string value precedes the string value specified by <code>other</code>, 
	 * the return value is a negative integer, the absolute value of which represents
	 * the number of characters that separates the two string values.
	 * If the original string value comes after <code>other</code>,
	 * the return value is a positive integer, the absolute value of which represents
	 * the number of characters that separates the two string values.
	 *
	 * @param other A string value to compare.
     * @param ...values Optional set of more strings to compare.
	 * @return The value 0 if the strings are equal. Otherwise, a negative integer if the original
	 * string precedes the string argument and a positive integer if the string argument precedes
	 * the original string. In both cases the absolute value of the number represents the difference
	 * between the two strings.
	 */
	public native function localeCompare(other:String, ...values):int;
	
	/**
	* Matches the specifed <code>pattern</code> against the string and returns a new string
	* in which the first match of <code>pattern</code> is replaced with the content specified by <code>repl</code>. 
	* The <code>pattern</code> parameter can be a string or a regular expression. The <code>repl</code> parameter
	* can be a string or a function; if it is a function, the string returned  
	* by the function is inserted in place of the match. The original string is not modified.
	* 
	* <p>In the following example, only the first instance of "sh" (case-sensitive)
	* is replaced: </p>
	*
	* <listing>
	* var myPattern:RegExp = /sh/;  
	* var str:String = "She sells seashells by the seashore.";
	* trace(str.replace(myPattern, "sch"));  
	*    // She sells seaschells by the seashore.</listing>
	* 
	* <p>In the following example, all instances of "sh" (case-sensitive)
	* are replaced because the <code>g</code> (global) flag is set in the regular expression: </p>
	*
	* <listing>
	* var myPattern:RegExp = /sh/g;  
	* var str:String = "She sells seashells by the seashore.";
	* trace(str.replace(myPattern, "sch"));  
	*    // She sells seaschells by the seaschore.</listing>
	* 
	* <p>In the following example, all instance of "sh" 
	* are replaced because the <code>g</code> (global) flag is set in the regular expression 
	* and the matches are <i>not</i> case-sensitive becuase the <code>i</code> (ignoreCase) flag is set:</p>
	*
	* <listing>
	* var myPattern:RegExp = /sh/gi;  
	* var str:String = "She sells seashells by the seashore.";
	* trace(str.replace(myPattern, "sch"));  
	*    // sche sells seaschells by the seaschore.</listing>
	* 
	* @param pattern The pattern to match, which can be any type of object, but it is typically 
	* either a string or a regular expression. If you specify a <code>pattern</code> parameter
	* that is any object other than a string or a regular expression, the <code>toString()</code> method is 
	* applied to the parameter and the <code>replace()</code> method executes using the resulting string 
	* as the <code>pattern</code>. 
	*
	* @param repl Typically, the string that is inserted in place of the matching content. However, you can 
	* also specify a function as this parameter. If you specify a function, the string returned  
	* by the function is inserted in place of the matching content.
	* 
	* <p>When you specify a string as the <code>repl</code> parameter and specify a regular expression 
	* as the <code>pattern</code> parameter, you can use the following special <em>$ replacement codes</em>  
	* in the <code>repl</code> string:</p>
	* 
	* <table class="innertable">
	* 
	* <tr>
	* 
	* 	<th NOWRAP="true">$ Code
	* 	</th>
	* 
	* 	<th>Replacement Text
	* 	</th>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$$</code>
	* 	</td>
	* 
	* 	<td><code>$</code>
	* 	</td>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$&amp;</code>
	* 	</td>
	* 
	* 	<td>The matched substring.
	* 	</td>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$`</code>	
	* 	</td>
	* 
	* 	<td>The portion of the string that precedes the matched substring. 
	* 	Note that this code uses the straight left single quote character (`), 
	* 	not the straight single quote character (') or the left curly single quote 
    *   character (&#0145;).
	* 	</td>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$'</code>
	* 	</td>
	* 
	* 	<td>The portion of string that follows the matched substring. 
    *   Note that this code uses the straight single quote character (').
	* 	</td>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$</code><em>n</em>
	* 	</td>
	* 
	* 	<td>The <em>n</em>th captured parenthetical group match, where <em>n</em> is a single 
	*	digit 1-9 and <code>$</code><em>n</em> is not followed by a decimal digit. 
	* 	</td>
	* 
	* </tr>
	* 
	* <tr>
	* 
	* 	<td><code>$</code><em>nn</em>
	* 	</td>
	* 
	* 	<td>The <em>nn</em>th captured parenthetical group match, where <em>nn</em> is a two-digit 
	* 	decimal number (01-99). If the <em>nn</em>th capture is undefined, the replacement text 
	* 	is an empty string. 
	* 	</td>
	* 
	* </tr>
	* 
	* </table>
	* 
	* <p>For example, the following shows the use of the <code>$2</code> and <code>$1</code> 
	* replacement codes, which represent the first and second capturing group matched:</p>
	* 
	* <listing>var str:String = "flip-flop";
	* var pattern:RegExp = /(\w+)-(\w+)/g;
	* trace(str.replace(pattern, "$2-$1")); // flop-flip</listing>
	* 
	* <p>When you specify a function as the <code>repl</code>, the <code>replace()</code> method
	* passes the following parameters to the function:
	* </p>
	* 
	* <ul>
	* 
	* 	<li>
	* 	The matching portion of the string.
	* 	</li>
	* 
	* 	<li>
	* 	Any captured parenthetical group matches are provided as the next arguments. The number of arguments passed
	* 	this way will vary depending on the number of parenthetical matches. You can determine the
	* 	number of parenthetical matches by checking <code>arguments.length - 3</code> within the function
	* 	code.
	* 	</li>
	* 
	* 	<li>
	* 	The index position in the string where the match begins.
	* 	</li>
	* 
	* 	<li>
	* 	The complete string.
	* 	</li>
	* 
	* </ul>
	* 
	* <p>For example, consider the following:</p>
	* 
	* <listing>
	* var str1:String = "abc12 def34";
	* var pattern:RegExp = /([a-z]+)([0-9]+)/;
	* var str2:String = str1.replace(pattern, replFN);
	* trace (str2);   // 12abc 34def
	* 
	* function replFN():String {
	* 	return arguments[2] + arguments[1];
	* }</listing>
	* 
	* 
	* <p>The call to the <code>replace()</code> method uses a function as the <code>repl</code>
	* parameter. The regular expression (<code>/([a-z]*)([0-9]*)/g</code>) is matched twice. The 
	* first time, the pattern matches the substring <code>"abc12"</code>, and the following list 
	* of arguments is passed to the function:
	* </p>
	* 
	* <listing>
	* {"abc12", "abc", "12", 0, "abc12 def34"}</listing>
	* 
	* 
	* <p>The second time, the pattern matches the substring <code>"def23"</code>, and the 
	* following list of arguments is passed to the function:
	* </p>
	*
	* <listing>
	* {"def34", "def", "34", 6, "abc123 def34"}</listing>
	* 
	* 
	* @return   The resulting string. Note that the source string remains unchanged.
	* 
	* @see RegExp
	*/
	public native function replace(pattern:*, repl:Object):String; 

	/**
	* Matches the specifed <code>pattern</code> against the 
	* string.
	*
	* @param pattern The pattern to match, which can be any type of object, but it is typically 
	* either a string or a regular expression. If the <code>pattern</code> is not a regular expression
	* or a string, then the method converts it to a string before executing. 
	* 
	* @return An array of strings consisting of all substrings in 
	* the string that match the specified <code>pattern</code>.
	* 
	* <p>If <code>pattern</code> is a regular expression, in order to return an array with 
	* more than one matching substring, the <code>g</code> (global) flag must be set
	* in the regular expression: </p>
	* 
	* <ul>
	* 
	* 	<li>If the <code>g</code> (global) flag is <em>not</em> set,
	* the return array will contain no more than one match, and the <code>lastIndex</code>
	* property of the regular expression remains unchanged.</li> 
	* 
	* 	<li>If the <code>g</code> (global) flag <em>is</em> set, the method starts the search at
	* the beginning of the string (index position 0). If a matching substring is an empty string (which
	* can occur with a regular expression such as <code>/x~~/</code>), the method adds that
	* empty string to the array of matches, and then continues searching at the next index position. 
	* The <code>lastIndex</code> property of the regular expression is set to 0 after the 
	* method completes. </li>
	* 
	* </ul>
	*
	* <p>If no match is found, the method returns <code>null</code>. If you pass
	* no value (or an undefined value) as the <code>pattern</code> parameter, 
	* the method returns <code>null</code>.</p>
	*
	* 
	* @oldexample <pre><code>
	* 	 var myPattern:RegExp = /sh./g;  
	* 		// The dot (.) matches any character.
	*	 var str:String = "She sells seashells by the seashore.";
	*	 trace(str.match(myPattern));  
	*
	*	 	// Output: she,sho
	*
	* 	 myPattern = /sh./gi;  
	* 		// This time, make it case insensitive (with the i flag).
	*	 str = "She sells seashells by the seashore.";
	*	 trace(str.match(myPattern));  
	*
	*	 	// Output: She,she,sho	
	*
	* 	 myPattern = RegExp = new RegExp("sh(.)", "gi")  
	* 		// Note the grouping parentheses.
	*	 str = "She sells seashells by the seashore.";
	*	 trace(str.match(myPattern));  
	*
	*		// Output: She,e,she,e,sho,o
	* 	 	// Note that the result array is 
	* 		// [[She,e],[she,e],[sho,o]] 
	* </code></pre>
	*
	* @see RegExp
	*/
	public native function match(pattern:*):Array;

   /**
	* Searches for the specifed <code>pattern</code> and returns the index of 
	* the first matching substring. If there is no matching substring, the method returns 
	* <code>-1</code>.
	* 
	* @param pattern The pattern to match, which can be any type of object but is typically 
	* either a string or a regular expression.. If the <code>pattern</code> is not a regular expression
	* or a string, then the method converts it to a string before executing. 
	* Note that if you specify a regular expression, the method ignores the global flag ("g") of the 
	* regular expression, and it ignores the <code>lastIndex</code> property of the regular
	* expression (and leaves it unmodified). If you pass an undefined value (or no value), 
	* the method returns <code>-1</code>.
	* 
	* @return  The index of the first matching substring, or <code>-1</code> if 
	* there is no match. Note that the string is zero-indexed; the first character of 
	* the string is at index 0, the last is at <code>string.length - 1</code>. 
	* 
	* @oldexample <pre><code>
	*	 var str:String = "She sells seashells by the seashore.";
	* 	 var myPattern:RegExp = /sh/;  
	* 		// This time, make it case insensitive (with the i flag).
	*	 trace(str.match(myPattern));  
	*
	*		// Output: 13
	*		// (The substring match starts at character position 13.)
	*
	* 	 var myPattern:RegExp = /sh/i;
	*	 trace(str.match(myPattern));  
	*
	*		// Output: 0
	*		// (The substring match starts at character position 0 
	* 		//   -- the first character of the source string.)
	* </code></pre>
	*
	* @see RegExp
	*/
	public native function search(pattern:*):int;
	
	/**
	 * Returns a string that includes the <code>startIndex</code> character 
	 * and all characters up to, but not including, the <code>endIndex</code> character. The original String object is not modified. 
	 * If the <code>endIndex</code> parameter is not specified, then the end of the 
	 * substring is the end of the string. If the character indexed by <code>startIndex</code> is the same as or to the right of the 
	 * character indexed by <code>endIndex</code>, the method returns an empty string.
	 * 
	 * 
	 * @playerversion Flash 9
	 *
	 * @param startIndex The zero-based index of the starting point for the slice. If 
	 * <code>startIndex</code> is a negative number, the slice is created from right-to-left, where 
	 * -1 is the last character.
	 *
	 * @param endIndex An integer that is one greater than the index of the ending point for 
	 * the slice. The character indexed by the <code>endIndex</code> parameter is not included in the extracted 
	 * string.  
	 * If <code>endIndex</code> is a negative number, the ending point is determined by 
	 * counting back from the end of the string, where -1 is the last character.
	 * The default is the maximum value allowed for an index. If this parameter is omitted, <code>String.length</code> is used.
	 *
	 * @return A substring based on the specified indices.
	 *
	 * @oldexample The following example creates a variable, <code>my_str,</code> assigns it a String value, and then calls 
	 * the <code>slice()</code> method using a variety of values for both the <code><em>start</em></code> and <code><em>end</em></code>
	 * parameters. 
	 * <span class="flashonly">Each call to <code>slice()</code> is wrapped in a <code>trace()</code> statement that displays 
	 * the output in the Output panel. </span>
	 * <span class="flexonly">Each call to the <code>slice()</code> method is wrapped in a 
	 * <code>trace()</code> statement that sends the output to the log file. </span>
	 *
	 * <pre>
	 * // Index values for the string literal<br/>
	 * // positive index:  0   1   2   3   4<br/>
	 * // string:          L   o   r   e   m<br/>
	 * // negative index: -5  -4  -3  -2  -1<br/>
	 * <br/>
	 * var my_str:String = "Lorem";<br/>
	 * <br/>
	 * // slice the first character<br/>
	 * trace("slice(0,1): "+my_str.slice(0, 1)); // output: slice(0,1): L<br/>
	 * trace("slice(-5,1): "+my_str.slice(-5, 1)); // output: slice(-5,1): L<br/>
	 * <br/>
	 * // slice the middle three characters<br/>
	 * trace("slice(1,4): "+my_str.slice(1, 4)); // slice(1,4): ore<br/>
	 * trace("slice(1,-1): "+my_str.slice(1, -1)); // slice(1,-1): ore<br/>
	 * <br/>
	 * // slices that return empty strings because start is not to the left of end<br/>
	 * trace("slice(1,1): "+my_str.slice(1, 1)); // slice(1,1):<br/>
	 * trace("slice(3,2): "+my_str.slice(3, 2)); // slice(3,2):<br/>
	 * trace("slice(-2,2): "+my_str.slice(-2, 2)); // slice(-2,2):<br/>
	 * <br/>
	 * // slices that omit the end parameter use String.length, which equals 5<br/>
	 * trace("slice(0): "+my_str.slice(0)); // slice(0): Lorem<br/>
	 * trace("slice(3): "+my_str.slice(3)); // slice(3): em<br/>
	 * </pre>
	 * <span class="flashonly"><p>An example is also in the Strings.fla file in the HelpExamples folder. 
	 * The following list gives typical paths to this folder:
	 * <ul>
	 *   <li>Windows: \Program Files\Macromedia\Flash MX 2004\Samples\HelpExamples\ </li>
	 *   <li>Macintosh: HD/Applications/Macromedia Flash MX 2004/Samples/HelpExamples/ </li>
	 * </ul>
	 * </p>
	 * </span>
	 *
	 * @see #substr()
	 * @see #substring()
	 * @helpid x209CB
	 * @refpath Objects/Core/String/Methods/slice
	 * @keyword string, string.slice, slice
	 */
	public native function slice(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
	
	/**
	 * Splits a String object into an array of substrings 
	 * by dividing it wherever the specified <code>delimiter</code> parameter 
	 * occurs. 
	 * 
	 * <p>If the <code>delimiter</code> parameter is a regular expression, only 
	 * the first match at a given position of the string is considered, 
	 * even if backtracking could find a nonempty substring match at that
	 * position. For example:</p>
	 * 
	 * <listing version="3.0">
	 * var str:String = "ab";
	 * var results:Array = str.split(/a~~?/); // results == ["","b"]
	 * 
	 * results = str.split(/a~~/); // results == ["","b"].)</listing>
	 * 
	 * 
	 * <p>If the <code>delimiter</code> parameter is a regular expression 
	 * containing grouping parentheses, then each time the 
	 * <code>delimiter</code> is matched, the results (including any 
	 * undefined results) of the grouping parentheses are spliced into the
	 * output array. For example</p>
	 * 
	 * <listing version="3.0">
	 * var str:String = "Thi5 is a tricky-66 example.";
	 * var re:RegExp = /(\d+)/;
	 * var results:Array = str.split(re);
	 *     // results == ["Thi","5"," is a tricky-","66"," example."]</listing>
	 * 
	 * 
	 * <p>If the <code>limit</code> parameter is specified, then 
	 * the returned array will have no more than the specified 
	 * number of elements.</p>
     * <p>If the <code>delimiter</code> is an empty string, an empty 
     * regular expression, or a regular expression that can match an empty 
     * string, each single character in the string 
     * is ouput as an element in the array.</p>
     * 
     * <p>If the <code>delimiter</code> parameter is undefined, the entire 
     * string is placed into the first element of the returned 
     * array. </p>     
	 *
	 * @playerversion Flash 9
	 *
	 * @param delimiter The pattern that specifies where to split this string. This can be any type of 
	 * object but is typically either a string or a regular expression. If the <code>delimiter</code> 
	 * is not a regular expression or string, then the method converts it to a string before executing. 
	 *
	 * @param limit The maximum number of items to place into the array. 
	 * The default is the maximum value allowed. 
	 * 
	 *
	 * @return An array of substrings.
	 *
	 *
	 *
	 * @see Array#join()
	 * @see RegExp
	 * @helpid x209CC
	 * @refpath Objects/Core/String/Methods/split
	 * @keyword string, string.split, split
	 */
	public native function split(delimiter:*, limit:Number = 0x7fffffff):Array;
	
	/**
	 * Returns a substring consisting of the characters that start at the specified <code>
	 * startIndex</code> and with a length specified by <code>len</code>. The original
	 * string is unmodified.
	 *
	 * @playerversion Flash 9
	 *
	 * @param startIndex An integer that specified the index of the first character to be 
	 * used to create the substring. If <code>startIndex</code> is a negative number, the 
	 * starting index is determined from the end of the string, where <code>-1</code> is the 
	 * last character.
	 *
	 * @param len The number of characters in the substring being created. 
	 * The default value is the maximum value allowed. If <code>len</code> 
	 * is not specified, the substring includes all the characters from <code>startIndex</code>
	 * to the end of the string.
	 *
	 * @return A substring based on the specified parameters.
	 *
	 * @oldexample The following example creates a new string, my_str and uses <code>substr()</code> to return the second word in the string; first, using a positive <code><em>start</em></code> parameter, and then using a negative <code><em>start</em></code> parameter:
	 * <pre>
	 * var my_str:String = new String("Hello world");<br/>
	 * var mySubstring:String = new String();<br/>
	 * mySubstring = my_str.substr(6,5);<br/>
	 * trace(mySubstring); // output: world<br/>
	 * <br/>
	 * mySubstring = my_str.substr(-5,5);<br/>
	 * trace(mySubstring); // output: world<br/>
	 * </pre>
	 * <span class="flashonly"><p>An example is also in the Strings.fla file in the HelpExamples folder. The following list gives typical paths to this folder:</p>
	 * <ul>
	 *   <li>Windows: \Program Files\Macromedia\Flash MX 2004\Samples\HelpExamples\ </li>
	 *   <li>Macintosh: HD/Applications/Macromedia Flash MX 2004/Samples/HelpExamples/ </li>
	 * </ul></span>
	 *
	 *
	 * @helpid x209CD
	 * @refpath Objects/Core/String/Methods/substr
	 * @keyword string, string.substr, substr, substring
	 */
	public native function substr(startIndex:Number = 0, len:Number = 0x7fffffff):String;
	
	/**
	 * Returns a string consisting of the character specified by <code>startIndex</code> 
	 * and all characters up to <code>endIndex - 1</code>. If <code>endIndex</code> is not 
	 * specified, <code>String.length</code> is used. If the value of <code>startIndex</code> 
	 * equals the value of <code>endIndex</code>, the method returns an empty string.
	 * If the value of <code>startIndex</code> is greater than the value of <code>
	 * endIndex</code>, the parameters are automatically swapped before the function 
	 * executes. The original string is unmodified.
	 *
	 * @playerversion Flash 9
	 *
	 * @param startIndex An integer specifying the index of the first character used to create 
	 * the substring. Valid values for <code>startIndex</code> are <code>0</code> through 
	 * <code>String.length</code>. If <code>startIndex</code> is a negative value, <code>0
	 * </code> is used.
	 *
	 * @param endIndex An integer that is one greater than the index of the last character in the
	 * extracted substring. Valid values for <code>endIndex</code> are <code>0</code> through 
	 * <code>String.length</code>. The character at <code>endIndex</code> is not included in 
	 * the substring. The default is the maximum value allowed for an index. 
	 * If this parameter is omitted, <code>String.length</code> is used. If 
	 * this parameter is a negative value, <code>0</code> is used.
	 *
	 * @return A substring based on the specified parameters.
	 *
	 * @oldexample The following example shows how to use <code>substring()</code>:
	 * <pre>
	 * var my_str:String = "Hello world";<br/>
	 * var mySubstring:String = my_str.substring(6,11);<br/>
	 * trace(mySubstring); // output: world<br/>
	 * </pre>
	 * <p>The following example shows what happens if a negative <code><em>start</em></code> parameter is used:</p>
	 * <pre>
	 * var my_str:String = "Hello world";<br/>
	 * var mySubstring:String = my_str.substring(-5,5);<br/>
	 * trace(mySubstring); // output: Hello<br/>
	 * </pre>
	 * <span class="flashonly"><p>An example is also in the Strings.fla file in the Examples folder. The following list gives typical paths to this folder:</p>
	 * <ul>
	 *   <li>Windows: \Program Files\Macromedia\Flash MX 2004\Samples\HelpExamples\ </li>
	 *   <li>Macintosh: HD/Applications/Macromedia Flash MX 2004/Samples/HelpExamples/ </li>
	 * </ul></span>
	 *
	 *
	 * @helpid x209CE
	 * @refpath Objects/Core/String/Methods/substring
	 * @keyword string, string.substring, substring
	 */
	public native function substring(startIndex:Number = 0, endIndex:Number = 0x7fffffff):String;
	
	/**
	 * Returns a copy of this string, with all uppercase characters converted
	 * to lowercase. The original string is unmodified.
	 * 
	 * <p>This method converts all characters (not simply A-Z) for which Unicode lowercase
	 * equivalents exist:</p>
	 * 
	 * <listing>
	 * var str:String = " JOSÉ BARÇA";
	 * trace(str.toLowerCase()); // josé barça</listing>
	 * 
	 * <p>These  case mappings are defined in the 
	 * <a href="http://www.unicode.org/Public/UNIDATA/UnicodeData.txt" target="newWindow">UnicodeData.txt</a> file and the 
	 * <a href="http://www.unicode.org/Public/UNIDATA/SpecialCasing.txt" target="newWindow">SpecialCasings.txt</a> file, as defined 
	 * in the <a href="http://www.unicode.org/Public/UNIDATA/UCD.html" target="newWindow">Unicode Character Database</a>
	 * specification. </p>
	 *
	 * @playerversion Flash 9
	 *
	 * @return A copy of this string with all uppercase characters converted
	 * to lowercase.
	 *
	 * @see #toUpperCase()
	 * @helpid x209CF
	 * @refpath Objects/Core/String/Methods/toLowerCase
	 * @keyword string, string.tolowercase, tolowercase, to lowercase
	 */
	public native function toLowerCase():String;
	
	/**
	 * Returns a copy of this string, with all uppercase characters converted
     * to lowercase. The original string is unmodified. While this
     * method is intended to handle the conversion in a locale-specific way, the ActionScript 3.0 implementation
     * does not produce a different result from the <code>toLowerCase()</code> method.
	 *
	 * @return A copy of this string with all uppercase characters converted
	 * to lowercase.
	 * 
	 * @see #toLowerCase()
	 */	
	public native function toLocaleLowerCase():String;

	
	/**
	 * Returns a copy of this string, with all lowercase characters converted 
	 * to uppercase. The original string is unmodified.
	 *
	 * <p>This method converts all characters (not simply a-z) for which Unicode uppercase
	 * equivalents exist:</p>
	 * 
	 * <listing>
	 * var str:String = "José Barça";
	 * trace(str.toUpperCase()); // JOSÉ BARÇA</listing>
	 *
	 * <p>These  case mappings are defined in the 
	 * <a href="http://www.unicode.org/Public/UNIDATA/UnicodeData.txt" target="newWindow">UnicodeData.txt</a> file and the 
	 * <a href="http://www.unicode.org/Public/UNIDATA/SpecialCasing.txt" target="newWindow">SpecialCasings.txt</a> file, as defined 
	 * in the <a href="http://www.unicode.org/Public/UNIDATA/UCD.html" target="newWindow">Unicode Character Database</a>
	 * specification. </p>
	 *
	 * @playerversion Flash 9
	 *
	 * @return A copy of this string with all lowercase characters converted
	 * to uppercase.
	 *
	 *
	 * @see #toLowerCase()
	 * @helpid x209D0
	 * @refpath Objects/Core/String/Methods/toUpperCase
	 * @keyword string, string.touppercase, touppercase, to uppercase
	 */
	public native function toUpperCase():String;
	
	/**
	 * Returns a copy of this string, with all lowercase characters converted 
     * to uppercase. The original string is unmodified. While this
     * method is intended to handle the conversion in a locale-specific way, the ActionScript 3.0 implementation
     * does not produce a different result from the <code>toUpperCase()</code> method.
	 *
	 * @playerversion Flash 9
	 *
	 * @return A copy of this string with all lowercase characters converted
	 * to uppercase.
	 *
	 * @see #toUpperCase()
	 */
	public native function toLocaleUpperCase():String;
	
	/**
	 * Returns the primitive value of a String instance. This method is designed to
	 * convert a String object into a primitive string value. Because Flash Player 
	 * automatically calls <code>valueOf()</code> when necessary, 
	 * you rarely need to explicitly call this method.
	 *
	 * @playerversion Flash 9
	 *
	 * @return The value of the string.
	 *
	 * @oldexample The following example creates a new instance of the String class
	 * and then shows that the <code>valueOf</code> method returns 
	 * the <i>primitive</i> value, rather than a reference to the new instance.
	 * 
	 * <listing version="2.0">
	 * var str:String = new String("Hello World");
	 * var value:String = str.valueOf();
	 * trace(str instanceof String); // true
	 * trace(value instanceof String); // false
	 * trace(str === value); // false</listing>
	 * 
	 * 
	 * @langversion 3.0
	 */
	public native function valueOf():String;
}


}
package {
/**
 * A SyntaxError exception is thrown when a parsing error occurs. 
 * <ul>
 *  <span class="hide"> <li>ActionScript does not support the <code>eval</code> function or the <code>Function</code> 
 * constructor, two features that require an ActionScript compiler to be present to work. 
 * Therefore, ActionScript cannot throw <code>SyntaxError</code> exceptions in the cases 
 * described in the ECMA-262 specification.</li></span>
 *   <li>ActionScript throws <code>SyntaxError</code> exceptions when an invalid 
 * regular expression is parsed by the <code>RegExp</code> class.</li>
 *   <li>ActionScript throws <code>SyntaxError</code> exceptions when invalid XML is 
 * parsed by the <code>XML</code> class.</li>
 *   <span class="hide"><li><code>SyntaxError</code> exceptions are thrown in accordance with the E4X 
 * specification; for instance, Section 10.3.1</li></span>
 * </ul>
 * 
 *
 * @see RegExp RegExp class
 * @see XML XML class
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, SyntaxError
 */
public dynamic class SyntaxError extends Error
{
	/**
	 * Creates a new SyntaxError object.
	 */
	public native function SyntaxError(message:String = "");

}


}
package {

/**
 * A TypeError exception is thrown when the actual type of an operand is different
 * from the expected type. 
 * <p>
 * In addition, this exception is thrown when:
 *  <ul>
 *  <li>An actual parameter to a function or method could not be coerced to the formal 
 * parameter type.</li>
 *  <li>A value is assigned to a variable and cannot be coerced to the variable's type.</li>
 *  <li>The right side of the <code>is</code> or <code>instanceof</code> operator is not a valid type.</li>
 *  <li>The <code>super</code> keyword is used illegally.</li>
 *  <li>A property lookup results in more than one binding, and is therefore ambiguous.</li>
 *  <li>A method is invoked on an incompatible object.  For example, a <code>TypeError</code>
 * exception is thrown if a <code>RegExp</code> method is "grafted" onto a generic object
 * and then invoked.</li>
 *	</ul>
 * </p>
 *
 * @see operators.html#is is operator
 * @see operators.html#instanceof instanceof operator
 * @see statements.html#super super statement
 * @see RegExp RegExp class
 * @includeExample examples\TypeErrorExample.as -noswf
 * 
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, TypeError
 *
 */
public dynamic class TypeError extends Error
{
	/**
	 * Creates a new TypeError object.
	 */
	public native function TypeError(message:String = "");
	
}


}
package {
/**
 * The uint class provides methods for working with a data type representing a 32-bit unsigned integer. Because an unsigned integer can only be 
 * positive, its maximum value is twice that of the int class.
 * <p>The range of values represented by the uint class is 0 to 4,294,967,295 (2^32-1).</p>
 * <p>You can create a uint object by declaring a variable of type uint and assigning the variable a literal value. The default value of a variable of type uint is <code>0</code>.</p>
 * <p>The uint class is primarily useful for pixel color values (ARGB and RGBA) and other situations where 
 * the int data type does not work well. For example, the number 0xFFFFFFFF, which 
 * represents the color value white with an alpha value of 255, can't be represented 
 * using the int data type because it is not within the valid range of the int values.</p> 
 *
 * <p>The following example creates a uint object and calls the <code>
 * toString()</code> method:</p>
 * <pre>
 * var myuint:uint = 1234;
 * trace(myuint.toString()); // output: 1234
 * </pre>
 * <p>The following example assigns the value of the <code>MIN_VALUE</code> 
 * property to a variable without the use of the constructor:</p>
 * <pre>
 * var smallest:uint = uint.MIN_VALUE;
 * trace(smallest.toString()); // output: 0
 * </pre> 
 *
 * @includeExample examples\UintExample.as -noswf
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 *
 * @helpid x2097D
 * @refpath Objects/Core/uint
 * @keyword uint object, uint, built-in class
 * @see int.html int
 * @see Number.html Number
 */
public final class uint
{
   /** 
	* The largest representable 32-bit unsigned integer, which is 4,294,967,295.
	*
   	* @playerversion Flash 9
   	* @langversion 3.0 
	*
	* @example The following ActionScript displays the largest and smallest representable 
	* <code>uint</code> values:
	* <pre>
	* trace("uint.MIN_VALUE = " + uint.MIN_VALUE);
	* trace("uint.MAX_VALUE = " + uint.MAX_VALUE);
	* </pre>
	* <p>The values are:</p>
	* <pre>
	* uint.MIN_VALUE = 0
	* uint.MAX_VALUE = 4294967295
	* </pre>
	*
	* @helpid x20964
	* @refpath Objects/Core/uint/Constants/MAX_VALUE
	* @keyword uint, uint.max_value, max_value, max value
	*/
	public static const MAX_VALUE:uint = 4294967295;
 
	/**
	 * The smallest representable unsigned integer, which is <code>0</code>.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
     *
	 * @example The following ActionScript displays the largest and smallest representable 
	 * <code>uint</code> values:
	 * <pre>
	 * trace("uint.MIN_VALUE = " + uint.MIN_VALUE);
	 * trace("uint.MAX_VALUE = " + uint.MAX_VALUE);
	 * </pre>
	 * <p>The values are:</p>
	 * <pre>
	 * uint.MIN_VALUE = 0
	 * uint.MAX_VALUE = 4294967295
	 * </pre>
     *
     * @helpid x2096B
     * @refpath Objects/Core/uint/Constants/MIN_VALUE
     * @keyword uint, uint.min_value, min_value, min value
     */
	public static const MIN_VALUE:uint = 0;
 
	/**
	 * Creates a new uint object. You can create a variable of uint type and assign it a literal value. The <code>new uint()</code> constructor is primarily used 
	 * as a placeholder. A uint object is not the same as the <code>
	 * uint()</code> function, which converts a parameter to a primitive value.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @param num The numeric value of the uint object being created, 
	 * or a value to be converted to a number. If <code>num</code> is not provided,
	 * the default value is <code>0</code>.
	 *
	 * @return A reference to a uint object.
	 *
	 * @example The following code constructs two new uint objects; the first by assigning a literal value, and the second by using the constructor function:
	 * <pre>
	 * var n1:uint = 3;
	 * var n2:uint = new uint(10);
	 * </pre>
	 *
	 * @helpid x2097C
	 * @refpath Objects/Core/uint/new uint
	 * @keyword new number, constructor
	 */	
	public native function uint(num:Object);
	
	/**
	 * Returns the string representation of a uint object.
	 *
     * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @usage <code><em>myuint</em>.toString(</code><code><em>radix:uint</em></code><code>) </code><code><em>: String</em></code>
	 *
	 * @param radix Specifies the numeric base (from 2 to 36) to use for the 
	 * number-to-string conversion. If you do not specify the <code>radix</code>
	 * parameter, the default value is <code>10</code>.
	 *
	 * @return The string representation of the uint object.
	 *
	 * @example The following example uses 2 and 8 for the <code>radix</code>
	 * parameters and returns a string value with the corresponding 
	 * representation of the number 9:
	 * <pre>
	 * var myuint:uint = 9;
	 * trace(myuint.toString(2)); // output: 1001
	 * trace(myuint.toString(8)); // output: 11
	 * </pre>
	 * The following example creates hexadecimal values:
	 * <pre>
	 * var r:uint = 250;
	 * var g:uint = 128;
	 * var b:uint = 114;
	 * var rgb:String = "0x" + r.toString(16) + g.toString(16) + b.toString(16);
	 * trace(rgb); // output: 0xFA8072 (Hexadecimal equivalent of the color 'salmon')
	 * </pre>
	 *
	 * @helpid x2097E
	 * @refpath Objects/Core/uint/Methods/toString
	 * @keyword uint, uint.tostring, tostring
	 */	
	public native function toString(radix:uint):String;	
	
	/**
	 * Returns the primitive uint type value of the specified
	 * uint object.
	 *
	 * @playerversion Flash 9
     * @langversion 3.0 
	 *
	 * @return The primitive uint type value of this uint
	 * object.
	 *
	 * @example The following example outputs the primitive value of the <code>
	 * numSocks</code> object.
	 * <pre>
	 * var numSocks:uint = 2;
	 * trace(numSocks.valueOf()); // output: 2
	 * </pre>
	 *
	 * @helpid x20A24
	 * @refpath Objects/Core/uint/Methods/valueOf
	 * @keyword number, number.valueof, valueof, value of
	 */	
	public native function valueOf():uint;
}

}
package {

/**
 * A URIError exception is thrown when one of the global URI handling functions is used 
 * in a way that is incompatible with its definition. This exception is thrown when an invalid 
 * URI is specified to a Flash 
 * Player API function that expects a valid URI, such as the <code>Socket.connect()</code> 
 * method or the <code>XML.load()</code> method.
 * 
 * 
 * @playerversion Flash 9
 * @langversion 3.0 
 * @helpid x20ACB
 * @refpath 
 * @keyword Error, URIError
 *
 * @see flash.net.Socket#connect()
 * @see XML#load()
 */
public dynamic class URIError extends Error
{
	/**
	 * Creates a new URIError object.
     * @param message Contains the message associated with the URIError object.  
	 */
	public native function URIError(message:String = "");
	
}

}
package {
//****************************************************************************
// ActionScript Standard Library
// VerifyError object
//****************************************************************************
/**
 * The VerifyError class represents an error that occurs when a malformed 
 * or corrupted SWF file is encountered. 
 * 
 * @tiptext An VerifyError is thrown when a malformed or corrupted SWF File is encountered.
 * 
 * @includeExample
 * 
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid 
 * @refpath 
 * @keyword Error
 * @see flash.display.Loader Loader class
 */
public dynamic class VerifyError extends Error
{
	/**
	 * Creates a new VerifyError object.
     * @param message Contains the message associated with the VerifyError object.      
	 */
	public native function VerifyError(message:String = "");
}


}
package {
//
// XML
//

// Based on the ECMA E4X Specification, 2nd Edition

	/**
	* The XML class contains methods and properties for working with XML objects. The XML class
	* (along with the XMLList, Namespace, and QName classes) implements the 
	* powerful XML-handling standards defined in ECMAScript for XML 
    * (E4X) specification (ECMA-357 edition 2).
	* 
	* <p>Use the <code>toXMLString()</code> method to return a string representation of the XML object
	* regardless of whether the XML object has simple content or complex content.</p>
	*
	* <p><b>Note</b>: The XML class (along with related classes) from ActionScript 2.0 has been
 	* renamed XMLDocument and moved into the flash.xml package. 
	* It is included in ActionScript 3.0 for backward compatibility.</p> 
	*
	* 
    * @includeExample examples\XMLExample.as -noswf
 	* 
	* @see Namespace
	* @see QName
	* @see XMLList
	* @see XML#toXMLString()
	* @see http://www.ecma-international.org/publications/standards/Ecma-357.htm ECMAScript for XML 
    * (E4X) specification (ECMA-357 edition 2)
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML
*/
public final dynamic class XML extends Object
{

     /**
      * The default number of arguments for the constructor. You can specify 1 or no arguments. For details, see the <code>XML()</code> constructor function.
      * @playerversion Flash 9
      * @langversion 3.0 
      * @see #XML()
      */
    public static const length:int = 1; 
	
	/** 
	* Creates a new XML object. You must use the constructor to create an 
	* XML object before you call any of the methods of the XML class. 
	*
	* <p>Use the <code>toXMLString()</code> method to return a string representation of the XML object
	* regardless of whether the XML object has simple content or complex content.</p>
	* 
	* @param value Any object that can be converted to XML with the top-level 
	* <code>XML()</code> function.
	* 
	* @see package.html#XML() top-level XML() function
	* @see XML#toXMLString()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML
	**/
	public native function XML(value:Object);
	
	/**
	* Adds a namespace to the set of in-scope namespaces for the XML object. If the namespace already 
	* exists in the in-scope namespaces for the XML object (with a prefix matching that of the given 
	* parameter), then the prefix of the existing namespace is set to <code>undefined</code>. If the input parameter 
	* is a Namespace object, it&#039;s used directly. If it&#039;s a QName object, the input parameter's
	* URI is used to create a new namespace; otherwise, it&#039;s converted to a String and a namespace is created from 
	* the String.
	*
	* @param ns The namespace to add to the XML object.
	*
	* @return The new XML object, with the namespace added.
	*
	* @includeExample examples\XML.addNamespace.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.addNamespace, addNamespace
	**/
	public native function addNamespace (ns:Object):XML;
	
	/**
	* Appends the given child to the end of the XML object's properties.
	* The <code>appendChild()</code> method takes an XML object, an XMLList object, or 
	* any other data type that is then converted to a String.
	* 
	* @return The resulting XML object.
	*
	* @param child The XML object to append.
	* 
	* @oldexample Consider the following:
	*
	* <listing version="3.0">var grp = &lt;orchestra>
	*	&lt;musician id="0" >&lt;name>George&lt;/name>&lt;instrument>cello&lt;/instrument>&lt;/musician>
	*	&lt;musician id="1" >&lt;name>Sam&lt;/name>&lt;/musician>
	* &lt;/orchestra>;
	* </listing>
	* 
	* <p> Add a new instrument element to the end of musician element for Sam:
	* <listing version="3.0">grp.musician.(name == "George").appendChild(&lt;instrument>cello&lt;/instrument>);</listing>
	* Here is the resulting XML, which the method returns:
	* <listing version="3.0">var grp = &lt;orchestra>
	*	&lt;musician id="0" >&lt;name>George&lt;/name>&lt;instrument>cello&lt;/instrument>&lt;/musician>
	*	&lt;musician id="1" >&lt;&lt;name>Sam&lt;/name>&lt;instrument>cello&lt;/instrument>&lt;/musician>
	* &lt;/orchestra>;
	* </listing>
	* </p>
	*
	* @includeExample examples\XML.appendChild.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.appendChild, appendChild
	**/
	public native function appendChild ( child:Object ):XML;

	/**
	* Returns the XML value of the attribute that has the name matching the <code>attributeName</code>
	* parameter. Attributes are found within XML elements. 
	* In the following example, the element has an attribute named "<code>gender</code>" 
	* with the value "<code>boy</code>": <code>&lt;first gender="boy"&gt;John&lt;/first&gt;</code>.
	* 
	* <p>The <code>attributeName</code> parameter can be any data type; however, 
	* String is the most common data type to use. When passing any object other than a QName object, 
	* the <code>attributeName</code> parameter uses the <code>toString()</code> method
	* to convert the parameter to a string. </p>
	* 
	* <p>If you need a qualified name reference, you can pass in a QName object. A QName object
	* defines a namespace and the local name, which you can use to define the qualified name of an 
	* attribute. Therefore calling <code>attribute(qname)</code> is not the same as calling
	* <code>attribute(qname.toString())</code>.</p>
	* 
	* @includeExample examples\XMLAttributeExample1.as -noswf   
	* @includeExample examples\XMLAttributeExample2.as -noswf
	* 
	* @param attributeName The name of the attribute.
	*
	* @return An XMLList object or an empty XMLList object. Returns an empty XMLList object
	* when an attribute value has not been defined.
	*
	* @see XML#attributes()
	* @see QName
	* @see Namespace
	* @see XML#elements()
	* @see operators.html#attribute_identifier attribute identifier (&#064;) operator
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.attribute, attribute
	**/
	public native function attribute (attributeName:*):XMLList;
	
	/**
	* Returns a list of attribute values for the given XML object. Use the <code>name()</code> 
	* method with the <code>attributes()</code> method to return the name of an attribute.
	* Use <code>&#064;~~</code> to return the names of all attributes.
	* 
	* @return The list of attribute values.
	* 
	* @includeExample examples\XMLAttributesExample1.as -noswf   
	* @includeExample examples\XMLAttributesExample2.as -noswf	
	* 
	* @see XML#attribute()
	* @see XML#name()
	* @see operators.html#attribute_identifier &#064; operator
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.attributes, attributes
	**/
	public native function attributes():XMLList;
	
	/**
	* Lists the children of an XML object. An XML child is an XML element, text node, comment, 
	* or processing instruction. 
	* 
	* <p>Use the <code>propertyName</code> parameter to list the 
	* contents of a specific XML child. For example, to return the contents of a child named 
	* <code>&lt;first&gt;</code>, use <code>child.name("first")</code>. You can generate the same result 
	* by using the child's index number. The index number identifies the child's position in the 
	* list of other XML children. For example, <code>name.child(0)</code> returns the first child 
	* in a list. </p>
	* 
	* <p>Use an asterisk (~~) to output all the children in an XML document. 
	* For example, <code>doc.child("~~")</code>.</p>  
	* 
	* <p>Use the <code>length()</code> method with the asterisk (~~) parameter of the 
	* <code>child()</code> method to output the total number of children. For example, 
	* <code>numChildren = doc.child("~~").length()</code>.</p>
	* 
	* @param propertyName The element name or integer of the XML child. 
	* 
	* @return An XMLList object of child nodes that match the input parameter. 
	* 
	* @includeExample examples\XML.child.1.as -noswf   
	* 
	* @see XML#elements()
	* @see XMLList XMLList class
	* @see XML#length()
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.child, child
	**/
	public native function child(propertyName:Object):XMLList;
	
	/**
	* Identifies the zero-indexed position of this XML object within the context of its parent.
	*
	* @return The position of the object. Returns -1 as well as positive integers.
	*
	* @includeExample examples\XML.childIndex.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.childindex, childindex
	**/
	public native function childIndex():int;
	
	/**
	* Lists the children of the XML object in the sequence in which they appear. An XML child 
	* is an XML element, text node, comment, or processing instruction. 
	*
	* @return An XMLList object of the XML object's children.
	*
	* @includeExample examples\XML.children.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.children, children
	**/
	public native function children():XMLList;
	
	/**
	* Lists the properties of the XML object that contain XML comments.
	*
	* @return An XMLList object of the properties that contain comments.
	*
	* @includeExample examples\XML.comments.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.comments, comments
	**/
	public native function comments():XMLList;
	
	/**
	* Compares the XML object against the given <code>value</code> parameter. 
	*
	* @param value A value to compare against the current XML object.
	*
	* @return If the XML object matches the <code>value</code> parameter, then <code>true</code>; otherwise <code>false</code>.
	*
	* @includeExample examples\XML.contains.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.contains, contains
	**/
	public native function contains (value:XML):Boolean;
	
	/**
	* Returns a copy of the given XML object. The copy is a duplicate of the entire tree of nodes. 
	* The copied XML object has no parent and returns <code>null</code> if you attempt to call the 
	* <code>parent()</code> method.
    *
	* @return The copy of the object.
	*
	* @includeExample examples\XML.copy.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.copy, copy
	**/
	public native function copy():XML;
	
	/**
	* Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the 
	* XML object that have the given <code>name</code> parameter. The <code>name</code> parameter
	* is optional. The <code>name</code> parameter can be a QName object, a String data type
	* or any other data type that is then converted to a String data type.
	* 
	* <p>To return all descendants, use the "~~" parameter. If no parameter is passed,
	* the string "~~" is passed and returns all descendants of the XML object.</p>
	* 
	* @param name The name of the element to match.
	*
	* @return An XMLList object of matching descendants. If there are no descendants, returns an 
	* empty XMLList object.
	* 
	* @includeExample examples\XMLDescendantsExample1.as -noswf  
	* 
	* @see operators.html#descendant_accessor descendant accessor (..) operator
	* 
	* @includeExample examples\XML.descendants.1.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.descendants, descendants
	**/
	public native function descendants (name:Object="*"):XMLList;
	
	/**
	* Returns an object with the following properties set to the default values: <code>ignoreComments</code>, 
	* <code>ignoreProcessingInstructions</code>, <code>ignoreWhitespace</code>, <code>prettyIndent</code>, and 
	* <code>prettyPrinting</code>. The default values are as follows:
	*
	* <ul>
	*    <li><code>ignoreComments = true</code></li>
	*    <li><code>ignoreProcessingInstructions = true</code></li>
	*    <li><code>ignoreWhitespace = true</code></li>
	*	 <li><code>prettyIndent = 2</code></li>
	*    <li><code>prettyPrinting = true</code></li>
	* </ul>
	*
	* <p><b>Note:</b> You do not apply this method to an instance of the XML class; you apply it to 
	* <code>XML</code>, as in the following code: <code>var df:Object = XML.defaultSettings()</code>. </p>
	*
	* @return An object with properties set to the default settings.
	*
	* @includeExample examples\XML.defaultSettings.1.as -noswf   
	* 
	* @see XML#ignoreComments
	* @see XML#ignoreProcessingInstructions
	* @see XML#ignoreWhitespace
	* @see XML#prettyIndent
	* @see XML#prettyPrinting
	* @see XML#setSettings()
	* @see XML#settings()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.defaultSettings, defaultSettings
	**/
	public native static function defaultSettings ():Object;
	
	/**
	 * Lists the elements of an XML object. An element consists of a start and an end tag; 
	 * for example <code>&lt;first&gt;&lt;/first&gt;</code>. The <code>name</code> parameter 
	 * is optional. The <code>name</code> parameter can be a QName object, a String data type,
	 * or any other data type that is then converted to a String data type. Use the <code>name</code> parameter to list a specific element. For example, 
	 * the element "<code>first</code>" returns "<code>John</code>" in this example: 
	 * <code>&lt;first&gt;John&lt;/first&gt;</code>. 
	 * 
	 * <p>To list all elements, use the asterisk (~~) as the 
	 * parameter. The asterisk is also the default parameter. </p>
	 * 
	 * <p>Use the <code>length()</code> method with the asterisk parameter to output the total 
	 * number of elements. For example, <code>numElement = addressbook.elements("~~").length()</code>.</p>
	 * 
	 * @param name The name of the element. An element's name is surrounded by angle brackets. 
	 * For example, "<code>first</code>" is the <code>name</code> in this example: 
	 * <code>&lt;first&gt;&lt;/first&gt;</code>. 
	 * 
	 * @return An XMLList object of the element's content. The element's content falls between the start and 
	 * end tags. If you use the asterisk (~~) to call all elements, both the 
	 * element's tags and content are returned.
	 * 
	 * @includeExample examples\XML.elements.1.as -noswf  	 
	 * 
	 * @includeExample examples\XMLElementsExample1.as -noswf  	 
	 * 
	 * @see XML#child()
	 * @see XMLList XMLList class
	 * @see XML#length()
	 * @see XML#attribute()
	 * @see operators.html#dot_(XML) XML dot (.) operator
	 *
	 * @playerversion Flash 9
	 * @langversion 3.0
	 * @helpid
	 * @refpath 
	 * @keyword XML, XML.elements, elements
	 **/
	public native function elements ( name:Object="*" ):XMLList;
	
	/**
	* Checks to see whether the object has the property specified by the <code>p</code> parameter. 
	*
	* @param p The property to match.
	*
	* @return If the property exists, <code>true</code>; otherwise <code>false</code>.
	*
	* @includeExample examples\XML.hasOwnProperty.1.as -noswf   
	* 
	* @includeExample examples\XML.hasOwnProperty.2.as -noswf   
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.hasOwnProperty, hasOwnProperty
	**/
	public native function hasOwnProperty ( p:String ):Boolean;
	
	/**
	* Checks to see whether the XML object contains complex content. An XML object contains complex content if  
	* it has child elements. XML objects that representing attributes, comments, processing instructions, 
	* and text nodes do not have complex content. However, an object that <i>contains</i> these can 
	* still be considered to contain complex content (if the object has child elements).
	*
	* @return If the XML object contains complex content, <code>true</code>; otherwise <code>false</code>.
	*
	* @includeExample examples\XML.hasComplexContent.1.as -noswf  	 
	* 
	* @see XML#hasSimpleContent()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.hasComplexContent, hasComplexContent
	**/
	public native function hasComplexContent( ):Boolean;
	
	/**
	* Checks to see whether the XML object contains simple content. An XML object contains simple content 
	* if it represents a text node, an attribute node, or an XML element that has no child elements. 
	* XML objects that represent comments and processing instructions do <i>not</i> contain simple 
	* content.
	*
	* @return If the XML object contains simple content, <code>true</code>; otherwise <code>false</code>.
	*
	 * @includeExample examples\XML.hasComplexContent.1.as -noswf  	 
	 * 
	* @see XML#hasComplexContent()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.hasSimpleContent, hasSimpleContent
	**/
	public native function hasSimpleContent( ):Boolean;
	
	/**
	* Lists the namespaces for the XML object, based on the object's parent. 
	*
	* @return An array of Namespace objects. 
	*
	* @includeExample examples\XML.inScopeNamespaces.1.as -noswf  	 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.inScopeNamespaces, inScopeNamespaces
	**/
	public native function inScopeNamespaces( ):Array;
	
	/**
	* Inserts the given <code>child2</code> parameter after the <code>child1</code> parameter in this XML object and returns the 
	* resulting object. If the <code>child1</code> parameter is <code>null</code>, the method
	* inserts the contents of <code>child2</code> <i>before</i> all children of the XML object 
	* (in other words, after <i>none</i>). If <code>child1</code> is provided, but it does not 
	* exist in the XML object, the XML object is not modified and <code>undefined</code> is 
	* returned.
	* 
	* <p>If you call this method on an XML child that is not an element (text, attributes, comments, pi, and so on) 
	* <code>undefined</code> is returned.</p>
	*
	* @param child1 The object in the source object that you insert before <code>child2</code>.
	* @param child2 The object to insert.
	*
	* @return The resulting XML object or <code>undefined</code>.
	*
	* @includeExample examples\XML.insertChildAfter.1.as -noswf  	 
	* 
	* @see XML#insertChildBefore()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.insertChildAfter, insertChildAfter
	**/
	public native function insertChildAfter ( child1:Object , child2:Object):*;
	
	/**
	* Inserts the given <code>child2</code> parameter before the <code>child1</code> parameter 
	* in this XML object and returns the resulting object. If the <code>child1</code> parameter 
	* is <code>null</code>, the method inserts the contents of    
	* <code>child2</code> <i>after</i> all children of the XML object (in other words, before 
	* <i>none</i>). If <code>child1</code> is provided, but it does not exist in the XML object, 
	* the XML object is not modified and <code>undefined</code> is returned.
	* 
	* <p>If you call this method on an XML child that is not an element (text, attributes, 
	* comments, pi, and so on) <code>undefined</code> is returned.</p>
	*
	* @param child1 The object in the source object that you insert after <code>child2</code>.
	* @param child2 The object to insert.
	*
	* @return The resulting XML object or <code>undefined</code>.
	* 
	* @includeExample examples\XML.insertChildBefore.1.as -noswf  	 
	* 
	* @see XML#insertChildAfter()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.insertChildBefore, insertChildBefore
	**/
	public native function insertChildBefore ( child1:Object , child2:Object):*;
	
	/**
	* For XML objects, this method always returns the integer <code>1</code>. 
	* The <code>length()</code> method of the XMLList class returns a value of <code>1</code> for 
	* an XMLList object that contains only one value.
	*
	* @return Always returns <code>1</code> for any XML object.
	*
	* @includeExample examples\XML.length.1.as -noswf  	 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.length, length
	**/
	public native function length ( ):int;
	
	/**
	* Gives the local name portion of the qualified name of the XML object.
	*
	* @return The local name as either a String or <code>null</code>.
	*
	* @includeExample examples\XML.localName.1.as -noswf  	 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.localName, localName
	**/
	public native function localName ( ):Object;
	
	/**
	* Gives the qualified name for the XML object. 
	*
	* @return The qualified name is either a QName or <code>null</code>.
	* 
	* @includeExample examples\XML.name.1.as -noswf  	 
	* 
	* @includeExample examples\XML.name.2.as -noswf  	 
	* 
	* @see XML#attributes()
	* @see operators.html#attribute_identifier
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.name, name
	**/
	public native function name ( ):Object;
	
	/**
	* If no parameter is provided, gives the namespace associated with the qualified name of 
	* this XML object. If a <code>prefix</code> parameter is specified, the method returns the namespace 
	* that matches the <code>prefix</code> parameter and that is in scope for the XML object. If there is no 
	* such namespace, the method returns <code>undefined</code>.
	*
	* @param prefix The prefix you want to match.
	*
	* @return Returns <code>null</code>, <code>undefined</code>, or a namespace.
	*
	* @includeExample examples\XML.namespace.1.as -noswf  	 
	* 
	* @includeExample examples\XML.namespace.2.as -noswf  	 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.namespace, namespace
	**/
	public native function namespace ( prefix:String = null ):*;
	
	/**
	* Lists namespace declarations associated with the XML object in the context of its parent. 
	*
	* @return An array of Namespace objects.
	*
	* @includeExample examples\XML.namespaceDeclarations.1.as -noswf  	 
	* 
	* @see XML#namespace()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.namespaceDeclarations, namespaceDeclarations
	**/
	public native function namespaceDeclarations ( ): Array;
	
	/**
	* Specifies the type of node: text, comment, processing-instruction,  
	* attribute, or element. 
	* 
	* @return The node type used.
	*
	* @includeExample examples\XMLNodeKindExample1.as -noswf 
	* 
	* @see Operators.html#attribute_identifier
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.nodeKind, nodeKind
	**/
	public native function nodeKind ( ):String;
	
	/**
	* For the XML object and all descendant XML objects, merges adjacent text nodes and 
	* eliminates empty text nodes.
	*
	* @return The resulting normalized XML object.
	*
	* @includeExample examples\XML.normalize.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.normalize, normalize
	**/
	public native function normalize ( ):XML;
	
	/**
	* Returns the parent of the XML object. If the XML object has no parent, the method returns 
	* <code>undefined</code>.
	*
	* @return The parent XML object. Returns either a <code>String</code> or <code>undefined</code>.
	*
	* @includeExample examples\XML.parent.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.parent, parent
	**/
	public native function parent ( ):*;
	
	/**
	* If a <code>name</code> parameter is provided, lists all the children of the XML object 
	* that contain processing instructions with that <code>name</code>. With no parameters, the method 
	* lists all the children of the XML object that contain any processing instructions.
	*
	* @param name The name of the processing instructions to match.
	*
	* @return A list of matching child objects.
	*
	* @includeExample examples\XML.processingInstructions.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.processingInstructions, processingInstructions
	**/
	public native function processingInstructions ( name:String = "*" ):XMLList;
	
	/**
	* Inserts a copy of the provided <code>child</code> object into the XML element before any existing XML 
	* properties for that element.
	*
	* @param value The object to insert.
	*
	* @return The resulting XML object.
	*
	* @includeExample examples\XML.prependChild.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.prependChild, prependChild
	**/
	public native function prependChild ( value:Object ):XML;
	
	/**
	* Checks whether the property <code>p</code> is in the set of properties that can be iterated in a 
	* <code>for..in</code> statement applied to the XML object. Returns <code>true</code> only 
	* if <code>toString(p) == "0"</code>. 
	*
	* @param p The property that you want to check.
	*
	* @return  If the property can be iterated in a <code>for..in</code> statement, <code>true</code>; 
	* otherwise, <code>false</code>.
	*
	* @includeExample examples\XML.propertyIsEnumerable.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.propertyIsEnumerable, propertyIsEnumerable
	**/
	public native function propertyIsEnumerable ( p:String ):Boolean;
	
	/**
	* Removes the given namespace for this object and all descendants. The <code>removeNamespaces()</code> 
	* method does not remove a namespace if it is referenced by the object's qualified name or the 
	* qualified name of the object's attributes.
	*
	* @param ns The namespace to remove.
	*
	* @return A copy of the resulting XML object.
	*
	* @includeExample examples\XML.removeNamespace.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.removeNamespace, removeNamespace
	**/
	public native function removeNamespace ( ns:Namespace ):XML;
	
	/**
	* Replaces the properties specified by the <code>propertyName</code> parameter 
	* with the given <code>value</code> parameter. 
	* If no properties match <code>propertyName</code>, the XML object is left unmodified.
	* 
	* @param propertyName Can be a 
	* numeric value, an unqualified name for a set of XML elements, a qualified name for a set of 
	* XML elements, or the asterisk wildcard ("&#42;"). 
	* Use an unqualified name to identify XML elements in the default namespace. 
	* 
	* @param value The replacement value. This can be an XML object, an XMLList object, or any value 
	* that can be converted with <code>toString()</code>. 
	*
	* @return  The resulting XML object, with the matching properties replaced.
	*
	* @includeExample examples\XML.replace.1.as -noswf 
	* 
	* @includeExample examples\XML.replace.2.as -noswf 
	* 
	* @includeExample examples\XML.replace.3.as -noswf 
	* 
	* @includeExample examples\XML.replace.4.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.replace, replace
	**/
	public native function replace ( propertyName:Object , value:XML ):XML
	
	/**
	* Replaces the child properties of the XML object with the specified set of XML properties, 
	* provided in the <code>value</code> parameter.
	*
	* @param value The replacement XML properties. Can be a single XML object or an XMLList object. 
	*
	* @return The resulting XML object. 
	*
	* @includeExample examples\XML.setChildren.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.setChildren, setChildren
	**/
	public native function setChildren ( value:Object ):XML;
	
	/**
	* Changes the local name of the XML object to the given <code>name</code> parameter. 
	*
	* @param name The replacement name for the local name.
	*
	* @includeExample examples\XML.setLocalName.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.setLocalName, setLocalName
	**/
	public native function setLocalName ( name:String ):void;
	
	/**
	* Sets the name of the XML object to the given qualified name or attribute name. 
	*
	* @param name The new name for the object.
	*
	* @includeExample examples\XML.setName.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.setName, setName
	**/
	public native function setName ( name:String ):void;
	
	/**
	* Sets the namespace associated with the XML object.
	*
	* @param ns The new namespace.
	*
	* @includeExample examples\XML.setNamespace.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.setNamespace, setNamespace
	**/
	public native function setNamespace ( ns:Namespace ):void;
	
	/**
	* Sets values for the following XML properties: <code>ignoreComments</code>, 
	* <code>ignoreProcessingInstructions</code>, <code>ignoreWhitespace</code>,
	* <code>prettyIndent</code>, and <code>prettyPrinting</code>.
	*	
	* The following are the default settings, which are applied if no <code>setObj</code> parameter
	* is provided:
	*
	* <ul>
	*    <li><code>XML.ignoreComments = true</code></li>
	*    <li><code>XML.ignoreProcessingInstructions = true</code></li>
	*    <li><code>XML.ignoreWhitespace = true</code></li>
	*    <li><code>XML.prettyIndent = 2</code></li>
	*    <li><code>XML.prettyPrinting = true</code></li>
	* </ul>
	*
	* <p><b>Note</b>: You do not apply this method to an instance of the XML class; you apply it to 
	* <code>XML</code>, as in the following code: <code>XML.setSettings()</code>.</p>
	*
	* @param rest An object with each of the following properties: 
	* 
	* <ul>
	*    <li><code>ignoreComments</code></li>
	*    <li><code>ignoreProcessingInstructions</code></li>
	*    <li><code>ignoreWhitespace</code></li>
	*    <li><code>prettyIndent</code></li>
	*    <li><code>prettyPrinting</code></li>
	* </ul>
	*
	* @includeExample examples\XML.defaultSettings.1.as -noswf   
	* 
	* @see #ignoreComments
	* @see #ignoreProcessingInstructions
	* @see #ignoreWhitespace
	* @see #prettyIndent
	* @see #prettyPrinting
	* @see #defaultSettings()
	* @see #settings()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.setSettings, setSettings
	**/
	public native static function setSettings (... rest):void;
	
	/**
	* Retrieves the following properties: <code>ignoreComments</code>, 
	* <code>ignoreProcessingInstructions</code>, <code>ignoreWhitespace</code>, 
	* <code>prettyIndent</code>, and <code>prettyPrinting</code>.
	*
	* @return An object with the following XML properties:
	* <ul>
	*    <li><code>ignoreComments</code></li>
	*    <li><code>ignoreProcessingInstructions</code></li>
	*    <li><code>ignoreWhitespace</code></li>
	*    <li><code>prettyIndent</code></li>
	*    <li><code>prettyPrinting</code></li>
	* </ul>
	*
	* @includeExample examples\XML.defaultSettings.1.as -noswf   
	* 
	* @see XML#ignoreComments
	* @see XML#ignoreProcessingInstructions
	* @see XML#ignoreWhitespace
	* @see XML#prettyIndent
	* @see XML#prettyPrinting
	* @see XML#defaultSettings()
	* @see XML#setSettings()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.settings, settings
	**/
	public native static function settings ():Object;
	
	/**
	* Returns an XMLList object of all XML properties of the XML object that represent XML text nodes.
	* 
	* @return The list of properties.
	*
	* @includeExample examples\XML.text.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.text, text
	**/
	public native function text ( ):XMLList;
	
	/**
	* Returns a string representation of the XML object. The rules for this conversion depend on whether  
	* the XML object has simple content or complex content:
	*
	* <ul>
	* 	<li>If the XML object has simple content, <code>toString()</code> returns the String contents of the 
	* XML object with  the following stripped out: the start tag, attributes, namespace declarations, and 
	* end tag.</li> 
	* </ul>
	* 
	* <ul>
	* 	<li> If the XML object has complex content, <code>toString()</code> returns an XML encoded String 
	* representing the entire XML object, including the start tag, attributes, namespace declarations, 
	* and end tag.</li>
	* </ul>
	* 
	* <p>To return the entire XML object every time, use <code>toXMLString()</code>.</p>
	*
	*
	* @return The string representation of the XML object.
	*
	* @includeExample examples\XMLToStringExample1.as -noswf 
	* @includeExample examples\XMLToStringExample2.as -noswf 
	* 
	* @see XML#hasSimpleContent()
	* @see XML#hasComplexContent()
	* @see XML#toXMLString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.toString, toString 
	*
	**/
	public native function toString():String;
	
	/**
	* Returns a string representation of the XML object. Unlike the <code>toString()</code> method,
	* the <code>toXMLString()</code> method always returns the start tag, attributes,
	* and end tag of the XML object, regardless of whether the XML object has simple content or complex 
	* content. (The <code>toString()</code> method strips out these items for XML objects that contain 
	* simple content.)
	*	
	* @oldexample The following XML object has simple content:
	* 
	* <listing version="3.0">	&lt;item>wiper blade&lt/item></listing>
	*
	* <p>The <code>toString()</code> method for this object returns the following String:
	* <listing version="3.0">	&lt;item>wiper blade&lt/item></listing>
	* </p>
	*
	* <p>
	* The following XML object has complex content:
	* <listing version="3.0">
	* 	&lt;student>
	* 		&lt;first-name>Bob&lt;/first-name>
	* 		&lt;last-name>Roberts&lt;/last-name>
	* 	&lt;/student>
	* </listing>
	* </p>
	*
	* <p>
	* The <code>toString()</code> method for this object returns the following String:
	* <listing version="3.0">	&lt;student>&lt;first-name>Bob&lt;/first-name>&lt;last-name>Roberts&lt;/last-name>&lt;/student></listing>
	* </p>
	*
	* <p>
	* <b>Note</b>: The white space formatting of the returned String depends on the setting of the 
	* <code>prettyPrinting</code>property of the XML class. In this example, <code>prettyPrinting</code> 
	* is set to <code>false</code>.
	* </p>
	*
	* @return The string representation of the XML object.
	* 
	* @includeExample examples\XML.toXMLString.1.as -noswf 
	* 
	* @see XML#toString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.toXMLString, toXMLString
	**/
	public native function toXMLString ( ):String;
	
	/**
	* Returns the XML object. 
	*
	* @return Returns the primitive value of an XML instance.
	*
	* @includeExample examples\XML.valueOf.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.valueOf, valueOf
	**/
	public native function valueOf ( ):XML;

	

	/**
	* Determines whether XML comments are ignored 
	* when XML objects parse the source XML data. By default, the comments are ignored 
	* (<code>true</code>). To include XML comments, set this property to <code>false</code>. 
	* The <code>ignoreComments</code> property is used only during the XML parsing, not during 
	* the call to any method such as <code>myXMLObject.child(~~).toXMLString()</code>. 
	* If the source XML includes comment nodes, they are kept or discarded during the XML parsing. 
	*
	* @includeExample examples\XML.ignoreComments.1.as -noswf 
	* 
	* @see XML#child()
	* @see XML#toXMLString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.ignoreComments, ignoreComments
	**/
	public native static function get ignoreComments():Boolean;
	public native static function set ignoreComments(newIgnore:Boolean):void;
	
   /**
	* Determines whether XML 
	* processing instructions are ignored when XML objects parse the source XML data. 
	* By default, the processing instructions are ignored (<code>true</code>). To include XML 
	* processing instructions, set this property to <code>false</code>. The 
	* <code>ignoreProcessingInstructions</code> property is used only during the XML parsing, 
	* not during the call to any method such as <code>myXMLObject.child(~~).toXMLString()</code>.
	* If the source XML includes processing instructions nodes, they are kept or discarded during 
	* the XML parsing.
	*
	* @includeExample examples\XML.ignoreProcessingInstructions.1.as -noswf 
	* 
	* @see XML#child()
	* @see XML#toXMLString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.ignoreProcessingInstructions, ignoreProcessingInstructions
	**/
	public native static function get ignoreProcessingInstructions():Boolean;
	public native static function set ignoreProcessingInstructions(newIgnore:Boolean):void;
	
	/**
	* Determines whether white space characters
	* at the beginning and end of text nodes are ignored during parsing. By default, 
	* white space is ignored (<code>true</code>). If a text node is 100% white space and the 
	* <code>ignoreWhitespace</code> property is set to <code>true</code>, then the node is not created.  
	* To show white space in a text node, set the <code>ignoreWhitespace</code> property to 
	* <code>false</code>. 
	*
	* @includeExample examples\XML.ignoreWhitespace.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.ignoreWhitespace, ignoreWhitespace
	**/
	public native static function get ignoreWhitespace():Boolean;
	public native static function set ignoreWhitespace(newIgnore:Boolean):void;

	/**
	* Determines whether the <code>toString()</code> 
	* and <code>toXMLString()</code> methods normalize white space characters between some tags. 
	* The default value is <code>true</code>.
	*
	* @includeExample examples\XML.prettyPrinting.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @see #prettyIndent
	* @see #toString()
	* @see #toXMLString()
	* @keyword XML, XML.prettyPrinting, prettyPrinting
	**/
	public native static function get prettyPrinting():Boolean;
	public native static function set prettyPrinting(newPretty:Boolean):void;
	
	/**
	* Determines the amount of indentation applied by 
	* the <code>toString()</code> and <code>toXMLString()</code> methods when 
	* the <code>XML.prettyPrinting</code> property is set to <code>true</code>. 
	* Indentation is applied with the space character, not the tab character.
	* 
	* The default value is <code>2</code>.
	*
	* @includeExample examples\XML.prettyIndent.1.as -noswf 
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @see #prettyPrinting
	* @see #toString()
	* @see #toXMLString()
	* @keyword XML, XML.prettyIndent, prettyIndent
	**/
	public native static function get prettyIndent():int;
	public native static function set prettyIndent(newIndent:int):void;
}
}
package {
//
// XMLList
//
// Based on the ECMA E4X Specification, 1st Edition.

/**
 * An XMLList object is an ordered collection of properties. An XMLList object represents an 
 * XML document, an XML fragment, or an arbitrary collection of XML objects. 
 *
 * <p>An XMLList object with one XML element is treated the same as an XML object. 
 * When there is one XML element, all methods that are available 
 * for the XML object are also available for the XMLList object.</p>
 * 
 * <p>In the following example, <code>example.two</code> is an XMLList object of length 1,
 * so you can call any XML method on it. </p>
 * 
 <listing version="3.0">
 var example2 = &lt;example&gt;&lt;two&gt;2&lt;/two&gt;&lt;/example&gt;;
 </listing>
 * 
 * <p>The following table lists the XML methods that are not included in the XMLList class, but 
 * that you can use when your XMLList object has only one XML element. If you attempt to use these 
 * methods with anything other than one XML element (zero or more than one
 * element), an exception is thrown.</p>
 * 
 * <table class="innertable">
 * <tr><th>XML methods</th></tr>
 * <tr><td><code>addNamespace()</code></td></tr>
 * <tr><td><code>appendChild()</code></td></tr>
 * <tr><td><code>childIndex()</code></td></tr>
 * <tr><td><code>inScopeNamespace()</code></td></tr>
 * <tr><td><code>insertChildAFter()</code></td></tr>
 * <tr><td><code>insertChildBefore()</code></td></tr>
 * <tr><td><code>name()</code></td></tr>
 * <tr><td><code>namespace()</code></td></tr>
 * <tr><td><code>localName()</code></td></tr>
 * <tr><td><code>namespaceDeclarations()</code></td></tr>
 * <tr><td><code>nodeKind()</code></td></tr>
 * <tr><td><code>prependChild()</code></td></tr>
 * <tr><td><code>removeNamespace()</code></td></tr>
 * <tr><td><code>replace()</code></td></tr>
 * <tr><td><code>setChildren()</code></td></tr>
 * <tr><td><code>setLocalName()</code></td></tr>
 * <tr><td><code>setName()</code></td></tr>
 * <tr><td><code>setNamespace()</code></td></tr>
 * </table>
 * 
 * <p>This class (along with the XML, Namespace, and QName classes) implements powerful XML-handling 
 * standards defined in ECMAScript for XML (E4X) specification (ECMA-357 edition 2).</p>
 * 
 * @includeExample examples\XMLListExample.as -noswf
 *
 * @playerversion Flash 9
 * @langversion 3.0
 * @helpid
 * @refpath 
 * @keyword XMLList
 * @see XML
 * @see Namespace
 * @see QName
 */
 
public final dynamic class XMLList
{
	/**
	* Creates a new XMLList object.
	*
	* @param value Any object that can be converted to an XMLList object by using the top-level <code>XMLList()</code> function.
	*
	* @return If no arguments are included, the constructor returns an empty XMLList. If an XMLList object is included as 
	* the parameter, the constructor returns a shallow copy of the XMLList object. If the parameter is an object of a type 
	* other than XMLList, the constructor converts the object to an XMLList object and returns that object.
	*
	* @see global#XMLList() top-level XMLList() function
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList 
	**/
	public native function XMLList (value:Object);

	/**
	* Calls the <code>attribute()</code> method of each XML object and returns an XMLList object 
	* of the results. The results match the given <code>attributeName</code> parameter. If there is no 
	* match, the <code>attribute()</code> method returns an empty XMLList object.
	* 
	* @param attributeName The name of the attribute that you want to include in an XMLList object.
	*
	* @return An XMLList object of matching XML objects or an empty XMLList object.
	*
	* @see XML#attribute()
	* @see XML#attributes()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.attribute, attribute
	**/
	public native function attribute (attributeName:* ):XMLList;
	
	/**
	* Calls the <code>attributes()</code> method of each XML object and 
	* returns an XMLList object of attributes for each XML object. 
	*
	* @return An XMLList object of attributes for each XML object.
	*
	* @see XML#attribute()
	* @see XML#attributes()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.attributes, attributes
	**/
	public native function attributes ( ):XMLList;
	
	/**
	* Calls the <code>child()</code> method of each XML object and returns an XMLList object that
	* contains the results in order.
	*
	* @param propertyName The element name or integer of the XML child.
	*
	* @return An XMLList object of child nodes that match the input parameter.
	*
	* @see XML#child()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.child, child
	**/
	public native function child ( propertyName:Object ):XMLList;
	
	/**
	* Calls the <code>children()</code> method of each XML object and 
	* returns an XMLList object that contains the results.
	*
	* @return An XMLList object of the children in the XML objects.
	*
	* @oldexample The following sets a variable to an XMLList of children of all the items in the catalog XMLList:
	* 
	* <p><code>var allitemchildren:XMLList = catalog.item.children();</code></p>

	* @oldexample The following sets a variable to an XMLList of all grandchildren of all the items in the catalog XMLList that 	
	* have the name <code>size</code>:
	* 
	* <p><code>var grandchildren:XMLList = catalog.item.children().size;</code></p>
	* 
	* @see XML#children()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.children, children
	**/
	public native function children ( ):XMLList;
	
	/**
	* Calls the <code>comments()</code> method of each XML object and returns 
	* an XMLList of comments.
	*
	* @return An XMLList of the comments in the XML objects.
	*
	* @see XML#comments()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.comments, comments
	**/
	public native function comments ( ):XMLList;
	
	/**
	* Checks whether the XMLList object contains an XML object that is equal to the given 
	* <code>value</code> parameter.
	*
	* @param value An XML object to compare against the current XMLList object. 
	*
	* @return If the XMLList contains the XML object declared in the <code>value</code> parameter, 
	* then <code>true</code>; otherwise <code>false</code>.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.contains, contains
	**/
	public native function contains ( value:XML ):Boolean;
	
	/**
	* Returns a copy of the given XMLList object. The copy is a duplicate of the entire tree of nodes.
	* The copied XML object has no parent and returns <code>null</code> if you attempt to call the <code>parent()</code> method.
	*
	* @return The copy of the XMLList object.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.copy, copy
	**/
	public native function copy ( ):XMLList;
	
	/**
	* Returns all descendants (children, grandchildren, great-grandchildren, and so on) of the XML object 
	* that have the given <code>name</code> parameter. The <code>name</code> parameter can be a 
	* QName object, a String data type, or any other data type that is then converted to a String
	* data type.
	* 
	* <p>To return all descendants, use
	* the asterisk (~~) parameter. If no parameter is passed,
	* the string "~~" is passed and returns all descendants of the XML object.</p>
	*
	* @return An XMLList object of the matching descendants (children, grandchildren, and so on) of the XML objects 
	* in the original list. If there are no descendants, returns an empty XMLList object.
	* 
	* @param name The name of the element to match.
	*
 	* @see XML#descendants()	
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.descendants, descendants
	**/
	public native function descendants (name:Object="*"):XMLList;
	
	/**
	* Calls the <code>elements()</code> method of each XML object. The <code>name</code> parameter is 
	* passed to the <code>descendants()</code> method. If no parameter is passed, the string "~~" is passed to the 
	* <code>descendants()</code> method.
	*
 	* @param name The name of the elements to match.
	*
	* @return An XMLList object of the matching child elements of the XML objects.
	*
	* @see XML#elements()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.elements, elements
	**/
	public native function elements (name:Object="*"):XMLList;
	
	/**
	* Checks for the property specified by <code>p</code>. 
	*
	* @param p The property to match.
	*
	* @return If the parameter exists, then <code>true</code>; otherwise <code>false</code>.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.hasOwnProperty, hasOwnProperty
	**/
	public native function hasOwnProperty(p:String):Boolean;
	
	/**
	* Checks whether the XMLList object contains complex content. An XMLList object is 
	* considered to contain complex content if it is not empty and either of the following conditions is true: 
	*
	* <ul>
	*   <li>The XMLList object contains a single XML item with complex content.</li>
	*   <li>The XMLList object contains elements.</li>
	* </ul>
	*
	* @return If the XMLList object contains complex content, then <code>true</code>; otherwise <code>false</code>.
	*
	* @see XML#hasComplexContent()
	* @see XML#hasSimpleContent()
	* @see #hasSimpleContent()
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.hasComplexContent, hasComplexContent
	**/
	public native function hasComplexContent( ):Boolean;
	
	/**
	* Checks whether the XMLList object contains simple content. An XMLList object is 
	* considered to contain simple content if one or more of the following 
	* conditions is true:
	* <ul>
	*   <li>The XMLList object is empty</li>
	*   <li>The XMLList object contains a single XML item with simple content</li>
	*   <li>The XMLList object contains no elements</li>
	* </ul>
	*
	* @return If the XMLList contains simple content, then <code>true</code>; otherwise <code>false</code>.
	*
	* @see XML#hasComplexContent()
	* @see XML#hasSimpleContent()
	* @see #hasComplexContent()
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.hasSimpleContent, hasSimpleContent
	**/
	public native function hasSimpleContent( ):Boolean;
	
	/**
	* Returns the number of properties in the XMLList object.
	*
	* @return The number of properties in the XMLList object. 
	*	
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.length, length
	**/
	public native function length ( ):int;
	
	/**
	* Merges adjacent text nodes and eliminates empty text nodes for each 
	* of the following: all text nodes in the XMLList, all the XML objects 
	* contained in the XMLList, and the descendants of all the XML objects in 
	* the XMLList. 
	*
	* @return The normalized XMLList object.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.normalize, normalize
	**/
	public native function normalize ( ):XMLList;
	
	/**
	* Returns the parent of the XMLList object if all items in the XMLList object have the same parent.
	* If the XMLList object has no parent or different parents, the method returns <code>undefined</code>.
	*
	* @return Returns the parent XML object.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.parent, parent
	**/
	public native function parent ( ):Object;
	
	/**
	* If a <code>name</code> parameter is provided, lists all the children of the XMLList object that 
	* contain processing instructions with that name. With no parameters, the method lists all the 
	* children of the XMLList object that contain any processing instructions.
	*
	* @param name The name of the processing instructions to match.
	*
	* @return An XMLList object that contains the processing instructions for each XML object.
	*
 	* @see XML#processingInstructions()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.processingInstructions, processingInstructions
	**/
	public native function processingInstructions ( name:String = "*"):XMLList;
	
	/**
	* Checks whether the property <code>p</code> is in the set of properties that can be iterated in a <code>for..in</code> statement 	
	* applied to the XMLList object. This is <code>true</code> only if <code>toNumber(p)</code> is greater than or equal to 0 
	* and less than the length of the XMLList object. 
	*
	* @param p The index of a property to check.
	*
	* @return If the property can be iterated in a <code>for..in</code> statement, then <code>true</code>; otherwise <code>false</code>.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.propertyIsEnumerable, propertyIsEnumerable
	**/
	public native function propertyIsEnumerable ( p:String ):Boolean;
	
	/**
	* Calls the <code>text()</code> method of each XML 
	* object and returns an XMLList object that contains the results.
	*
	* @return An XMLList object of all XML properties of the XMLList object that represent XML text nodes.
	*
 	* @see XML#text()
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.text, text
	**/
	public native function text ( ):XMLList;
	
	/**
	* Returns a string representation of all the XML objects in an XMLList object. The rules for 
	* this conversion depend on whether the XML object has simple content or complex content:
	*
	* <ul>
	* 	<li>If the XML object has simple content, <code>toString()</code> returns the string contents of the 
	* XML object with  the following stripped out: the start tag, attributes, namespace declarations, and 
	* end tag.</li> 
	* </ul>
	* 
	* <ul>
	* 	<li> If the XML object has complex content, <code>toString()</code> returns an XML encoded string 
	* representing the entire XML object, including the start tag, attributes, namespace declarations, 
	* and end tag.</li>
	* </ul>
	* 
	* <p>To return the entire XML object every time, use the <code>toXMLString()</code> method.</p>
	*
	*
	* @return The string representation of the XML object.
	*
	* @includeExample examples\XMLToStringExample1.as -noswf 
	* @includeExample examples\XMLToStringExample2.as -noswf 
	* 
	* @see XMLList#hasSimpleContent()
	* @see XMLList#hasComplexContent()
	* @see XMLList#toXMLString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.toString, toString 
	*
	**/
	public native function toString( ):String;
	
	/**
	* Returns a string representation of all the XML objects in an XMLList object. 
	* Unlike the <code>toString()</code> method, the <code>toXMLString()</code> 
	* method always returns the start tag, attributes,
	* and end tag of the XML object, regardless of whether the XML object has simple content 
	* or complex content. (The <code>toString()</code> method strips out these items for XML 
	* objects that contain simple content.)
	*
	*
	* @return The string representation of the XML object.
	* 
	* @see XMLList#toString()
	* 
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XML, XML.toXMLString, toXMLString
	**/
	public native function toXMLString( ):String;
	
	/**
	* Returns the XMLList object. 
	*
	* @return Returns the current XMLList object.
	*
	* @playerversion Flash 9
	* @langversion 3.0
	* @helpid
	* @refpath 
	* @keyword XMLList, XMLList.valueOf, valueOf
	**/
	public native function valueOf( ):XMLList;

}
}
