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
package org.flexunit
{
	import org.flexunit.async.AsyncTestResponder;
	import org.flexunit.async.ITestResponder;
	import org.flexunit.async.TestResponder;
	import org.flexunit.events.AsyncResponseEvent;
	import org.flexunit.internals.TextListener;
	import org.fluint.sequence.ISequenceAction;
	import org.fluint.sequence.ISequencePend;
	import org.fluint.sequence.ISequenceStep;
	import org.fluint.sequence.SequenceBindingWaiter;
	import org.fluint.sequence.SequenceCaller;
	import org.fluint.sequence.SequenceDelay;
	import org.fluint.sequence.SequenceEventDispatcher;
	import org.fluint.sequence.SequenceRunner;
	import org.fluint.sequence.SequenceSetter;
	import org.fluint.sequence.SequenceWaiter;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;
	import org.fluint.uiImpersonation.flex.FlexEnvironmentBuilder;
	import org.fluint.uiImpersonation.flex.FlexVisualTestEnvironment;

	/**
	 * These classes should only be included in a Flex project
	 */
	public class IncludeFlexClasses
	{
		private var fxu1:AsyncTestResponder;
		private var fxu2:ITestResponder;
		private var fxu3:TestResponder;
		private var fxu4:AsyncResponseEvent;
		
		private var flu1:ISequenceAction;
		private var flu2:ISequencePend;
		private var flu3:ISequenceStep;
		private var flu4:SequenceBindingWaiter;
		private var flu5:SequenceCaller;
		private var flu6:SequenceDelay;
		private var flu7:SequenceEventDispatcher;
		private var flu8:SequenceRunner;
		private var flu9:SequenceSetter;
		private var flu10:SequenceWaiter;
		private var flu11:VisualTestEnvironmentBuilder;
		
		private var flu13:TextListener;
		private var flu14:FlexVisualTestEnvironment;
		private var flu15:FlexEnvironmentBuilder;
	}
}