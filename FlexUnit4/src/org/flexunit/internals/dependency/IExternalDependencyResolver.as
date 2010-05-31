package org.flexunit.internals.dependency {
	import flash.events.IEventDispatcher;
	
	import org.flexunit.runner.external.ExternalDependencyToken;
	
	public interface IExternalDependencyResolver extends IEventDispatcher {
		function get ready():Boolean;
		function resolveDependencies():Boolean;
		function dependencyResolved( token:ExternalDependencyToken, data:Object ):void;			
		function dependencyFailed( token:ExternalDependencyToken, error:Object ):void;
	}
}