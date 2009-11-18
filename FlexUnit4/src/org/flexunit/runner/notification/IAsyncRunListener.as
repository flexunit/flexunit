package org.flexunit.runner.notification
{
	import flash.events.IEventDispatcher;
	
	/**
	 * The <code>IAsyncRunListener</code> is an interface that is to be implemented by classes
	 * that are to be asynchronous run listeners.
	 */
	public interface IAsyncRunListener extends IEventDispatcher, IRunListener
	{
		
	}
}