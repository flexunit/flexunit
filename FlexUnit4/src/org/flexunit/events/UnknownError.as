package org.flexunit.events
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	public class UnknownError extends Error
	{
		public function UnknownError( event:Event )
		{
			var error:Error;
			if ( event.hasOwnProperty( "error" ) ) {
				var errorGeneric:* = event[ "error" ];
				
				if ( errorGeneric is Error ) {
					error = errorGeneric as Error;
				} else if ( errorGeneric is ErrorEvent ) {
					var errorEvent:ErrorEvent = errorGeneric as ErrorEvent;
					error = new Error( "Top Level Error", Object(errorEvent).errorID );
				}
			}
			
			super( error.message, error.errorID );
		}
	}
}