package org.flexunit.runner.external {
	public interface IExternalDependencyLoader {
		function retrieveDependency( testClass:Class ):ExternalDependencyToken;
	}
}