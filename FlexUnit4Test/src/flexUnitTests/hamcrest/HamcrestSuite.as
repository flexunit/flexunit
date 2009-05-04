/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/
 
/** This class executes the ported hamcrest-as3 test from Drew Bourne's project **/
package flexUnitTests.hamcrest
{
	import org.hamcrest.BaseMatcherTest;
	import org.hamcrest.CustomMatcherTest;
	import org.hamcrest.CustomTypeSafeMatcherTest;
	import org.hamcrest.collection.EveryTest;
	import org.hamcrest.collection.IsArrayContainingTest;
	import org.hamcrest.collection.IsArrayTest;
	import org.hamcrest.collection.IsArrayWithSizeTest;
	import org.hamcrest.core.AllOfTest;
	import org.hamcrest.core.AnyOfTest;
	import org.hamcrest.core.CombinableTest;
	import org.hamcrest.core.DescribedAsTest;
	import org.hamcrest.core.IsAnythingTest;
	import org.hamcrest.core.IsNotTest;
	import org.hamcrest.core.ThrowsTest;
	import org.hamcrest.number.BetweenTest;
	import org.hamcrest.number.CloseToTest;
	import org.hamcrest.number.GreaterThanTest;
	import org.hamcrest.number.LessThanTest;
	import org.hamcrest.object.HasPropertyTest;
	import org.hamcrest.object.HasPropertyWithValueTest;
	import org.hamcrest.object.IsEqualTest;
	import org.hamcrest.object.IsInstanceOfTest;
	import org.hamcrest.object.IsNullTest;
	import org.hamcrest.object.IsSameTest;
	import org.hamcrest.text.StringContainsTest;
	import org.hamcrest.text.StringEndsWithTest;
	import org.hamcrest.text.StringStartsWithTest;
	import org.hamcrest.MatcherAssertTest;
	import org.hamcrest.TypeSafeMatcherTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]

	public class HamcrestSuite
	{
		public var t1:BaseMatcherTest;
		public var t2:CustomMatcherTest;
		public var t3:CustomTypeSafeMatcherTest;
		public var t4:MatcherAssertTest;
		public var t5:TypeSafeMatcherTest;
		
		// core
		public var t6:AllOfTest;
		public var t7:AnyOfTest;
		public var t8:CombinableTest;
		public var t9:DescribedAsTest;
		public var t10:EveryTest;
		public var t11:IsAnythingTest;
		public var t12:IsNotTest;
		
		// collection
		public var t13:IsArrayTest;
		public var t14:IsArrayWithSizeTest;
		public var t15:IsArrayContainingTest;
		
		// number
		public var t16:BetweenTest;
		public var t17:CloseToTest;
		public var t18:GreaterThanTest;
		public var t19:LessThanTest;
		
		// object
		public var t20:HasPropertyTest;
		public var t21:HasPropertyWithValueTest;
		public var t22:IsEqualTest;
		public var t23:IsInstanceOfTest;
		public var t24:IsNullTest;
		public var t25:IsSameTest;
		
		// text
		public var t26:StringContainsTest;
		public var t27:StringEndsWithTest;
		public var t28:StringStartsWithTest;
		
		// extras
		public var t29:ThrowsTest;

	}
}