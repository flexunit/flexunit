package org.flexunit.async.cases
{
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.async.Async;

	public class AsyncServiceCase
	{
		private var httpService:HTTPService;

		[Before]
		public function setupService():void {
			httpService = new HTTPService();
			//service.url = "http://www.flexgrocer.com/product.xml";
		}

		[After]
		public function killService():void {
			httpService = null;	
		}
		
		[Test(async)]
		public function doTest():void {
			Async.registerFailureEvent( this, httpService, FaultEvent.FAULT );
			Async.handleEvent( this, httpService, ResultEvent.RESULT, handleResult, 2000 );
			httpService.send();			
		}

		private function handleResult( event:ResultEvent, passThroughData:Object ): void {
			
		}
		
		public function AsyncServiceCase()
		{
		}
	}
}