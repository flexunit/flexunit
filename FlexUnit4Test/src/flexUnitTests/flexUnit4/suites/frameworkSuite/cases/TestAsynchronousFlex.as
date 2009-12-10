package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import flash.utils.Timer;
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.helper.MySpecialResponder;
	
	import mx.core.mx_internal;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.flexunit.async.TestResponder;

	public class TestAsynchronousFlex
	{
		protected var timer:Timer;
		protected static var LONG_TIME:int = 250;
		
		[Before]
		public function setUp():void {
			timer = new Timer( LONG_TIME, 1 );
		}
		
		[After]
		public function tearDown():void {
			if ( timer ) {
				timer.stop();
			}
			
			timer = null;
		}
		
		[Test(async)]
		public function testAsyncResponderResultWithTestResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new TestResponder( handleIntendedResult, handleUnintendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var result:ResultEvent = new ResultEvent( ResultEvent.RESULT, false, false, {myName:someVO.myName}, token, null );			
			token.mx_internal::applyResult( result );
			
		}
		
		[Test(async)]
		public function testAsyncResponderFaultWithTestResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new TestResponder( handleUnintendedResult, handleIntendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var fault:FaultEvent = new FaultEvent( FaultEvent.FAULT );	
			token.mx_internal::applyFault( fault );
			
		}
		
		[Test(async)]
		public function testAsyncResponderResultWithIResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new Responder( handleIntendedResultNoPassThrough, handleUnintendedFault ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var result:ResultEvent = new ResultEvent( ResultEvent.RESULT, false, false, {myName:someVO.myName}, token, null );			
			token.mx_internal::applyResult( result );
			
		}
		
		[Test(async)]
		public function testAsyncResponderFaultWithIResponder() : void {
			var someVO:Object = new Object();
			someVO.myName = 'Mike Labriola';
			someVO.yourAddress = '1@2.com';
			
			var responder:IResponder = Async.asyncResponder( this, new Responder( handleUnintendedResult, handleIntendedFaultNoPassThrough ), 50, someVO );
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var fault:FaultEvent = new FaultEvent( FaultEvent.FAULT );	
			token.mx_internal::applyFault( fault );
			
		}
		
		[Test(async)]
		public function testAsyncResponderResultWithExternalResponder() : void {
			var specialResponder:MySpecialResponder = new MySpecialResponder( specialResponderResultHandler, specialResponderFaultHandler );
			
			var responder:MySpecialResponder = Async.asyncResponder( this, specialResponder, 50 ) as MySpecialResponder;
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var result:ResultEvent = new ResultEvent( ResultEvent.RESULT, false, false, {myString:'abc123'}, token, null );			
			token.mx_internal::applyResult( result );
		}
		
		[Test(async,expects="flexunit.framework.AssertionFailedError")]
		public function testAsyncResponderFaultWithExternalResponder() : void {
			var specialResponder:MySpecialResponder = new MySpecialResponder( specialResponderResultHandler, specialResponderFaultHandler );
			
			var responder:MySpecialResponder = Async.asyncResponder( this, specialResponder, 50 ) as MySpecialResponder;
			var token:AsyncToken = new AsyncToken( null );
			token.addResponder( responder );
			
			var fault:FaultEvent = new FaultEvent( FaultEvent.FAULT );	
			token.mx_internal::applyFault( fault );
		}
		
		protected function handleIntendedResultNoPassThrough( data:Object ):void {			
		}
		
		protected function handleIntendedResult( data:Object, passThroughData:Object ):void {
			Assert.assertEquals( data.result.myName, passThroughData.myName );
		}
		
		protected function handleUnintendedResult( info:Object, passThroughData:Object ):void {
			Assert.fail("Responder threw a result when fault was expected");
		}
		
		protected function handleIntendedFaultNoPassThrough( info:Object ):void {			
		}
		
		protected function handleIntendedFault( info:Object, passThroughData:Object ):void {			
		}
		
		protected function handleUnintendedFault( info:Object, passThroughData:Object ):void {
			Assert.fail("Responder threw a fault when result was expected");
		}
		
		protected function specialResponderResultHandler( data:Object ):void {
			Assert.assertNotNull( data );
			Assert.assertNotNull( data.result );
			Assert.assertNotNull( data.result.myString );
			Assert.assertEquals( data.result.myString, 'abc123' );
		}
		
		protected function specialResponderFaultHandler( info:Object ):void {
			Assert.fail("Reached the Fault Handler");
		}
	}
}