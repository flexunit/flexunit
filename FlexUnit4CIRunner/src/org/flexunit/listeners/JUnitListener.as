package org.flexunit.listeners
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import org.flexunit.runner.Descriptor;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;


	public class JUnitListener extends RunListener
	{
		private var logger:ILogger = Log.getLogger("org.flexunit.internals.listeners.JUnitListener");
		
		private static const END_OF_TEST_RUN : String = "<endOfTestRun/>";
		private static const END_OF_TEST_ACK : String ="<endOfTestRunAck/>";

		
		private var successes:Array = new Array();
		private var ignores:Array = new Array();
		
		private var socket : XMLSocket;
		
		/**
		 * <String, TestSuiteReport >
		 */
		private var testSuiteReports : Object = new Object(); 
		
		[Inspectable]
		public var port : uint = 1024;
		
		[Inspectable]
		public var server : String = "127.0.0.1"; //this is local host. same machine
		
		//--------------------------------------------------------------------------
		//
		//  RunListener methods
		//
		//--------------------------------------------------------------------------
		/*override public function testStarted( description:Description ):void
		{
			var descriptor : Descriptor = getDescriptorFromDescription( description );
			var report : TestSuiteReport = getReportForTestSuite( descriptor.path + "." + descriptor.suite );
			report.tests++;
		}*/
		
		override public function testFinished( description:IDescription ):void 
		{
			// Add failing method to proper TestCase in the proper TestSuite
			var descriptor : Descriptor = getDescriptorFromDescription( description );
			
			var report : TestSuiteReport = getReportForTestSuite( descriptor.path + "." + descriptor.suite );
			report.tests++;
			report.methods.push( descriptor );	
		}
		
		override public function testRunFinished( result:Result ):void 
		{
			this.result = result;
			
			logger.debug("test run finished.");
			
			stablishSocketConnection();
			//createXMLReports();
		}
		
		override public function testFailure( failure:Failure ):void 
		{
			// Add failing method to proper TestCase in the proper TestSuite
			var descriptor : Descriptor = getDescriptorFromDescription( failure.description );
			
			var report : TestSuiteReport = getReportForTestSuite( descriptor.path + "." + descriptor.suite );
			report.failures++;
			report.tests++;
			report.methods.push( failure );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Socket connction handler
		//
		//--------------------------------------------------------------------------
		private function stablishSocketConnection( ) : void
		{
			socket = new XMLSocket ();
			socket.addEventListener( DataEvent.DATA, dataHandler );
	      	socket.addEventListener( Event.CONNECT, handleConnect );
			socket.addEventListener( IOErrorEvent.IO_ERROR, errorHandler );
			socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR, errorHandler );
   	   		socket.addEventListener( Event.CLOSE, errorHandler );
   	   		
 	   		socket.connect( server, port );
		}
		
		private function handleConnect(event:Event):void
		{
			logger.info("socket connection stablished successfully");
			
			createXMLReports( );
			
			// Send the end of reports terminator.
			socket.send( END_OF_TEST_RUN );
		}
		
		private function errorHandler(event:Event):void
		{
			logger.error("unable to connect to flexUnit ant task to send results. {0}", event.type );
			throw new Error("unable to connect to flex builder to send results");
		}
		



		
		private function getDescriptorFromDescription(description:IDescription ):Descriptor
		{
			var descriptor:Descriptor = new Descriptor();
			var descriptionArray:Array = description.displayName.split("::");
			descriptor.path = descriptionArray[0];
			var classMethod:String =  descriptionArray[1];
			var classMethodArray:Array = classMethod.split(".");
			descriptor.suite = classMethodArray[0];
			descriptor.method = classMethodArray[1];
			
			return descriptor;
		}
		
		private function getReportForTestSuite( testSuite : String ) : TestSuiteReport
		{
			var report : TestSuiteReport;
			
			if( !(testSuite in testSuiteReports ))
			{
				testSuiteReports[ testSuite ] = new TestSuiteReport();	
			}  
			
			report = TestSuiteReport( testSuiteReports[ testSuite ]);
			report.name = testSuite;
			
			return report; 	
		}
		
		/*
		 * Internal methods
		 */
		private function createXMLReports () : void
		{
			for each ( var testSuiteReport : TestSuiteReport in testSuiteReports )
			{
				// Create the XML report.
				var xml : XML = createXMLTestSuite( testSuiteReport );

				trace(xml.toXMLString());
				
				// Send the XML report.
				if( socket && socket.connected )
				{
					trace(xml.toXMLString());
					socket.send( xml.toXMLString());
				}
			}
		}
		
		protected function createXMLTestSuite( testSuiteReport:TestSuiteReport ) : XML 
		{
			var name : String = testSuiteReport.name;
			var errors : uint = testSuiteReport.errors;
			var failures : uint = testSuiteReport.failures;
			var tests : uint = testSuiteReport.tests;
			var time : Number = testSuiteReport.time;
				
			var xml : XML =
				<testsuite
					errors={ errors }						 
					failures={ failures }
					name={ name }
					tests={ tests }
					time={ time } > </testsuite>; 
			
			for each ( var result : * in testSuiteReport.methods )
			{
				xml.appendChild( createTestCase( result ));	
			}
			
			return xml;
		}
		
		
		/**
		 * Create the test case XML.
		 * @return the XML.
		 */
		private function createTestCase( result : * ) : XML
		{
			// result can be Failure or Descriptor
			var isDescriptor : Boolean = result is Descriptor;
			var descriptor : Descriptor = isDescriptor ? Descriptor( result ) : getDescriptorFromDescription( Failure(result).description );
			var classname : String = descriptor.path + "." + descriptor.suite;
			var name : String = descriptor.method;
			var time : Number = 0; 
					
			var xml : XML =
				<testcase
					classname={ classname }
					name={ name }
					time={ time } />;
					
			return isDescriptor ? xml : xml.appendChild( createFailure( Failure(result)));
		}
		
		/**
		 * Create the failure XML.
		 * @return the XML.
		 */
		private function createFailure( failure : Failure ) : XML
		{
			var descriptor : Descriptor = getDescriptorFromDescription( failure.description );
			var type : String = failure.testHeader;
			var message : String = failure.description + failure.stackTrace;
					
			var xml : XML =
				<failure type={ "" }>
					{ message }
				</failure>;
					
			return xml;
		}
		
		
		/**
		 * Event listener to handle data received on the socket.
		 * @param event the DataEvent.
		 */
		private function dataHandler( event : DataEvent ) : void
		{
			var data : String = event.data;

			// If we received an acknowledgement finish-up.			
			if ( data == END_OF_TEST_ACK )
			{
				exit();
   			}
		}
		
		/**
		 * Exit the test runner and close the player.
		 */
		private function exit() : void
		{
			// Close the socket.
			socket.close();
		}
	}
}