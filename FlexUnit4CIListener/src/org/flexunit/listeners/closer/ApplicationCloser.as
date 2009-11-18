package org.flexunit.listeners.closer
{
	/**
	 * An applicaiton closer specifies the strategy by which the host environment should be closed if
	 * that process can be controlled from the Flash movie.
	 */ 
	public interface ApplicationCloser
	{
		/**
		 * Attempts to close the host environment.
		 */
		function close() : void;
	}
}