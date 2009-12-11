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
	import org.hamcrest.assertThat;
	
	/**
	 * Creates a hamcrest style assertion using assertThat
	 * 
	 * @param ...rest Rest may specify any values to be tested. It must include
	 * 		a left and a right value as well as at least one matcher.  An error message
	 * 		may also be passed if passed as the first argument.
	 * 
	 * 
	 * @example
	 * <listing version="3.0">
	 * 		assertThat( "3 is usually 3", 3, equals( 4 ) );
	 * </listing>
	 */
	public function assertThat( ...rest ):void {
		Assert.assertWithApply( org.hamcrest.assertThat, rest );
		//org.hamcrest.assertThat.apply( null, rest );
	}
}