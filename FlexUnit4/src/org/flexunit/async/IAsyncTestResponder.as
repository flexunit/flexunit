package org.flexunit.async
{
	import flash.events.IEventDispatcher;
	
	import mx.rpc.IResponder;
 	
	//Marker interface to allow others to substitute their own responsers for ours
	public interface IAsyncTestResponder extends IResponder, IEventDispatcher {
		
	}
}