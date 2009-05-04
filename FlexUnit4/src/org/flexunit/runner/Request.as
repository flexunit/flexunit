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
package org.flexunit.runner {
	import mx.collections.Sort;
	
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.requests.ClassRequest;
	import org.flexunit.internals.requests.FilterRequest;
	import org.flexunit.runner.manipulation.Filter;
	import org.flexunit.runners.Suite;
	
	use namespace classInternal;
	
	/**
	 * <p>A <code>Request</code> is an abstract description of tests to be run.
	 *  //TODO: I assume that the immediately following paragraph can simply be deleted, but I want to make
	 * //sure before doing so. 
	 *  Older versions of 
	 * JUnit did not need such a concept--tests to be run were described either by classes containing
	 * tests or a tree of {@link  org.junit.Test}s. However, we want to support filtering and sorting,
	 * so we need a more abstract specification than the tests themselves and a richer
	 * specification than just the classes.</p>
	 * 
	 * <p>The flow when FlexUnit runs tests is that a <code>Request</code> specifies some tests to be run ->
	 * a {@link org.flexunit.runner.Runner} is created for each class implied by the <code>Request</code> -> 
	 * the {@link org.flexunit.runner.Runner} returns a detailed {@link org.flexunit.runner.Description} 
	 * which is a tree structure of the tests to be run.</p>
	 */
	public class Request implements IRequest {
		private var _filter:Function;
		private var _sort:Sort;
		classInternal var _runner:IRunner;

		public function get sort():Sort {
			return _sort;
		}

		public function set sort( value:Sort ):void {
			_sort = value;
			trace("To be implemented");
		}

		/**
		 * Returns an {@link IRunner} for this Request
		 * @return corresponding {@link IRunner} for this Request
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
		 * <code>filter</code> is applied
		 * @param filter The {@link Filter} to apply to this Request
		 * @return the filtered Request
		 */
		protected function filterWithFilter( filter:Filter ):Request {
			return new FilterRequest(this, filter);
		}
		
		/**
		 * Returns a Request that only runs contains tests whose {@link Description}
		 * equals <code>desiredDescription</code>
		 * @param desiredDescription {@link Description} of those tests that should be run
		 * @return the filtered Request
		 */
		protected function filterWithDescription( desiredDescription:IDescription ):Request {
			var filter:Filter = new Filter(
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

		public function filterWith( filterOrDescription:* ):Request {
			if ( filterOrDescription is IDescription ) {
				return filterWithDescription( filterOrDescription as IDescription );
			} else if ( filterOrDescription is Filter ) {
				return filterWithFilter( filterOrDescription as Filter );
			}

			return this;
		}

		public static function aClass( clazz:Class ):Request {
			return new ClassRequest(clazz);
		}

/* 		public static function aInstance( instance:Object ):Request {
			return new InstanceRequest( instance );
		}
 */		
 
 		/**
		 * Create a <code>Request</code> that, when processed, will run all the tests
		 * in a set of classes.
		 * @param argumentsArray the classes containing the tests
		 * @return a <code>Request</code> that will cause all tests in the classes to be run
		 */
		public static function classes( ...argumentsArray ):Request {
			return runner( new Suite( new AllDefaultPossibilitiesBuilder( true ), argumentsArray ) );
		}

		/**
		 * @param runner the IRunner to return
		 * @return a <code>Request</code> that will run the given runner when invoked
		 */
	 	public static function runner( runner:IRunner ):Request {
	 		var request:Request = new Request();
	 		request._runner = runner;
	 		
	 		return request;
		}

		public static function method( clazz:Class, methodName:String ):Request {
			var method:IDescription = Description.createTestDescription( clazz, methodName );
			return Request.aClass(clazz).filterWith(method);
		}

		public function Request() {
		}
	}
}