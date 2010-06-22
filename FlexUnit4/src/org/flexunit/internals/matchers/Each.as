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
package org.flexunit.internals.matchers
{
	import org.hamcrest.Matcher;

	/**
	 * Implements an EachMatcher for internal framework use 
	 * @author mlabriola
	 * 
	 */	
	public class Each {
		/**
		 * an each matcher 
		 * @param individual Matcher
		 * @return Matcher
		 * 
		 */		
		public static function eachOne( individual:Matcher ):Matcher {
			return new EachMatcher( individual );
		}	
	}
}

import org.hamcrest.BaseMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.Description;
import org.hamcrest.core.not;
import org.hamcrest.collection.hasItem;

/**
 * Internal implementation of each matcher 
 * @author mlabriola
 * 
 */
class EachMatcher extends BaseMatcher {

	/**
	 * @private
	 */
	private var allItemsAre:Matcher;
	/**
	 * @private
	 */
	private var individual:Matcher;

	/**
	 * Constructor
	 */
	public function EachMatcher( individual:Matcher ):void {
		this.individual = individual;
		allItemsAre = not(hasItem(not(individual)));
	}
	
	/**
	 * @private
	 */
    override public function matches(item:Object):Boolean {
      return allItemsAre.matches( item );
    }

	/**
	 * @private
	 */
    override public function describeTo(description:Description):void {
		description.appendText("each ");
		individual.describeTo(description);	      
    }
}