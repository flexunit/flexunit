package org.flexunit.runner.external {
	import flash.events.IEventDispatcher;
	
	import org.flexunit.internals.dependency.IExternalRunnerDependencyWatcher;
	import org.flexunit.runner.IRunner;

	public interface IExternalDependencyRunner extends IRunner {
		function set dependencyWatcher( value:IExternalRunnerDependencyWatcher ):void;
	}
}