package org.flexunit.internals.dependency {
	import flex.lang.reflect.Field;

	public class AsyncDependencyToken {
		private var resolver:AsyncDependencyResolver;
		public var field:Field;
		

		public function addResolver( adr:AsyncDependencyResolver ):void {
			resolver = adr;	
		}

		public function removeResolver( adr:AsyncDependencyResolver ):void {
			if ( resolver == adr ) {
				resolver = null;
			}
		}

		public function notifyResult( data:Object ):void {
			resolver.dependencyResolved( this, data );			
		}

		public function notifyFault( ):void {
			
		}

		public function AsyncDependencyToken( ) {
		}
	}
}
