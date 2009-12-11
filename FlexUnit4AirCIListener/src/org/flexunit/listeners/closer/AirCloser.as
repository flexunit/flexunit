package org.flexunit.listeners.closer
{
	import flash.desktop.NativeApplication;

	/**
	 * Implementation of an application closer specific to AIR.
	 */
	public class AirCloser implements ApplicationCloser
	{
		public function AirCloser()
		{
		}
		
		/**
		 * Calls exit on the NativeApplication with the default exit code of 0.
		 */
		public function close():void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}