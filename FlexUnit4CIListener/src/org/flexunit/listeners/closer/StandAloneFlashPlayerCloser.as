package org.flexunit.listeners.closer
{
	import flash.system.fscommand;

	/**
	 * Default implementation of an applicaiton closer specfic to the stand-alone/projector
	 * Flash Player.
	 */
	public class StandAloneFlashPlayerCloser implements ApplicationCloser
	{
		public function StandAloneFlashPlayerCloser()
		{
		}
	
		/**
		 * Calls out to the host environment using fscommand("quit") which will in turn
		 * close the host environment.
		 */
		public function close():void
		{
			fscommand("quit");
		}
	}
}