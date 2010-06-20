package org.fluint.uiImpersonation {
	/**
	 * 
	 * Implemented by classes capable of building a visual test environment
	 * for the UIImpersonator to use
	 * 
	 * @author mlabriola
	 * 
	 */
	public interface IVisualEnvironmentBuilder {
		/**
		 * Builds and returns an IVisualTestEnvironment
		 * 
		 * @return IVisualTestEnvironment
		 * 
		 */
		function buildVisualTestEnvironment():IVisualTestEnvironment;		
	}
}