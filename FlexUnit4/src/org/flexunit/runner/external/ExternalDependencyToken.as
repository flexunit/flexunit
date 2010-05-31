package org.flexunit.runner.external {
	import flex.lang.reflect.Field;
	
	import org.flexunit.internals.dependency.ExternalDependencyResolver;
	import org.flexunit.internals.dependency.IExternalDependencyResolver;

	public class ExternalDependencyToken {
		private var resolver:IExternalDependencyResolver;
		public var targetField:Field;

		public function addResolver( adr:IExternalDependencyResolver ):void {
			resolver = adr;	
		}

		public function removeResolver( adr:IExternalDependencyResolver ):void {
			if ( resolver == adr ) {
				resolver = null;
			}
		}

		public function notifyResult( data:Object ):void {
			resolver.dependencyResolved( this, data );			
		}

		public function notifyFault( error:Object ):void {
			resolver.dependencyFailed( this, error );
		}

		public function ExternalDependencyToken( ) {
		}
	}
}
