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
	import org.flexunit.runners.model.RunnerBuilderBase;
	
	/**
	 * The <code>NullBuilder</code> does not build an <code>IRunner</code>.  Instead, it provides a value
	 * of <code>null</code> as the <code>IRunner</code>.  The <code>NullBuilder</code> is typically used
	 * if another builder cannot be used at the present time.
	 * 
	 * The <code>AllDefaultPossibilitiesBuilder</code> uses this builder when other builders cannot be used
	 * under certain conditions (ex: AS only project).
	 * 
	 * @see org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder#fluint1Builder()
	 */
	public class NullBuilder extends RunnerBuilderBase
	{
		/**
		 * Constructor.
		 */
		public function NullBuilder()
		{
			super();
		}
		
	}
}