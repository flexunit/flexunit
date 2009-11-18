package org.flexunit.listeners
{
	import org.flexunit.listeners.closer.AirCloser;

	public class AirCIListener extends CIListener
	{
		public function AirCIListener(port:uint=DEFAULT_PORT, server:String=DEFAULT_SERVER)
		{
			super(port, server);
			super.closer = new AirCloser();
		}
	}
}