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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit
{
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.matchers.Each;
	import org.hamcrest.Matcher;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	
	/**
	 * A set of methods useful for stating assumptions about the conditions in which a test is meaningful.
	 * A failed assumption does not mean the code is broken, but that the test provides no useful information.
	 * The default JUnit runner treats tests with failing assumptions as ignored.  Custom runners may behave differently.
	 * 
	 * For example:
	 * <pre>
	 * // only provides information if database is reachable.
	 * \@Test public void calculateTotalSalary() {
	 *    DBConnection dbc = Database.connect();
	 *    assumeNotNull(dbc);
	 *    // ...
	 * }
	 * </pre>
	 * These methods can be used directly: <code>Assume.assumeTrue(...)</code>, however, they
	 * read better if they are referenced through static import:<br/>
	 * <pre>
	 * import static org.junit.Assume.*;
	 *    ...
	 *    assumeTrue(...);
	 * </pre>
	 */
	public class Assume {
		/**
		 * If called with an expression evaluating to {@code false}, the test will halt and be ignored.
		 * @param b
		 */
		public static function assumeTrue( b:Boolean ):void {
			assumeThat(b, equalTo(true));
		}
	
		/**
		 * If called with one or more null elements in <code>objects</code>, the test will halt and be ignored.
		 * @param objects
		 */
		public static function assumeNotNull( ...objects):void {
			assumeThat(objects as Array, Each.eachOne(notNullValue()));
		}
	
		    /**
		     * Call to assume that <code>actual</code> satisfies the condition specified by <code>matcher</code>.
		     * If not, the test halts and is ignored.
		     * Example:
		     * <pre>:
		     *   assumeThat(1, is(1)); // passes
		     *   foo(); // will execute
		     *   assumeThat(0, is(1)); // assumption failure! test halts
		     *   int x = 1 / 0; // will never execute
		     * </pre>
		     *   
		     * @param <T> the static type accepted by the matcher (this can flag obvious compile-time problems such as {@code assumeThat(1, is("a"))}
		     * @param actual the computed value being compared
		     * @param matcher an expression, built of {@link Matcher}s, specifying allowed values
		     * 
		     * @see org.hamcrest.CoreMatchers
		     * @see org.junit.matchers.JUnitMatchers
		     */
		public static function assumeThat( actual:Object, matcher:Matcher ):void {
			if (!matcher.matches(actual))
				throw new AssumptionViolatedException(actual, matcher); 
		}
	
	    /**
		 * Use to assume that an operation completes normally.  If {@code t} is non-null, the test will halt and be ignored.
		 * 
		 * For example:
		 * <pre>
		 * \@Test public void parseDataFile() {
		 *   DataFile file;
		 *   try {
		 *     file = DataFile.open("sampledata.txt");
		 *   } catch (IOException e) {
		 *     // stop test and ignore if data can't be opened
		 *     assumeNoException(e);
		 *   }
		 *   // ...
		 * }
		 * </pre>
		 * @param t if non-null, the offending exception
		 */
		public static function assumeNoException( e:Error ):void {
			assumeThat(e, nullValue());
		}
	}
}