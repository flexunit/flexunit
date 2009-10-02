package org.fluint.sequence.cases
{
	import mx.binding.utils.ChangeWatcher;
	import mx.events.PropertyChangeEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.AsyncLocator;
	import org.flexunit.async.mocks.EventDispatcherMock;
	import org.flexunit.internals.runners.statements.mock.AsyncHandlingStatementMock;
	import org.fluint.sequence.SequenceBindingWaiter;
	import org.fluint.sequence.mocks.SequenceRunnerMock;

	public class SequenceBindingWaiterCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var sequenceBindingWaiter:SequenceBindingWaiter;
		protected var target:EventDispatcherMock;
		protected var propertyName:String;
		protected var timeout:int;
		protected var timeoutHandler:Function;
		
		[Before(description="Create an instance of the SequenceBindingWaiter class")]
		public function createSequenceBindingWaiter():void {
			target = new EventDispatcherMock();
			propertyName = "testProperty";
			timeout = 2000;
			timeoutHandler = new Function();
			sequenceBindingWaiter = new SequenceBindingWaiter(target, propertyName, timeout, timeoutHandler);
		}
		
		[After(description="Remove the reference to the instance of the SequenceBindingWaiter class")]
		public function destroySequenceBindingWaiter():void {
			sequenceBindingWaiter = null;
			target = null;
			propertyName = null;
			timeout = NaN;
			timeoutHandler = null;
		}
		
		[Test(description="Ensure that the target property is correctly obtained")]
		public function getTargetTest():void {
			Assert.assertEquals( target, sequenceBindingWaiter.target );
		}
		
		[Test(description="Ensure that the eventName property is correctly obtained")]
		public function geteventNameTest():void {
			Assert.assertEquals( PropertyChangeEvent.PROPERTY_CHANGE, sequenceBindingWaiter.eventName );
		}
		
		[Test(description="Ensure that the propertyName property is correctly obtained")]
		public function getPropertyNameTest():void {
			Assert.assertEquals( propertyName, sequenceBindingWaiter.propertyName );
		}
		
		[Test(description="Ensure that the timeout property is correctly obtained")]
		public function getTimeoutTest():void {
			Assert.assertEquals( timeout, sequenceBindingWaiter.timeout );
		}
		
		[Test(description="Ensure that the timeoutHandler property is correctly obtained")]
		public function getTimeoutHandlerTest():void {
			Assert.assertEquals( timeoutHandler, sequenceBindingWaiter.timeoutHandler );
		}
		
		[Test(description="Ensure that the setupListeners function sets the change watcher is the target contains a watchable property")]
		public function setupListenersSuccessTest():void {
			var testCase:Object = new Object();
			var sequence:SequenceRunnerMock = new SequenceRunnerMock();
			
			//Create an AsyncHandlingStatementMock and register it to to the AsyncLocator
			var asyncHandlingStatementMock:AsyncHandlingStatementMock = new AsyncHandlingStatementMock();
			AsyncLocator.registerStatementForTest(asyncHandlingStatementMock, testCase);
			
			//Set expectations
			asyncHandlingStatementMock.mock.method("asyncHandler").withArgs( asyncHandlingStatementMock.handleBindableNextSequence, timeout, sequence, timeoutHandler).once.returns(new Function());
			target.mock.method("addzEventListener").withAnyArgs.once;
			
			sequenceBindingWaiter.setupListeners(testCase, sequence);
			
			Assert.assertTrue( sequenceBindingWaiter.changeWatcher is ChangeWatcher );
			
			//Verify expectations were met
			asyncHandlingStatementMock.mock.verify();
			target.mock.verify();
			
			//Remove the reference from the AsyncLocator for the testCase
			AsyncLocator.cleanUpCallableForTest(testCase);
		}
		
		[Test(expects="Error",
			description="Ensure that the setupListeners function throws an exception if the target does not contain a watchable property")]
		public function setupListenersExceptionTest():void {
			var testCase:Object = new Object();
			var sequence:SequenceRunnerMock = new SequenceRunnerMock();
			
			sequenceBindingWaiter.setupListeners(testCase, sequence);
			
			Assert.assertTrue( sequenceBindingWaiter.changeWatcher is ChangeWatcher );
		}
	}
}