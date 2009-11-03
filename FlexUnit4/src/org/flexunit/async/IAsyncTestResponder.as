package org.flexunit.async
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
 	
	/**
	 * This is a marker interface that allows others to substitute their own asynchronous test 
	 * responsers for the ones that already exist.
	 */
	public interface IAsyncTestResponder extends IResponder, IEventDispatcher {
		
	}
}