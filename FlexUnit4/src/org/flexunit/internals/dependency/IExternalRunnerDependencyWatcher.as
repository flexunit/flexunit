package org.flexunit.internals.dependency {
	import org.flexunit.token.AsyncCoreStartupToken;

	public interface IExternalRunnerDependencyWatcher {
		function get token():AsyncCoreStartupToken;		
		function get allDependenciesResolved():Boolean;
		function watchDependencyResolver( dr:IExternalDependencyResolver ):void;
	}
}