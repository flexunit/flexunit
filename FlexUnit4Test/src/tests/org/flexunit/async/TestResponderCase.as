package tests.org.flexunit.async {
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.async.ITestResponder;
	import org.flexunit.async.TestResponder;
	
	public class TestResponderCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var responderMock:ITestResponder;
		
		[Test(description="Ensure the result function is correctly called")]
		public function shouldInvokeResultWithData():void {
			var data:Object = new Object();
			var passThrough:Object = new Object();
			var responder:TestResponder = new TestResponder( responderMock.result, responderMock.fault );

			stub( responderMock ).method( "result" ).args( data, passThrough ).once();
			stub( responderMock ).method( "fault" ).never();
			
			responder.result( data, passThrough );
		}
		
		[Test(description="Ensure the fault function is correctly called")]
		public function shouldInvokeFaultWithData():void {
			var info:Object = new Object();
			var passThrough:Object = new Object();
			var responder:TestResponder = new TestResponder( responderMock.result, responderMock.fault );
			
			stub( responderMock ).method( "fault" ).args( info, passThrough ).once();
			stub( responderMock ).method( "result" ).never();
			
			responder.fault( info, passThrough );
		}
	}
}