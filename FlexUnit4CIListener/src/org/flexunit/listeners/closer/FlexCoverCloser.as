package org.flexunit.listeners.closer
{
	import com.allurent.coverage.runtime.CoverageManager;

	/**
	 * Implementation of an application closer specific to FlexCover
	 */
	public class FlexCoverCloser implements ApplicationCloser
	{
		public function FlexCoverCloser()
		{
		}
		
		/**
		 * Calls out to the CoverageManager.exit() method which will in 
		 * turn close the FP and CoverageViewer AIR applicaiton.
		 */
		public function close():void
		{
			CoverageManager.exit();
		}
	}
}