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
package org.flexunit.internals.builders
{
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * The <code>FlexUnit4Builder</code> builds a <code>BlockFlexUnit4ClassRunner</code> for
	 * a provided testClass.  A <code>BlockFlexUnit4ClassRunner</code> will be built for every
	 * testClass that is provided to this builder.<br/>
	 * 
	 * This is the last builder to be used with a testClass when determining which <code>IRunner</code>
	 * to used by the class; the <code>BlockFlexUnit4ClassRunner</code> is the default <code>IRunner</code>
	 * to use with a testClass if no other suitable runner can be found.
	 * 
	 * @see org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder#runnerForClass()
	 */
	public class FlexUnit4Builder extends RunnerBuilderBase {
		/**
		 * Constructor.
		 */
		public function FlexUnit4Builder() {
			super();
		}
		
		
		override public function canHandleClass(testClass:Class):Boolean {
			return true;
		}
		
		/**
		 * Returns a <code>BlockFlexUnit4ClassRunner</code> for the provided <code>testClass</code>.
		 * 
		 * @param testClass The test class provided to the builder.
		 * 
		 * @return a <code>BlockFlexUnit4ClassRunner</code> for the provided <code>testClass</code>.
		 */
		override public function runnerForClass( testClass:Class ):IRunner {
			return new BlockFlexUnit4ClassRunner(testClass);
		}		
	}
}