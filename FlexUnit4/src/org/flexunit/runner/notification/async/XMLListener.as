/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Jeff Tapper <jtapper@digitalprimates.net>
 * @version    
 **/ 
/**
 * notes
 * 
 * currently, im printing all successes, then all failures, then all ignores.
 * may make more sense to return them in order.  
 * since we need to return the total number of tests in the first result, but we can't know that until
 * all the tests are complete, we probably need to keep an array of all the results in order as they come back, 
 * and when the tests are done, loop over the array and send the messages. 
 * 
 * */

package org.flexunit.runner.notification.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	import mx.logging.ILogger;
	
	import org.flexunit.runner.Descriptor;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;


	public class XMLListener extends EventDispatcher implements IAsyncStartupRunListener
	{
		
		private var logger:ILogger;
		
		
		private static const SUCCESS:String = "success";
		private static const ERROR:String = "error";
		private static const FAILURE:String = "failure";
		private static const IGNORE:String = "ignore";
		
		private var successes:Array = new Array();
		private var ignores:Array = new Array();
		
		private var _ready:Boolean = false;
		
		private static const END_OF_TEST_RUN : String = "<endOfTestRun/>";
		
		// yes, i know this is not the right solution
		// but im making the socket public so i can attach a listener to it
		// this can clearly be done better, but im tired, and this is what
		// i have at the moment
		private var socket:XMLSocket;
		[Inspectable]
		public var port : uint = 8765;
		
		[Inspectable]
		public var server : String = "127.0.0.1"; //this is local host. same machine
		
		private var lastFailedTest:IDescription;
		
		private var msgQueue:Array = new Array();

		public function XMLListener() {
			socket = new XMLSocket ();
	      	socket.addEventListener( Event.CONNECT, handleConnect );
			socket.addEventListener( IOErrorEvent.IO_ERROR, errorHandler);
			socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR,errorHandler);
   	   		socket.addEventListener( Event.CLOSE,errorHandler);
   	   		try
   	   		{
   	   			socket.connect( server, port );
   	   		} catch (e:Error) {
   	   			trace (e.message);
   	   		}
		}
		
		[Bindable(event="listenerReady")]
		public function get ready():Boolean {
			return _ready;
		}
		
		public function testRunStarted( description:IDescription ):void{
			
		}

		public function testRunFinished( result:Result ):void {
			printHeader( result );
			printResults(result);
			printFooter( result );
		}

		public function testStarted( description:IDescription ):void {
			
		}
		
		public function testFinished( description:IDescription ):void {
			//logger.info( description.displayName + " ." );
			if(description.displayName != lastFailedTest.displayName){
				var desc:Descriptor = getDescriptorFromDescription(description);
				msgQueue.push( "<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+SUCCESS+"'/>");
			}
		}

		public function testAssumptionFailure( failure:Failure ):void {
			
		}

		public function testIgnored( description:IDescription ):void {
			
			var desc:Descriptor = getDescriptorFromDescription(description);
			msgQueue.push("<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+IGNORE+"'/>");
			//logger.info( description.displayName + " I" );
		}
	
	
		public function testFailure( failure:Failure ):void {
			lastFailedTest = failure.description;
			var descriptor:Descriptor = getDescriptorFromDescription(failure.description);
			var type : String = failure.description.displayName
			var message : String = failure.message;
			var stackTrace : String = failure.stackTrace;
			var methodName : String = descriptor.method
					
			var xml : String =
				"<testCase name='"+descriptor.method+"' testSuite='"+descriptor.suite+"'  status='"+FAILURE+"'>"+
					"<failure type='"+ type +"' >"+
						"<messageInfo>"+ message+ "</messageInfo>"+ 
						"<stackTraceInfo>" + stackTrace+ "</stackTraceInfo>"+
					 "</failure>"+
				"</testCase>";
			
			msgQueue.push(xml);	
		}
		/*
		 * Internal methods
		 */

		private function getDescriptorFromDescription(description:IDescription ):Descriptor{
			var descriptor:Descriptor = new Descriptor();
			var descriptionArray:Array = description.displayName.split("::");
			descriptor.path = descriptionArray[0];
			var classMethod:String =  descriptionArray[1];
			var classMethodArray:Array = classMethod.split(".");
			descriptor.suite = classMethodArray[0];
			descriptor.method = classMethodArray[1];
			return descriptor;
		}
		 
		protected function printHeader( result:Result ):void {
			var totalTestCount:int = result.runCount;
			var currentProjectName:String = "currentProjectName";
			var currentContextName:String = "currentContextName";
			sendResults("<startTestRun totalTestCount='"+totalTestCount+"'  projectName='"+currentProjectName+"' contextName='"+currentContextName+"' />");
			
		}
	
		protected function printResults( result:Result ):void{
			for(var i:int=0;i<msgQueue.length;i++){
				sendResults(msgQueue[i]);
			}
		}
	
		protected function printFooter( result:Result ):void {
			logger.warn(END_OF_TEST_RUN);
		}
	
		protected function sendResults(msg:String):void{
			if(socket.connected){
				socket.send( msg );
				trace(msg);
			}
			//
		}

		private function handleConnect(event:Event):void{
			_ready = true;
			dispatchEvent( new Event( AsyncListenerWatcher.LISTENER_READY ) );
			//dispatchEvent( event );
			
		}
		private function errorHandler(event:Event):void{
			dispatchEvent( new Event( AsyncListenerWatcher.LISTENER_FAILED ) );
			//dispatchEvent( event ) ;
			//throw new Error("unable to connect to flex builder to send results");
		}
	
		
	}
}