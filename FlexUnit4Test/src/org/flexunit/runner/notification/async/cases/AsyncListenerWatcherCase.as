package org.flexunit.runner.notification.async.cases
{
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.internals.mocks.LoggerMock;
	import org.flexunit.runner.notification.mocks.AsyncCompletionRunListenerMock;
	import org.flexunit.runner.notification.mocks.AsyncStartupRunListenerMock;
	import org.flexunit.runner.notification.mocks.RunNotifierMock;
	import org.flexunit.token.AsyncListenersToken;
	import org.flexunit.runner.notification.async.AsyncListenerWatcher;

	public class AsyncListenerWatcherCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		//There needs to be serveral tests added for both of the handlers for LISTENER_READY and LISTENER_FAILED
		
		protected var asyncListenerWatcher:AsyncListenerWatcher;
		protected var runNotifierMock:RunNotifierMock;
		protected var loggerMock:LoggerMock;
		
		[Before(description="Create an instance of the AsyncListenerWatcher class")]
		public function createAsyncListenerWatcher():void {
			runNotifierMock = new RunNotifierMock();
			loggerMock = new LoggerMock();
			asyncListenerWatcher = new AsyncListenerWatcher(runNotifierMock, loggerMock);
		}
		
		[After(description="Remove the reference to the instance of the AsyncListenerWatcher class")]
		public function destroyAsyncListenerWatcher():void {
			asyncListenerWatcher = null;
			runNotifierMock = null;
			loggerMock = null;
		}
		
		[Test(description="Ensure that the startToken returns an instance of AsyncListenersToken")]
		public function getStartUpTokenTest():void {
			Assert.assertTrue( asyncListenerWatcher.startUpToken is AsyncListenersToken );
		}
		
		[Ignore]
		[Test(description="Ensure that the completeToken returns an instance of AsyncListenersToken")]
		public function getCompleteToken():void {
			Assert.assertTrue( asyncListenerWatcher.completeToken is AsyncListenersToken );
		}
		
		[Test(description="Ensure that allListenersReady returns false when there are pending listeners")]
		public function getAllListenersReadyFalseTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).once;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).once;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			Assert.assertFalse( asyncListenerWatcher.allListenersReady );
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that allListenersReady returns true when there are no pending listeners")]
		public function getAllListenersReadyTrueTest():void {
			Assert.assertTrue( asyncListenerWatcher.allListenersReady );
		}
		
		[Test(description="Ensure that allListenersComplete returns false when there are pending listeners")]
		public function getAllListenersCompleteFalseTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).once;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).once;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			Assert.assertFalse( asyncListenerWatcher.allListenersComplete );
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that allListenersComplete returns true when there are no pending listeners")]
		public function getAllListenersCompleteTrueTest():void {
			Assert.assertTrue( asyncListenerWatcher.allListenersComplete );
		}
		
		[Test(description="Ensure that the pendingCount has the correct value based on the number of listener's that are still pending")]
		public function getPendingCountTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).once;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).once;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			Assert.assertEquals( 1, asyncListenerWatcher.pendingCount );
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that the totalCount has the correct value based on the number of listener's that have been watched")]
		public function getTotalCountTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).once;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).once;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			Assert.assertEquals( 1, asyncListenerWatcher.totalCount );
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that the unwatchListener correctly operates when an object that implements IAsyncStartupRunListener is not ready")]
		public function unwatchListenerStartupNotReadyTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("removezEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false).once;
			asyncStartupRunListenerMock.mock.method("removezEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false).once;
			
			asyncListenerWatcher.unwatchListener(asyncStartupRunListenerMock);
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that the unwatchListener correctly operates when an object that implements IAsyncStartupRunListener is ready")]
		public function unwatchListenerStartupReadyTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(true);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("removezEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false).never;
			asyncStartupRunListenerMock.mock.method("removezEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false).never;
			
			asyncListenerWatcher.unwatchListener(asyncStartupRunListenerMock);
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		//TODO: This test is currently impossible because unwatch will not accept a class that implements IAsyncCompletionRunListener
		//Is there a way to differentiate this test from the inwatchListenerStartupReadyTest?
		[Ignore("Unwatch will not accept a class that implements IAsyncCompletionRunListener")]
		[Test(description="Ensure that the unwatchListener correctly opperates with an object that implements IAsyncCompletionRunListener")]
		public function unwatchListenerCompletionTest():void {
			var asyncCompletionRunListener:AsyncCompletionRunListenerMock = new AsyncCompletionRunListenerMock();
			asyncCompletionRunListener.mock.property("ready").returns(true);
			
			//asyncListenerWatcher.unwatchListener(asyncCompletionRunListener);
		}
		
		[Test(description="Ensure that the watchListener correctly operates when an object that implements IAsyncStartupRunListener is not ready")]
		public function watchListenerStartupNotReadyTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(false);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).once;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).once;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		[Test(description="Ensure that the watchListener correctly operates when an object that implements IAsyncStartupRunListener is ready")]
		public function watchListenerStartupReadyTest():void {
			var asyncStartupRunListenerMock:AsyncStartupRunListenerMock = new AsyncStartupRunListenerMock();
			asyncStartupRunListenerMock.mock.property("ready").returns(true);
			
			//Set expectations
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_READY, Function, false, 0, false).never;
			asyncStartupRunListenerMock.mock.method("addzEventListener").withArgs(AsyncListenerWatcher.LISTENER_FAILED, Function, false, 0, false).never;
			
			asyncListenerWatcher.watchListener(asyncStartupRunListenerMock);
			
			//Verify expectations were met
			asyncStartupRunListenerMock.mock.verify();
		}
		
		//TODO: This test is currently impossible because watch will not accept a class that implements IAsyncCompletionRunListener
		//Is there a way to differentiate this test from the watchListenerStartupReadyTest?
		[Ignore("Unwatch will not accept a class that implements IAsyncCompletionRunListener")]
		[Test(description="Ensure that the watchListener correctly opperates with an object that implements IAsyncCompletionRunListener")]
		public function watchListenerCompletionTest():void {
			var asyncCompletionRunListener:AsyncCompletionRunListenerMock = new AsyncCompletionRunListenerMock();
			asyncCompletionRunListener.mock.property("ready").returns(true);
			
			//asyncListenerWatcher.watchListener(asyncCompletionRunListener);
		}
	}
}