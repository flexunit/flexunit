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
package org.flexunit.internals.requests {
	import org.flexunit.internals.runners.ErrorReportingRunner;
	import org.flexunit.runner.IRequest;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.Request;
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runner.manipulation.NoTestsRemainException;

	/**
	 * A filtered {@link Request}.
	 */
	public class FilterRequest extends Request {
		private var request:IRequest;
		private var filter:Filter;

		/**
		 * Creates a filtered Request
		 * @param classRequest an {@link IRequest} describing your Tests
		 * @param filter {@link Filter} to apply to the Tests described in 
		 * <code>classRequest</code>
		 */
		public function FilterRequest( classRequest:IRequest, filter:Filter ) {
			super();
			this.request = classRequest;
			this.filter = filter;
		}
		
		//TODO: Unsure of meaning and applicability of @inheritDoc
		/** @inheritDoc */
		override public function get iRunner():IRunner {
			try {
				var runner:IRunner = request.iRunner;
				filter.apply( runner );
				return runner;
			} catch ( error:NoTestsRemainException ) {
				return new ErrorReportingRunner( Filter, 
					new Error( "No tests found matching " + filter.describe + " from " + request ) );
								
			}
			
			return null;
		}
	}
}