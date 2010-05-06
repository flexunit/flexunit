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
package org.flexunit.runner {
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.requests.ClassRequest;
	import org.flexunit.internals.requests.FilterRequest;
	import org.flexunit.internals.requests.SortingRequest;
	import org.flexunit.runner.manipulation.IFilter;
	import org.flexunit.runner.manipulation.ISort;
	import org.flexunit.runner.manipulation.filters.DynamicFilter;
	import org.flexunit.runner.manipulation.filters.MethodNameFilter;
	import org.flexunit.runners.Suite;
	import org.flexunit.internals.requests.QualifyingRequest;
	
	use namespace classInternal;
	
	/**
	 * A <code>Request</code> is an abstract description of tests to be run.  It represents an object that 
	 * wraps tests when they are presented to the <code>FlexUnitCore</code>.  <code>Request</code>s can be 
	 * filtered and sorted to control the subset and order of tests to be executed.
	 * 
	 * The following static methods can be used to create requests:
	 * <ul>
	 * <li><code>#aClass()</code></li>
	 * <li><code>#classes()</code></li>
	 * <li><code>#runner()</code></li>
	 * <li><code>#method()</code></li>
	 * </ul>
	 * 
	 * <p>The key property of the <code>Request</code> that the <code>FlexUnitCore</code> needs is the 
	 * <code>IRunner</code>.  The <code>IRunner</code> is an interface implemented by any object 
	 * capable of executing a specific type of test.</p>
	 * 
	 * <p>The flow when FlexUnit4 runs tests is that a <code>Request</code> specifies some tests to be run.
	 * The <code>IRunner</code> is created for each class implied by the <code>Request</code>.  The
	 * <code>IRunner</code> provides a detailed <code>IDescription</code> of the class which is a tree 
	 * structure of the tests to be run.</p>
	 */
	public class Request implements IRequest {
		/**
		 * @private
		 */
		private var _filter:Function;
		/**
		 * @private
		 */
		private var _sort:ISort;
		/**
		 * The <code>IRunner</code> for this Request.
		 */
		classInternal var _runner:IRunner;
		
		/**
		 * Returns an <code>ISort</code> for this Request.
		 */
		public function get sort():ISort {
			return _sort;
		}

		public function set sort( value:ISort ):void {
			_sort = value;
			trace("To be implemented");
		}

		/**
		 * Returns an <code>IRunner</code> for this Request.
		 */
		public function get iRunner():IRunner {
			return _runner;
		}
		
		[Deprecated("Use the iRunner property instead")]
		public function getRunner():IRunner {
			return iRunner;
		}
		
		/**
		 * Returns a Request that only contains those tests that should run when
		 * a <code>filter</code> is applied.
		 * 
		 * @param filter The <code>Filter</code> to apply to this Request.
		 * 
		 * @return the filtered Request.
		 */
		protected function filterWithFilter( filter:IFilter ):Request {
			return new FilterRequest(this, filter);
		}
		
		/**
		 * Returns a Request that only runs contains tests whose <code> Description</code>
		 * equals <code>desiredDescription</code>.
		 * 
		 * @param desiredDescription An <code>IDescription</code> of those tests that should be run.
		 * 
		 * @return the filtered Request.
		 */
		protected function filterWithDescription( desiredDescription:IDescription ):Request {
			var filter:DynamicFilter = new DynamicFilter(
				function( description:IDescription ):Boolean {
					if ( description.isTest )
						return desiredDescription.equals(description);
					
					// explicitly check if any children want to run
					for ( var i:int=0; i<description.children.length; i++ ) {
						var item:IDescription = description.children[ i ] as IDescription;
						
						if ( this.shouldRun( item ) ) {
							return true;
						}
					} 
					
					return false;
				},	
				function():String {
					return ( "Method " + desiredDescription.displayName );
				} 
			);
			
			return filterWithFilter( filter );
		}
		
		/**
		 * Returns a Request that either filters based on a <code> Description</code> or a <code>Filter</code>.
		 * 
		 * @param filterOrDescription The <code> Filter</code> or <code> Description</code> to apply to this Request.
		 * 
		 * @return the filtered Request.
		 */
		public function filterWith( filterOrDescription:* ):Request {
			if ( filterOrDescription is IDescription ) {
				return filterWithDescription( filterOrDescription as IDescription );
			} else if ( filterOrDescription is IFilter ) {
				return filterWithFilter( filterOrDescription as IFilter );
			}
			
			//If neither an IDescription or Filter is provided, return the current request
			return this;
		}
		
		/**
		 * @param sorterOrComparatorFunction is either an ISorted implementation or a comparator function to be used
		 * to define the sort order of the tests in this Request.
		 * 
		 * @return a Request with ordered Tests.
		 */
		public function sortWith(sorterOrComparatorFunction:*):Request {
			return new SortingRequest(this, sorterOrComparatorFunction);	
		}
		
		/**
		 * Create a <code>Request</code> that, when processed, will run all the tests
		 * in a class. The odd name is necessary because <code>class</code> is a reserved word.
		 * 
		 * @param clazz the class containing the tests.
		 * 
		 * @return a <code>Request</code> that will cause all tests in the class to be run.
		 */
		public static function aClass( clazz:Class ):Request {
			return new ClassRequest(clazz);
		}

/* 		public static function aInstance( instance:Object ):Request {
			return new InstanceRequest( instance );
		}
 */		
 
		public static function qualifyClasses( ...argumentsArray ):Request {
			return QualifyingRequest.classes.apply( null, argumentsArray );
		}
 
 		/**
		 * Create a <code>Request</code> that, when processed, will run all the tests
		 * in a set of classes.
		 * 
		 * @param argumentsArray the classes containing the tests.
		 * 
		 * @return a <code>Request</code> that will cause all tests in the classes to be run.
		 */
		public static function classes( ...argumentsArray ):Request {
			return runner( new Suite( new AllDefaultPossibilitiesBuilder( true ), argumentsArray ) );
		}

		/**
		 * @param runner the IRunner to return.
		 * 
		 * @return a <code>Request</code> that will run the given runner when invoked.
		 */
	 	public static function runner( runner:IRunner ):Request {
	 		var request:Request = new Request();
	 		request._runner = runner;
	 		
	 		return request;
		}
		
		/**
		 * Create a <code>Request</code> that, when processed, will run a single test.
		 * This is done by filtering out all other tests. This method is used to support rerunning
		 * single tests.
		 * 
		 * @param clazz the class of the test.
		 * @param methodName the name of the test.
		 * 
		 * @return a <code>Request</code> that will cause a single test be run.
		 */
		public static function method( clazz:Class, methodName:String ):Request {
			var method:IDescription = Description.createTestDescription( clazz, methodName );
			return Request.aClass(clazz).filterWith(method);
		}

		public static function methods( clazz:Class, methodNames:Array ):Request {
			return Request.aClass(clazz).filterWith( new MethodNameFilter( methodNames ) );
		}
		
		/**
		 * Constructor.
		 */
		public function Request() {
		}
	}
}