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
 * @author     Jeff Tapper 
 * @version    
 **/ 

package org.flexunit.runner.notification.async
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	import org.flexunit.reporting.FailureFormatter;
	import org.flexunit.runner.Descriptor;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.IAsyncStartupRunListener;


	public class XMLListener extends EventDispatcher implements IAsyncStartupRunListener
	{
		
		//private var logger:ILogger = Log.getLogger( "XMLListener" );
		
		
		/**
		 * Constant to be sent on success  of a test
		 */
		private static const SUCCESS:String = "success";
		/**
		 * Constant to be sent on error of a test
		 */
		private static const ERROR:String = "error";
		/**
		 * Constant to be sent on failure of a test
		 */
		private static const FAILURE:String = "failure";
		/**
		 * Constant to be sent on ignore of a test 
		 */
		private static const IGNORE:String = "ignore";
		
		/**
		 * @private 
		 */
		private var successes:Array = new Array();
		/**
		 * @private 
		 */
		private var ignores:Array = new Array();
		
		/**
		 * @private 
		 */
		private var _ready:Boolean = false;
		
		/**
		 * @private 
		 */
		private static const END_OF_TEST_RUN : String = "<endOfTestRun/>";
		
		/**
		 * @private 
		 */
		private var socket:XMLSocket;

		[Inspectable]
		/**
		 * The port used to communicate with the server receiving this XML 
		 */
		public var port : uint = 8765;
		
		[Inspectable]
		/**
		 * The ip address of the server receiving this XML 
		 */
		public var server : String = "127.0.0.1"; //this is local host. same machine
		
		/**
		 * @private 
		 */
		private var lastFailedTest:IDescription;
		
		//private var msgQueue:Array = new Array();
		/**
		 * @private 
		 */
		private var projectName:String;
		/**
		 * @private 
		 */
		private var contextName:String;

		/**
		 * An implementation of an XMLListener designed to communicate with Adobe Flash Builder Pro
		 * to send results to the flash builder FlexUnit panel
		 *  
		 * @param projectName Name of the project in FlashBuilder
		 * @param contextName
		 * 
		 */
		public function XMLListener( projectName:String = "", contextName:String = "" ) {
			this.projectName = projectName;
			this.contextName = contextName;

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
		/**
		 * 
		 * Indicates if the listener is ready and connected to Flash Builder
		 * 
		 */
		public function get ready():Boolean {
			return _ready;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		private function getTestCount( description:IDescription ):int {
			return description.testCount;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		public function testRunStarted( description:IDescription ):void{
			// XML Socket in flexbuilder is expecting a startTestRun node at the begining of the results.
			// it seems to use this to reset hte current results, and prepopulate the total number of tests
			// however, in flexunit4, we are unable to determine the total number of tests before hand, so
			// we are sending through an empty startTestRun node, so the reset can still happen.
			sendResults("<startTestRun totalTestCount='" + getTestCount( description ) + "'  projectName='" + projectName + "' contextName='" + contextName +"' />");
		}

		/**
		 * 
		 * @private
		 * 
		 */
		public function testRunFinished( result:Result ):void {
		
			// if we want to wait until all tests are finished before sending any results, 
			// in this method we should first call printHeader, then printResults, then printFooter
			// however, as we are now sending through results as they happen, we use this method only to call printFooter		
			//printHeader( result );
			//printResults(result);
			printFooter( result );
		}

		/**
		 * 
		 * @private
		 * 
		 */
		public function testStarted( description:IDescription ):void {
			// called before each test
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		public function testFinished( description:IDescription ):void {
			// called after each test
			if(!lastFailedTest || description.displayName != lastFailedTest.displayName){
				var desc:Descriptor = getDescriptorFromDescription(description);
				sendResults("<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+SUCCESS+"'/>");
				//msgQueue.push( "<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+SUCCESS+"'/>");
			}
		}

		/**
		 * 
		 * @private
		 * 
		 */
		public function testAssumptionFailure( failure:Failure ):void {
			// called on assumptionFail
		}

		/**
		 * 
		 * @private
		 * 
		 */
		public function testIgnored( description:IDescription ):void {
			// called on ignored test
			var desc:Descriptor = getDescriptorFromDescription(description);
			sendResults("<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+IGNORE+"'/>");
			//msgQueue.push("<testCase name='"+desc.method+"' testSuite='"+desc.suite+"'  status='"+IGNORE+"'/>");
		}
	
	
		/**
		 * 
		 * @private
		 * 
		 */
		public function testFailure( failure:Failure ):void {
			// called on a test failure
			lastFailedTest = failure.description;
			var descriptor:Descriptor = getDescriptorFromDescription(failure.description);
			var type : String = failure.description.displayName
			var message : String = FailureFormatter.xmlEscapeMessage( failure.message );
			var stackTrace : String = FailureFormatter.xmlEscapeMessage( failure.stackTrace );
			var methodName : String = descriptor.method;
						
			var xmlString:String;
			xmlString = createMessage( FailureFormatter.isError( failure.exception ), methodName, descriptor.suite, type, message, stackTrace );
			
			sendResults( xmlString );
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		private function createMessage( isError:Boolean, methodName:String, suite:String, type:String, message:String, stackTrace:String ):String {
			var xmlString:String;
			if ( isError ) {
				xmlString = createErrorMessage( methodName, suite, type, message, stackTrace );
			} else {
				xmlString = createFailureMessage( methodName, suite, type, message, stackTrace );
			}
				
			return xmlString;
		}

		/**
		 * 
		 * @private
		 * 
		 */
		private function createFailureMessage( methodName:String, suite:String, type:String, message:String, stackTrace:String ):String {
			var xml : String =
				"<testCase name='"+methodName+"' testSuite='"+suite+"'  status='"+FAILURE+"'>"+
				"<failure type='"+ type +"' >"+
				"<messageInfo>"+message+ "</messageInfo>"+  
				"<stackTraceInfo>" +stackTrace+ "</stackTraceInfo>"+ 
				"</failure>"+
				"</testCase>";

			return xml;
		}

		/**
		 * 
		 * @private
		 * 
		 */
		private function createErrorMessage( methodName:String, suite:String, type:String, message:String, stackTrace:String ):String {
			var xml : String =
				"<testCase name='"+methodName+"' testSuite='"+suite+"'  status='"+ERROR+"'>"+
				"<error type='"+ type +"' >"+
				"<messageInfo>"+message+ "</messageInfo>"+  
				"<stackTraceInfo>" +stackTrace+ "</stackTraceInfo>"+ 
				"</error>"+
				"</testCase>";
			
			return xml;
		}

		/*
		 * Internal methods
		 */

		/**
		 * 
		 * @private
		 * 
		 */
		private function getDescriptorFromDescription(description:IDescription ):Descriptor{
			// reads relavent data from descriptor
			/**
			 * JAdkins - 7/27/07 - FXU-53 - Listener was returning a null value for the test class
			 * causing no data to be returned.  If length of array is greater than 1, then class is
			 * not in the default package.  If array length is 1, then test class is default package
			 * and formats accordingly.
			 **/
			var descriptor:Descriptor = new Descriptor();
			var descriptionArray:Array = description.displayName.split("::");
			var classMethod:String;
			if ( descriptionArray.length > 1 ) {
				descriptor.path = descriptionArray[0];
				classMethod =  descriptionArray[1];
			} else {
				classMethod =  descriptionArray[0];
			}
			var classMethodArray:Array = classMethod.split(".");
			descriptor.suite = ( descriptor.path == "" ) ?  classMethodArray[0] : 
				descriptor.path + "::" + classMethodArray[0];
			descriptor.method = classMethodArray[1];
			return descriptor;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		protected function printHeader( result:Result ):void {
			var totalTestCount:int = result.runCount;
			var currentProjectName:String = "currentProjectName";
			var currentContextName:String = "currentContextName";
			sendResults("<startTestRun totalTestCount='"+totalTestCount+"'  projectName='"+currentProjectName+"' contextName='"+currentContextName+"' />");
			
		}
	
		/**
		 * 
		 * @private
		 * 
		 */
		protected function printResults( result:Result ):void{
			//logger.info("printResults");
/*			for(var i:int=0;i<msgQueue.length;i++){
				sendResults(msgQueue[i]);
			}
*/		}
	
		/**
		 * 
		 * @private
		 * 
		 */
		protected function printFooter( result:Result ):void {
		//	logger.warn(END_OF_TEST_RUN);
			sendResults(END_OF_TEST_RUN);
		}
	
		/**
		 * 
		 * @private
		 * 
		 */
		protected function sendResults(msg:String):void{
			if(socket.connected){
				socket.send( msg );
				//trace(msg);
			}
			
		}

		/**
		 * 
		 * @private
		 * 
		 */
		private function handleConnect(event:Event):void{
			_ready = true;
			dispatchEvent( new Event( AsyncListenerWatcher.LISTENER_READY ) );
			
			
		}
		/**
		 * 
		 * @private
		 * 
		 */
		private function errorHandler(event:Event):void{
			dispatchEvent( new Event( AsyncListenerWatcher.LISTENER_FAILED ) );
		}
	
		
	}
}